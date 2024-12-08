#MaxThreadsPerHotkey 2

~Right::Reload ;Recarga el script
Sleep, 200
Return

f12::ExitApp ;Cierra

f4:: ;LOOP r (spamea recarga)
Toggle := !Toggle
Loop
{
If (!Toggle)
Break
Sendinput {r Down}
Sleep, 200
Sendinput {r Up}
}
Return

~CapsLock:: ;Mantiene "W" con capslock "S" con ctrl+capslock (on/off)
KeyDown := !KeyDown
If KeyDown
SendInput {w down}
Else
SendInput {w up}
Return
^CapsLock::
KeyDown := !KeyDown
If KeyDown
SendInput {s down}
Else
SendInput {s up}
Return

~j:: ;Mantiene apretado F por 5 segundos con J.
{
Sleep, 200
SendInput, {f Down}
Sleep, 7000
SendInput, {f Up}
}
Return

`:: ;Mantiene apretado el click izq con ` (on/off)
KeyDown := !KeyDown
If KeyDown
SendInput {Click down}
Else
SendInput {Click up}
Return

;SCRIPTS ARTILLERIA
~f5:: ;Recarga
{
Gosub DELAY
Gosub AMMO
}
Return

~f6:: ;Recarga y dispara
{
Gosub DELAY
Gosub AMMO
Gosub SHOOT
}
Return

~f7:: ;4 tiros(DISPERSION 15 MTS A 800 MTS)
{
Gosub DELAY
SendInput, {f2 Down}
Sleep, 1500
SendInput, {f2 Up}
Sendinput {r Down}
Sleep, 100
Sendinput {r Up}
Sendinput {r Down}
Sleep, Random, rand, 10, 40
Sendinput {r Up}
Sleep, 3400
SendInput, {f1 Down}
Sleep, 40
SendInput, {f1 Down}
Sleep, 1500
SendInput, {f1 Up}
SendInput, {a Down}
Sleep, 200
SendInput, {f2 Down}
Sleep, 800
SendInput, {a Up}
Gosub SHOOT
Gosub SRCONT
Gosub SHOOT
Gosub SRCONT
Gosub SHOOT
Sleep, 500
SendInput, {f2 Up}
Sendinput {r Down}
Sleep, 100
Sendinput {r Up}
Sendinput {r Down}
Sleep, Random, rand, 10, 40
Sendinput {r Up}
Sleep, 3400
SendInput, {f1 Down}
Sleep, 40
SendInput, {f1 Down}
Sleep, 1500
SendInput, {f1 Up}
}
Return

~f8:: ;3 tiros (fire mission)
{
Gosub DELAY
Gosub AMMO
Gosub SHOOT
Gosub AMMO
Gosub SHOOT
Gosub AMMO
Gosub SHOOT
Gosub CHATY
}
Return

~f9:: ;LOOP Recarga y dispar
Toggle := !Toggle
Loop
{
If (!Toggle)
Break
Gosub DELAY
Gosub AMMO
Gosub SHOOT
}
Return

~f10:: ;4 TIROS LOOP (DISPERSION 15 MTS A 800 MTS)
Toggle := !Toggle
Loop
{
If (!Toggle)
Break
Gosub DELAY
SendInput, {f2 Down}
Sleep, 1500
SendInput, {f2 Up}
Sendinput {r Down}
Sleep, 100
Sendinput {r Up}
Sendinput {r Down}
Sleep, Random, rand, 10, 40
Sendinput {r Up}
Sleep, 3400
SendInput, {f1 Down}
Sleep, 40
SendInput, {f1 Down}
Sleep, 1500
SendInput, {f1 Up}
SendInput, {a Down}
Sleep, 200
SendInput, {f2 Down}
Sleep, 800
SendInput, {a Up}
Gosub SHOOT
Gosub SRCONT
Gosub SHOOT
Gosub SRCONT
Gosub SHOOT
Sleep, 500
SendInput, {f2 Up}
Sendinput {r Down}
Sleep, 100
Sendinput {r Up}
Sendinput {r Down}
Sleep, Random, rand, 10, 40
Sendinput {r Up}
Sleep, 3400
SendInput, {f1 Down}
Sleep, 40
SendInput, {f1 Down}
Sleep, 1500
SendInput, {f1 Up}
SendInput, {a Down}
Sleep, 200
Sleep, 800
SendInput, {a Up}
}
Return

f11:: ;"FIRE MISSION OVER" por chat
{
Sleep, 200
Goto CHATY
}
Return

;LABELS
AMMO:
SendInput, {f2 Down}
Sleep, 1500
SendInput, {f2 Up}
Sendinput {r Down}
Sleep, 100
Sendinput {r Up}
Sendinput {r Down}
Sleep, Random, rand, 10, 40
Sendinput {r Up}
Sleep, 3400
SendInput, {f1 Down}
Sleep, 40
SendInput, {f1 Down}
Sleep, 1500
SendInput, {f1 Up}
return

SHOOT:
Sleep, Random, rand, 10, 40
SendInput {Click down}
Sleep, Random, rand, 10, 40
SendInput {Click down}
SendInput {Click up}
return

DELAY:
Sleep, 200
SendInput {Click down}
Sleep, Random, rand, 10, 40
SendInput {Click down}
SendInput {Click up}
return

CHATY:
Random, rand, 21, 23
SendInput {k Down}
SendInput {k Up}
Send, >fire stop, approx{space}
Send, %rand%
Send, {space}secs.
SendInput {enter Down}
SendInput {enter Up}
return

SRCONT: ;Shoot right continuous, (saves a second by pressing f2 before the shooting take place)
Sleep, 500
SendInput, {f2 Up}
Sendinput {r Down}
Sleep, 100
Sendinput {r Up}
Sendinput {r Down}
Sleep, Random, rand, 10, 40
Sendinput {r Up}
Sleep, 3400
SendInput, {f1 Down}
Sleep, 40
SendInput, {f1 Down}
Sleep, 1500
SendInput, {f1 Up}
SendInput, {d Down}
Sleep, 200
SendInput, {f2 Down}
Sleep, 800
SendInput, {d Up}
return
