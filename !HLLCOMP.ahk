

#MaxThreadsPerHotkey 2

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
f5::
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

;Recarga y dispara
~f6::
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


;4 tiros(DISPERSION 15 MTS A 800 MTS)
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
Sleep, 100
SendInput, {f2 Down}
Sleep, 900
SendInput, {a Up}
SendInput {Click down}
SendInput {Click up}
Sleep, 500
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
Sleep, 100
SendInput, {f2 Down}
Sleep, 900
SendInput, {d Up}
SendInput {Click down}
SendInput {Click up}
Sleep, 500
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
Sleep, 100
SendInput, {f2 Down}
Sleep, 900
SendInput, {d Up}
SendInput {Click down}
SendInput {Click up}
Sleep, 500
SendInput, {f2 Up}
Sleep, Random, rand, 40, 60
Sendinput {r Down}
Sleep, 200
Sendinput {r Up}
Sleep, 3200
SendInput, {f1 Down}
Sleep, 1400
SendInput, {f1 Up}
}
Return


;LOOP Recarga y dispara
f8::
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
Sleep, Random, rand, 40, 60
Sendinput {r Down}
Sendinput {r Down}
Sleep, 200
Sendinput {r Up}
Sendinput {r Up}
Sleep, 3200
SendInput, {f1 Down}
Sleep, 1400
SendInput, {f1 Up}
Sleep, Random, rand, 40, 60
SendInput {Click down}
SendInput {Click up}
}
Return

;4 TIROS LOOP (DISPERSION 15 MTS A 800 MTS)
f9::
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
Sleep, 100
SendInput, {f2 Down}
Sleep, 900
SendInput, {a Up}
SendInput {Click down}
SendInput {Click up}
Sleep, 500
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
Sleep, 100
SendInput, {f2 Down}
Sleep, 900
SendInput, {d Up}
SendInput {Click down}
SendInput {Click up}
Sleep, 500
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
Sleep, 100
SendInput, {f2 Down}
Sleep, 900
SendInput, {d Up}
SendInput {Click down}
SendInput {Click up}
Sleep, 500
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
Sleep, 100
Sleep, 900
SendInput, {a Up}
}
Return


;Recarga el script
del::Reload
Sleep, 200
Return

;Cierra
f12::ExitApp 
