(===================================================================)
( CIM 36-PIECE SORTER — FIXED VERSION                             )
(===================================================================)
( FIX 1: Rejects now route to the rejects bin (X315) correctly    )
( FIX 2: Arm retraction uses bottom side path (negative X sweep)  )
(         so next cycle approaches from the correct direction      )
(===================================================================)

G90 ; Absolute positioning
G21 ; Metric units
G18 ; ZX plane selection
G92 X0 Y0 Z120 A0 B0 ; Origin reset

#100 = 1200 ; Rapid travel speed mm/min
#101 = 450  ; Plunge feedrate mm/min

#120 = -385 ; Pick station center line (X)
#121 = 140  ; Conveyor reference

( --- Bin center coordinates --- )
#130 = 255  ; RED bin X
#131 = 195  ; GREEN bin X
#132 = 135  ; BLUE bin X
#133 = 315  ; REJECT bin X (FIX 1: explicit reject bin)

O100 REPEAT [36]

( ========================= )
( CYCLE INITIATION: SECTOR  )
( ========================= )

G01 X0 Z120 A0 B0 F[#100]
M03 S1 ; Start conveyor motor
M66 P1 L3 Q10 ; Interlock: wait for sensor
M03 S0 ; Halt conveyor motor

( ========================= )
( STAGED KINEMATICS PICKUP  )
( ========================= )

G01 X-320 Z80 F800     ; Staged approach
G01 X-360 Z40 F600     ; Intermediate descent
G01 X-385 Z-60 F400    ; Final pickup dive

M05 P1 ; Engage vacuum
G04 P400 ; Pressure stabilize

G01 X-360 Z20 F600     ; Staged lift
G01 X-300 Z80 F900     ; Return to travel height

( ========================= )
( REAL-TIME COLOR SENSING   )
( ========================= )

#200 = AI1 ; Red sensor
#201 = AI2 ; Green sensor
#202 = AI3 ; Blue sensor

( FIX 1: Default to REJECT bin (X315) )
#104 = #133 ; Default: REJECT BIN

IF [#200 > 150] THEN #104 = #130 ; RED
IF [#201 > 150] THEN #104 = #131 ; GREEN  
IF [#202 > 150] THEN #104 = #132 ; BLUE

( ========================= )
( DISPATCH TO BIN           )
( ========================= )

G01 X[#104] Z80 A0 B45 F900      ; Rapid sweep to target bin
G01 X[#104] Z20 A-60 B180 F500   ; Direct alignment slide
G01 X[#104] Z-50 A-85 B180 F400  ; Final deposit plunge

M05 P0 ; Release vacuum
G04 P350 ; Dwell for release

( ========================= )
( ARM RETRACTION — BOTTOM SIDE )( FIX 2: retract via negative X )
( ========================= )

G01 X-320 Z40 A-40 B180 F900     ; Pull back downward (negative X)
G01 X-300 Z80 F800               ; Rise to safe travel height  
G01 X0 Z120 A0 B0 F1200          ; Return home for next cycle

O100 ENDREPEAT

M30 ; End of program
