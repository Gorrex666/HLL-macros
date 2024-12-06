/*  
F5 Recarga y dispara
F6 Recarga
F7 3 tiros(DISPERSION 15 MTS A 800 MTS)
F8 3 tiros(DISPERSION 30 MTS A 800 MTS)
F9 LOOP Recarga y dispara
F10 LOOP 3 tiros
F11 barrido izq (DISPERSION 15 MTS A 800 MTS)
F12 barrido der (DISPERSION 15 MTS A 800 MTS)
*/

#MaxThreadsPerHotkey 4

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
j::
{
Sleep, 150
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



;Recarga y dispara
~f5::
{
Sleep, 100
SendInput {f2 Down}
Sleep, 1400
SendInput {f2 Up}
Sendinput {r Down}
Sendinput {r Down}
Sleep, 200
Sendinput {r Up}
Sendinput {r Up}
Sleep, 3200
SendInput {f1 Down}
Sleep, 1400
SendInput {f1 Up}
Sleep, 40
SendInput {Click down}
SendInput {Click up}
}
Return

;Recarga
f6::
{
Sleep, 100
SendInput, {f2 Down}
Sleep, 1400
SendInput, {f2 Up}
Sleep, 40
Sendinput {r Down}
Sendinput {r Down}
Sleep, 200
Sendinput {r Up}
Sendinput {r Up}
Sleep, 3200
SendInput, {f1 Down}
Sleep, 1400
SendInput, {f1 Up}
}
Return


;3 tiros(DISPERSION 15 MTS A 800 MTS)
f7::
{
Sleep, 100
SendInput {Click down}
SendInput {Click up}
SendInput, {f2 Down}
Sleep, 1400
SendInput, {f2 Up}
Sleep, 40
Sendinput {r Down}
Sendinput {r Down}
Sleep, 200
Sendinput {r Up}
Sendinput {r Up}
Sleep, 3200
SendInput, {f1 Down}
Sleep, 1400
SendInput, {f1 Up}
SendInput, {a Down}
Sleep, 1000
SendInput, {a Up}
SendInput {Click down}
SendInput {Click up}
SendInput, {f2 Down}
Sleep, 1400
SendInput, {f2 Up}
Sleep, 40
Sleep, Random, rand, 40, 80
Sendinput {r Down}
Sleep, 200
Sendinput {r Up}
Sleep, 3200
SendInput, {f1 Down}
Sleep, 1400
SendInput, {f1 Up}
SendInput, {d Down}
Sleep, 2000
SendInput, {d Up}
SendInput {Click down}
SendInput {Click up}
SendInput, {f2 Down}
Sleep, 1400
SendInput, {f2 Up}
Sleep, 40
Sendinput {r Down}
Sendinput {r Down}
Sleep, 200
Sendinput {r Up}
Sendinput {r Up}
Sleep, 3200
SendInput, {f1 Down}
Sleep, 1400
SendInput, {f1 Up}
}
Return

;3 tiros(DISPERSION 30 MTS A 800 MTS)
f8::
{
Sleep, 100
SendInput {Click down}
SendInput {Click up}
SendInput, {f2 Down}
Sleep, 1400
SendInput, {f2 Up}
Sleep, 40
Sendinput {r Down}
Sendinput {r Down}
Sleep, 200
Sendinput {r Up}
Sendinput {r Up}
Sleep, 3200
SendInput, {f1 Down}
Sleep, 1400
SendInput, {f1 Up}
SendInput, {a Down}
Sleep, 2000
SendInput, {a Up}
SendInput {Click down}
SendInput {Click up}
SendInput, {f2 Down}
Sleep, 1400
SendInput, {f2 Up}
Sleep, 40
Sendinput {r Down}
Sendinput {r Down}
Sleep, 200
Sendinput {r Up}
Sendinput {r Up}
Sleep, 3200
SendInput, {f1 Down}
Sleep, 1400
SendInput, {f1 Up}
SendInput, {d Down}
Sleep, 4000
SendInput, {d Up}
SendInput {Click down}
SendInput {Click up}
SendInput, {f2 Down}
Sleep, 1400
SendInput, {f2 Up}
Sleep, 40
Sendinput {r Down}
Sendinput {r Down}
Sleep, 200
Sendinput {r Up}
Sendinput {r Up}
Sleep, 3200
SendInput, {f1 Down}
Sleep, 1400
SendInput, {f1 Up}
}
Return

;LOOP Recarga y dispara
f9::
Toggle := !Toggle
Loop
{
If (!Toggle)
Break
SendInput {Click down}
SendInput {Click up}
Sleep, 100
SendInput, {f2 Down}
Sleep, 1400
SendInput, {f2 Up}
Sleep, 40
Sendinput {r Down}
Sendinput {r Down}
Sleep, 200
Sendinput {r Up}
Sendinput {r Up}
Sleep, 3200
SendInput, {f1 Down}
Sleep, 1400
SendInput, {f1 Up}
Sleep, Random, rand, 40, 80
SendInput {Click down}
SendInput {Click up}
}
Return

;3 TIROS LOOP (DISPERSION 15 MTS A 800 MTS)
f10::
Toggle := !Toggle
Loop
{
Sleep, 100
SendInput {Click down}
SendInput {Click up}
SendInput, {f2 Down}
Sleep, 1400
SendInput, {f2 Up}
Sleep, 40
Sendinput {r Down}
Sendinput {r Down}
Sleep, 200
Sendinput {r Up}
Sendinput {r Up}
Sleep, 3200
SendInput, {f1 Down}
Sleep, 1400
SendInput, {f1 Up}
SendInput, {a Down}
Sleep, 1000
SendInput, {a Up}
SendInput {Click down}
SendInput {Click up}
SendInput, {f2 Down}
Sleep, 1400
SendInput, {f2 Up}
Sleep, 40
Sendinput {r Down}
Sendinput {r Down}
Sleep, 200
Sendinput {r Up}
Sendinput {r Up}
Sleep, 3200
SendInput, {f1 Down}
Sleep, 1400
SendInput, {f1 Up}
SendInput, {d Down}
Sleep, 2000
SendInput, {d Up}
SendInput {Click down}
SendInput {Click up}
SendInput, {f2 Down}
Sleep, 1400
SendInput, {f2 Up}
Sleep, 40
Sendinput {r Down}
Sendinput {r Down}
Sleep, 200
Sendinput {r Up}
Sendinput {r Up}
Sleep, 3200
SendInput, {f1 Down}
Sleep, 1400
SendInput, {f1 Up}
SendInput, {a Down}
Sleep, 1000
SendInput, {a Up}
}
Return

;Barrido izquierda (DISPERSION 15 MTS A 800 MTS)
f11::
Toggle := !Toggle
Loop
{
If (!Toggle)
Break
Sleep, 100
SendInput {Click down}
SendInput {Click up}
SendInput, {f2 Down}
Sleep, 1400
SendInput, {f2 Up}
Sleep, 40
Sendinput {r Down}
Sendinput {r Down}
Sleep, 200
Sendinput {r Up}
Sendinput {r Up}
Sleep, 3200
SendInput, {f1 Down}
Sleep, 1400
SendInput, {f1 Up}
SendInput, {a Down}
Sleep, 1000
SendInput, {a Up}
SendInput {Click down}
SendInput {Click up}
}
Return

;Barrido derecha (DISPERSION 15 MTS A 800 MTS)
f12::
Toggle := !Toggle
Loop
{
If (!Toggle)
Break
Sleep, 100
SendInput {Click down}
SendInput {Click up}
Sleep, Random, rand, 40, 80
SendInput, {f2 Down}
Sleep, 1400
SendInput, {f2 Up}
Sleep, 40
Sendinput {r Down}
Sendinput {r Down}
Sleep, 200
Sendinput {r Up}
Sendinput {r Up}
Sleep, 3200
SendInput, {f1 Down}
Sleep, 1400
SendInput, {f1 Up}
SendInput, {d Down}
Sleep, 1000
SendInput, {d Up}
SendInput {Click down}
SendInput {Click up}
}
Return

;Recarga el script
PgDn::Reload
Sleep, 200
Return

;Cierra
Del::ExitApp 
