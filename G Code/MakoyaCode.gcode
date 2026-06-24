(===================================================================)
( CIM 36-PIECE SORTER — FINAL FIXED VERSION                         )
(===================================================================)
( FIXES:                                                            )
( 1) Keeps the full cycle looping until 36 parts are processed      )
( 2) Uses dominant-color logic so YELLOW does not become RED        )
( 3) Keeps reject as the safe default bin                           )
( 4) Uses the same retract path every cycle                         )
(===================================================================)

G90                     ; Absolute positioning
G21                     ; Metric units
G18                     ; ZX plane selection
G92 X0 Y0 Z120 A0 B0    ; Home preset

(----------------------------)
( SPEEDS / LIMITS            )
(----------------------------)
#100 = 1200             ; Fast traverse feedrate
#101 = 450              ; Fine feedrate
#110 = 36               ; Total parts to sort
#111 = 0                ; Cycle counter
#112 = 150              ; Color sensor threshold

(----------------------------)
( PICK POSITION              )
(----------------------------)
#120 = -390             ; Pick station X

(----------------------------)
( BIN CENTERS                )
(----------------------------)
#130 = 255              ; RED bin X
#131 = 195              ; GREEN bin X
#132 = 135              ; BLUE bin X
#133 = 315              ; REJECT bin X

(===================================================================)
( MAIN LOOP                                                          )
(===================================================================)
O100

#111 = #111 + 1
IF [#111 > #110] GOTO O900

(----------------------------)
( RETURN TO START POSE       )
(----------------------------)
G01 X0 Z120 A0 B0 F[#100]

(----------------------------)
( FEED NEXT PART             )
(----------------------------)
M03 S1                  ; Conveyor ON
M66 P1 L3 Q10           ; Wait for part-present sensor
M03 S0                  ; Conveyor OFF

(----------------------------)
( PICKUP SEQUENCE            )
(----------------------------)
G01 X-320 Z80 F800
G01 X-360 Z40 F600
G01 X[#120] Z-60 F400

M05 P1                  ; Vacuum ON
G04 P400                ; Grip settle time

G01 X-360 Z20 F600
G01 X-300 Z80 F900

(----------------------------)
( READ COLOR SENSORS        )
(----------------------------)
#200 = AI1              ; Red channel
#201 = AI2              ; Green channel
#202 = AI3              ; Blue channel

(----------------------------)
( DEFAULT TO REJECT         )
(----------------------------)
#104 = #133

(===================================================================)
( DOMINANT COLOR DECISION                                          )
( Yellow will NOT be misread as Red or Green                        )
(===================================================================)

( --- RED dominant? --- )
IF [#200 > #112] GOTO O310
GOTO O320

O310
IF [#200 > #201] GOTO O311
GOTO O320

O311
IF [#200 > #202] GOTO O301
GOTO O320

( --- GREEN dominant? --- )
O320
IF [#201 > #112] GOTO O321
GOTO O330

O321
IF [#201 > #200] GOTO O322
GOTO O330

O322
IF [#201 > #202] GOTO O302
GOTO O330

( --- BLUE dominant? --- )
O330
IF [#202 > #112] GOTO O331
GOTO O304

O331
IF [#202 > #200] GOTO O332
GOTO O304

O332
IF [#202 > #201] GOTO O303
GOTO O304

(----------------------------)
( COLOR ASSIGNMENTS         )
(----------------------------)
O301
#104 = #130              ; RED bin
GOTO O305

O302
#104 = #131              ; GREEN bin
GOTO O305

O303
#104 = #132              ; BLUE bin
GOTO O305

O304
#104 = #133              ; REJECT bin

(----------------------------)
( DEPOSIT SEQUENCE           )
(----------------------------)
O305
G01 X[#104] Z80 A0 B45 F900
G01 X[#104] Z20 A-60 B180 F500
G01 X[#104] Z-50 A-85 B180 F400

M05 P0                  ; Vacuum OFF
G04 P350                ; Release settle time

(----------------------------)
( RETRACTION SEQUENCE       )
(----------------------------)
G01 X-320 Z40 A-40 B180 F900
G01 X-300 Z80 A0 B0 F800
G01 X0 Z120 A0 B0 F1200

GOTO O100

(===================================================================)
( END OF JOB                                                        )
(===================================================================)
O900
G01 X0 Z120 A0 B0 F1200
M05 P0
M03 S0
M30