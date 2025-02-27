10 HX$ = "0123456789ABCDEFGHJKLMNPQRSTUVWXYZ"
15 DIM NN$(11)
20 ? "**************************************"
25 ? "                                      "
30 ? "    TRAVELLER MAINWORLD GENERATOR     "
40 ? "                                      "
50 ? "    INSTRUCTIONS:                     "
60 ? "    ENTER A 4-DIGIT 'RING' COORD      "
70 ? "    AND A 5-DIGIT 'RAY' COORD         "
75 ? "                                      "
80 ? "    GENERATES A ROW OF 10 'HEXES'     "
85 ? "                                      "
90 ? "**************************************"
100 RI = 9930 : REM FOR EXAMPLE
110 RA = 62723
120 INPUT "RING (4 DIGITS)"; RI
130 INPUT "RAY (5 DIGITS)"; RA
131 ? RI "RING/RAY" RA : ?
140 FOR RI = RI TO RI + 9
141 GOSUB 1100: REM COL+ROW
160 GOSUB 200: REM INIT
165 IF P = 0 THEN ? CR$ " *":GOTO 195
170 GOSUB 1000: REM UWP
172 GOSUB 1200: REM NAME
173 RS$ = "  ": REM SPECIAL REMARKS (N/A)
174 GOSUB 1300: REM BASES
175 GOSUB 1350: REM B+G
176 Z$ = " ": REM ZONE (N/A)
177 AL$ = "  ": REM ALLEG (N/A)
180 REM ? CR$ Z$ NA$ UW$ BA$ " " BG$ " " RM$
181 ? CR$ " " NA$ " " UW$ " " BA$ " " BG$ " " RM$
195 NEXT RI
199 END

200 REM ------------------------
201 REM INITIALIZE DICE
202 REM ------------------------
205 RR = RI*10000 + RA
210 P=RND(-RR)
215 REM ------------------------
216 REM SYSTEM PRESENCE
217 REM ------------------------
219 P=RND(1)
220 IF P >= 0.5 THEN P=1
221 IF P <  0.5 THEN P=0
249 RETURN

250 REM ------------------------
251 REM ROLL DICE
252 REM ------------------------
255 DM = 0:GOTO 270
260 DM = -1:GOTO 270
265 DM = -2
270 D1 = INT(RND(1)*6)+1
275 D2 = INT(RND(1)*6) + INT(RND(1)*6) + 2 + DM
280 DF = INT(RND(1)*6) - INT(RND(1)*6) + DM
299 RETURN

300 REM ------------------------
301 REM STARPORT
302 REM ------------------------
305 GOSUB 260
307 SP$ = MID$("XXEEDDCCBBAAAA",D2,1)
309 RETURN 

310 REM ------------------------
311 REM SIZE, ATMOSPHERE, HYDRO
312 REM ------------------------
315 GOSUB 265: SZ = D2
320 GOSUB 250: AT = DF + SZ
325 IF AT < 0 OR SZ = 0 THEN AT = 0
330 GOSUB 250: HY = DF + AT
335 IF HY < 0 THEN HY = 0
336 IF AT = 0 THEN HY = 0
340 IF HY > 10 THEN HY = 10
341 SZ$ = MID$(HX$,SZ+1,1)
342 AT$ = MID$(HX$,AT+1,1)
343 HY$ = MID$(HX$,HY+1,1)
349 RETURN

350 REM ------------------------
351 REM POP, GOV, LAW
352 REM ------------------------
355 GOSUB 265: PO = D2
360 GOSUB 250: GV = DF + PO
365 IF GV < 0 THEN GV = 0
370 GOSUB 250: LA = DF + GV
375 IF LA < 0 THEN LA = 0
380 PO$ = MID$(HX$,PO+1,1)
381 GV$ = MID$(HX$,GV+1,1)
382 LA$ = MID$(HX$,LA+1,1)
399 RETURN

