#MaxThreadsPerHotkey 2

;Recarga el script
~Right::Reload
Sleep, 200
Return

;Cierra
f12::ExitApp 

;LOOP r (spamea recarga)
f4::
Toggle := !Toggle
Loop
{
If (!Toggle)
Break
Sendinput {r Down}
Sleep, 100
Sendinput {r Up}
}
Return

;corre automaticamente con capslock
~CapsLock::
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

;Mantiene apretado F por 5 segundos con J.
~j::
{
Sleep, 200
SendInput, {f Down}
Sleep, 7000
SendInput, {f Up}
}
Return

;Mantiene apretado el click izq con `
`::
KeyDown := !KeyDown
If KeyDown
SendInput {Click down}
Else
SendInput {Click up}
Return

;Recarga
~f5::
{
Gosub DELAY
Gosub AMMO
}
Return

;Recarga y dispara
~f6::
{
Gosub DELAY
Gosub AMMO
Gosub SHOOT
}
Return

;4 tiros(DISPERSION 15 MTS A 800 MTS)
~f7::
{
Gosub DELAY
SendInput, {f2 Down}
Sleep, 1500
SendInput, {f2 Up}
Sleep, Random, rand, 10, 40
Sendinput {r Down}
Sendinput {r Down}
Sendinput {r Up}
Sleep, 3400
SendInput, {f1 Down}
Sleep, 1500
SendInput, {f1 Up}
SendInput, {a Down}
Sleep, 200
SendInput, {f2 Down}
Sleep, 800
SendInput, {a Up}
Gosub SHOOT
Sleep, 500
SendInput, {f2 Up}
Sleep, Random, rand, 10, 40
Sendinput {r Down}
Sendinput {r Down}
Sendinput {r Up}
Sleep, 3400
SendInput, {f1 Down}
Sleep, 1500
SendInput, {f1 Up}
SendInput, {d Down}
Sleep, 200
SendInput, {f2 Down}
Sleep, 800
SendInput, {d Up}
Gosub SHOOT
Sleep, 500
SendInput, {f2 Up}
Sleep, Random, rand, 10, 40
Sendinput {r Down}
Sendinput {r Down}
Sendinput {r Up}
Sendinput {r Up}
Sleep, 3400
SendInput, {f1 Down}
Sleep, 1500
SendInput, {f1 Up}
SendInput, {d Down}
Sleep, 200
SendInput, {f2 Down}
Sleep, 800
SendInput, {d Up}
Gosub SHOOT
Sleep, 500
SendInput, {f2 Up}
Sleep, Random, rand, 10, 40
Sendinput {r Down}
Sendinput {r Down}
Sendinput {r Up}
Sleep, 3400
SendInput, {f1 Down}
Sleep, 1500
SendInput, {f1 Up}
}
Return

;3 tiros (fire mission)
~f8::
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

;LOOP Recarga y dispara
~f9::
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

;4 TIROS LOOP (DISPERSION 15 MTS A 800 MTS)
~f10::
Toggle := !Toggle
Loop
{
If (!Toggle)
Break
Gosub DELAY
SendInput, {f2 Down}
Sleep, 1500
SendInput, {f2 Up}
Sleep, Random, rand, 10, 40
Sendinput {r Down}
Sendinput {r Down}
Sendinput {r Up}
Sleep, 3400
SendInput, {f1 Down}
Sleep, 1500
SendInput, {f1 Up}
SendInput, {a Down}
Sleep, 200
SendInput, {f2 Down}
Sleep, 800
SendInput, {a Up}
Gosub SHOOT
Sleep, 500
SendInput, {f2 Up}
Sleep, Random, rand, 10, 40
Sendinput {r Down}
Sendinput {r Down}
Sendinput {r Up}
Sleep, 3400
SendInput, {f1 Down}
Sleep, 1500
SendInput, {f1 Up}
SendInput, {d Down}
Sleep, 200
SendInput, {f2 Down}
Sleep, 800
SendInput, {d Up}
Gosub SHOOT
Sleep, 500
SendInput, {f2 Up}
Sleep, Random, rand, 10, 40
Sendinput {r Down}
Sendinput {r Down}
Sendinput {r Up}
Sleep, 3400
SendInput, {f1 Down}
Sleep, 1500
SendInput, {f1 Up}
SendInput, {d Down}
Sleep, 200
SendInput, {f2 Down}
Sleep, 800
SendInput, {d Up}
Gosub SHOOT
Sleep, 500
SendInput, {f2 Up}
Sleep, Random, rand, 10, 40
Sendinput {r Down}
Sendinput {r Down}
Sendinput {r Up}
Sleep, 3400
SendInput, {f1 Down}
Sleep, 1500
SendInput, {f1 Up}
SendInput, {a Down}
Sleep, 200
Sleep, 800
SendInput, {a Up}
}
Return

~f11::
{
Goto CHATY
}
Return

;LABELS
AMMO:
SendInput, {f2 Down}
Sleep, 1500
SendInput, {f2 Up}
Sleep, Random, rand, 10, 40
Sendinput {r Down}
Sendinput {r Down}
Sendinput {r Up}
Sleep, 3400
SendInput, {f1 Down}
Sleep, 1500
SendInput, {f1 Up}
return

SHOOT:
Sleep, Random, rand, 10, 40
SendInput {Click down}
SendInput {Click down}
SendInput {Click up}
return

DELAY:
Sleep, 200
SendInput {Click down}
SendInput {Click up}
return

CHATY:
Random, rand, 21, 23
SendInput {k Down}
SendInput {k Up}
SendInput, >fire stop, approx{space}
SendInput, %rand%
SendInput, {space}secs.
SendInput {enter Down}
SendInput {enter Up}
return