400 REM ------------------------
401 REM TL
402 REM ------------------------
405 GOSUB 250: TL = D1
410 IF SP$ = "A" THEN TL = TL + 6
411 IF SP$ = "B" THEN TL = TL + 4
412 IF SP$ = "C" THEN TL = TL + 2
413 IF SP$ = "X" THEN TL = TL - 4
414 IF SZ < 2 THEN TL = TL + 1
415 IF SZ < 5 THEN TL = TL + 1
416 IF HY = 9 THEN TL = TL + 1
417 IF HY = 10 THEN TL = TL + 2
418 IF PO > 0 AND PO < 6 THEN TL = TL + 1
419 IF PO = 2 THEN TL = TL + 2
420 IF PO > 9 THEN TL = TL + 4
421 IF GV = 0 THEN TL = TL + 1
422 IF GV = 5 THEN TL = TL + 1
423 IF GV = 13 THEN TL = TL + 2
424 IF TL < 0 THEN TL = 0
425 TL$ = MID$(HX$,TL+1,1)
449 RETURN 

500 REM ------------------------
501 REM REMARKS (UW$ REQUIRED)
502 REM ------------------------
510 RM$ = ""
511 IN$ = ".444..-. .988..-. AG":GOSUB 550 
512 IN$ = "000...-. 000...-. AS":GOSUB 550
513 IN$ = "...0..-0 ...0..-0 BA":GOSUB 550
514 IN$ = "200...-. 900...-. DE":GOSUB 550
515 IN$ = "...0..-1 ...0..-Z DI":GOSUB 550
516 IN$ = ".A1...-. .CA...-. FL":GOSUB 550
517 IN$ = "655...-. 887...-. GA":GOSUB 550
518 IN$ = "320...-. CC2...-. HE":GOSUB 550
519 IN$ = "...9..-. ...F..-. HI":GOSUB 550
520 IN$ = ".01...-. .1A...-. IC":GOSUB 550
521 REM IN /^..[012479ABC].[9A-F]/
522 IF PO < 9 GOTO 525
523 IF AT < 3 OR AT = 4 OR AT = 7 OR AT > 8 THEN RM$ = RM$ + " IN"
525 IN$ = "...1..-. ...3..-. LO":GOSUB 550 
526 IN$ = ".006..-. .33F..-. NA":GOSUB 550 
527 IN$ = "...4..-. ...6..-. NI":GOSUB 550 
528 IN$ = ".20...-. .53...-. PO":GOSUB 550  
530 REM RI /^..[68].[678]/
531 IF AT <> 6 AND AT <> 8 GOTO 535
532 IF PO > 5 AND PO < 9 THEN RM$ = RM$ + " RI"
535 IN$ = "A3A...-. FFA...-. OC":GOSUB 550
536 IN$ = ".0....-. .0....-. VA":GOSUB 550
537 IN$ = "33A...-. 9FA...-. WA":GOSUB 550
545 RM$ = MID$(RM$,2): REM +"                ",2,15)
549 RETURN

550 REM ------------------------
551 REM LOOP CHECK IN$
552 REM IN$ = "320...-. CC2...-. HE"
553 REM UW$ = "A11567-8"
554 REM ------------------------
555 M = 0:FOR X = 1 TO 8
560 CC$ = MID$(UW$,X+1,1)
565 LO$ = MID$(IN$,X,1)
570 HI$ = MID$(IN$,X+9,1)
571 REM ? CC$;
575 IF LO$ = "." GOTO 590
580 IF CC$ < LO$ GOTO 599
585 IF CC$ > HI$ GOTO 599
590 M = M + 1
595 NEXT
597 IF M = 8 THEN RM$ = RM$ + " " + MID$(IN$,19,2)
599 RETURN

1000 REM ------------------------
1001 REM DETERMINE UWP
1002 REM ------------------------
1010 GOSUB 300: REM SP$
1020 GOSUB 310: REM SZ AT HY
1030 GOSUB 350: REM PO GV LA
1040 GOSUB 400: REM TL
1045 REM ? "UWP: " SP$; SZ; AT; HY; PO; GV; LA; "-" TL
1050 UW$ = SP$ + SZ$ + AT$ + HY$ + PO$ + GV$ + LA$ + "-" + TL$
1060 GOSUB 500: REM RM$
1099 RETURN

1100 REM ------------------------
1101 REM DETERMINE HEX
1102 REM ------------------------
1110 C% = INT(RA-INT(RA/32)*32)+1
1120 R% = INT(RI-INT(RI/40)*40)+1
1130 CR$ = RIGHT$(STR$(C%),2) + RIGHT$(STR$(R%),2)
1135 IF LEFT$(CR$,1) = " " THEN CR$ = "0" + RIGHT$(CR$,3)
1140 IF MID$(CR$,3,1) = " " THEN CR$ = LEFT$(CR$,2) + "0" + RIGHT$(CR$,1)
1190 RETURN

1200 REM ------------------------
1201 REM DETERMINE NAME
1202 REM ------------------------
1210 NN$(0) = "CO DA AS SI ME EA AR RA IZ AT TA DA RA LE IG EN "
1211 NN$(1) = "IX AG TI ID RO GA EX OX LO CA NI ME LI TO LA WO "
1212 NN$(2) = "DE RU DE AG RO PO TA SE IN MO LU DE RI PE ST ER "
1213 NN$(3) = "ST RO TA SO AR RU WA WO AD AK WA EN EG DE AC OC "
1214 NN$(4) = "OP OR PA RE RI NU TI VE WI VI JU MO ME NE UT A  "
1215 NN$(5) = "I  U  E  O  BECTLEFLESHOONAORAPHOSHOFORGUELANLAS"
1216 NN$(6) = "DENTINARTORTERTANGINGENGONGANTONTINTINDUNDENDTRI"
1217 NN$(7) = "ITOMERALUBELDECREMMENDUCSCOTHEDREOWNEPICENCANSAR"
1218 NN$(8) = "GENTERAGEATEBITHENHOSGRAGNOCIDCANARDCORCREOUSATH"
1219 NN$(9) = "AINWHELUCLINMATMEDMISMELMARNECNORNESNOUOSTPELPRO"
1220 NN$(10) = "PORPRIPLAFRIREGSANSALINESOLSEMSECSULSCASCISHERAN"
1221 NN$(11) = "MERMIRSPISTATECAPHTELTOLTOMTENTORTERLOCVALVERERG"

1260 P = RND(1)
1265 NA$ = ""
1270 X = 3 : IF P <= 0.15 THEN X = 2
1275 FOR Y = 1 TO X
1280 NR% = RND(1)*12
1281 NC% = INT(RND(1)*16) * 3 + 1
1283 F$ = MID$(NN$(NR%),NC%,3)
1285 NA$ = NA$ + F$ : LN = LEN(NA$)
1290 IF RIGHT$(NA$,1) = " " THEN NA$ = LEFT$(NA$,LN-1)
1295 NEXT
1298 NA$ = LEFT$(NA$+"               ",10)
1299 RETURN 

1300 REM ------------------------
1301 REM DETERMINE BASES
1302 REM ------------------------
1310 GOSUB 260
1315 N$ = " ":S$ = " ":BA=1
1320 IF SP$ = "A" THEN N$ = MID$("NNNNN      ",D2,1)
1321 IF SP$ = "B" THEN N$ = MID$("NNN        ",D2,1)
1330 IF SP$ = "A" THEN S$ = MID$("SSS        ",D2,1)
1331 IF SP$ = "B" THEN S$ = MID$("SSSS       ",D2,1)
1332 IF SP$ = "C" THEN S$ = MID$("SSSSS      ",D2,1)
1333 IF SP$ = "D" THEN S$ = MID$("SSSS       ",D2,1)
1340 IF N$ = "N" THEN BA = BA + 1
1341 IF N$ = "S" THEN BA = BA + 2
1345 BA$ = MID$(" NSA",BA,1)
1349 RETURN

1350 REM ------------------------
1351 REM BELTS AND GAS GIANTS
1352 REM ------------------------
1360 GOSUB 260
1370 B$ = MID$("00000112223", D2, 1)
1375 GOSUB 260
1380 G$ = MID$("00000112345", D2, 1)
1390 BG = 1
1391 IF B$ > "0" THEN BG = 2
1392 IF G$ > "0" THEN BG = BG + 2
1395 BG$ = MID$(" BG2",BG,1)
1399 RETURN
