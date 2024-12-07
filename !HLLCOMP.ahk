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
Sleep, 200
SendInput, {f2 Down}
Sleep, 1500
SendInput, {f2 Up}
Sleep, Random, rand, 40, 80
Sendinput {r Down}
Sendinput {r Down}
Sendinput {r Up}
Sendinput {r Up}
Sleep, 3300
SendInput, {f1 Down}
Sleep, 1500
SendInput, {f1 Up}
}
Return

;Recarga y dispara
~f6::
{
Sleep, 200
SendInput {Click down}
SendInput {Click up}
SendInput {f2 Down}
Sleep, 1500
SendInput {f2 Up}
Sendinput {r Down}
Sendinput {r Down}
Sendinput {r Up}
Sendinput {r Up}
Sleep, 3300
SendInput {f1 Down}
Sleep, 1500
SendInput {f1 Up}
Sleep, Random, rand, 40, 80
SendInput {Click down}
SendInput {Click up}
}
Return

;4 tiros(DISPERSION 15 MTS A 800 MTS)
~f7::
{
Sleep, 200
SendInput {Click down}
SendInput {Click up}
SendInput, {f2 Down}
Sleep, 1500
SendInput, {f2 Up}
Sleep, Random, rand, 40, 80
Sendinput {r Down}
Sendinput {r Down}
Sendinput {r Up}
Sendinput {r Up}
Sleep, 3300
SendInput, {f1 Down}
Sleep, 1500
SendInput, {f1 Up}
SendInput, {a Down}
Sleep, 200
SendInput, {f2 Down}
Sleep, 800
SendInput, {a Up}
SendInput {Click down}
SendInput {Click up}
Sleep, 500
SendInput, {f2 Up}
Sleep, Random, rand, 40, 80
Sendinput {r Down}
Sendinput {r Down}
Sendinput {r Up}
Sendinput {r Up}
Sleep, 3300
SendInput, {f1 Down}
Sleep, 1500
SendInput, {f1 Up}
SendInput, {d Down}
Sleep, 200
SendInput, {f2 Down}
Sleep, 800
SendInput, {d Up}
SendInput {Click down}
SendInput {Click up}
Sleep, 500
SendInput, {f2 Up}
Sleep, Random, rand, 40, 80
Sendinput {r Down}
Sendinput {r Down}
Sendinput {r Up}
Sendinput {r Up}
Sleep, 3300
SendInput, {f1 Down}
Sleep, 1500
SendInput, {f1 Up}
SendInput, {d Down}
Sleep, 200
SendInput, {f2 Down}
Sleep, 800
SendInput, {d Up}
SendInput {Click down}
SendInput {Click up}
Sleep, 500
SendInput, {f2 Up}
Sleep, Random, rand, 40, 80
Sendinput {r Down}
Sendinput {r Down}
Sendinput {r Up}
Sendinput {r Up}
Sleep, 3300
SendInput, {f1 Down}
Sleep, 1500
SendInput, {f1 Up}
}
Return

;3 tiros (fire mission)
~f8::
{
Sleep, 200
SendInput {Click down}
SendInput {Click up}
SendInput {f2 Down}
Sleep, 1500
SendInput {f2 Up}
Sendinput {r Down}
Sendinput {r Down}
Sendinput {r Up}
Sendinput {r Up}
Sleep, 3300
SendInput {f1 Down}
Sleep, 1500
SendInput {f1 Up}
Sleep, Random, rand, 40, 80
SendInput {Click down}
SendInput {Click up}
SendInput {f2 Down}
Sleep, 1500
SendInput {f2 Up}
Sendinput {r Down}
Sendinput {r Down}
Sendinput {r Up}
Sendinput {r Up}
Sleep, 3300
SendInput {f1 Down}
Sleep, 1500
SendInput {f1 Up}
Sleep, Random, rand, 40, 80
SendInput {Click down}
SendInput {Click up}
SendInput {f2 Down}
Sleep, 1500
SendInput {f2 Up}
Sendinput {r Down}
Sendinput {r Down}
Sendinput {r Up}
Sendinput {r Up}
Sleep, 3300
SendInput {f1 Down}
Sleep, 1500
SendInput {f1 Up}
Sleep, Random, rand, 40, 80
SendInput {Click down}
SendInput {Click up}
Sleep, Random, rand, 40, 80
SendInput {k Down}
SendInput {k Up}
SendInput, >fire stop, approx 20 secs.
SendInput {enter Down}
SendInput {enter Up}
}
Return

;LOOP Recarga y dispara
~f9::
Toggle := !Toggle
Loop
{
If (!Toggle)
Break
Sleep, 200
SendInput {Click down}
SendInput {Click up}
SendInput, {f2 Down}
Sleep, 1500
SendInput, {f2 Up}
Sleep, Random, rand, 40, 80
Sendinput {r Down}
Sendinput {r Down}
Sendinput {r Up}
Sendinput {r Up}
Sleep, 3300
SendInput, {f1 Down}
Sleep, 1500
SendInput, {f1 Up}
Sleep, Random, rand, 40, 80
SendInput {Click down}
SendInput {Click up}
}
Return

;4 TIROS LOOP (DISPERSION 15 MTS A 800 MTS)
~f10::
Toggle := !Toggle
Loop
{
If (!Toggle)
Break
Sleep, 200
SendInput {Click down}
SendInput {Click up}
SendInput, {f2 Down}
Sleep, 1500
SendInput, {f2 Up}
Sleep, Random, rand, 40, 80
Sendinput {r Down}
Sendinput {r Down}
Sendinput {r Up}
Sendinput {r Up}
Sleep, 3300
SendInput, {f1 Down}
Sleep, 1500
SendInput, {f1 Up}
SendInput, {a Down}
Sleep, 200
SendInput, {f2 Down}
Sleep, 800
SendInput, {a Up}
SendInput {Click down}
SendInput {Click up}
Sleep, 500
SendInput, {f2 Up}
Sleep, Random, rand, 40, 80
Sendinput {r Down}
Sendinput {r Down}
Sendinput {r Up}
Sendinput {r Up}
Sleep, 3300
SendInput, {f1 Down}
Sleep, 1500
SendInput, {f1 Up}
SendInput, {d Down}
Sleep, 200
SendInput, {f2 Down}
Sleep, 800
SendInput, {d Up}
SendInput {Click down}
SendInput {Click up}
Sleep, 500
SendInput, {f2 Up}
Sleep, Random, rand, 40, 80
Sendinput {r Down}
Sendinput {r Down}
Sendinput {r Up}
Sendinput {r Up}
Sleep, 3300
SendInput, {f1 Down}
Sleep, 1500
SendInput, {f1 Up}
SendInput, {d Down}
Sleep, 200
SendInput, {f2 Down}
Sleep, 800
SendInput, {d Up}
SendInput {Click down}
SendInput {Click up}
Sleep, 500
SendInput, {f2 Up}
Sleep, Random, rand, 40, 80
Sendinput {r Down}
Sendinput {r Down}
Sendinput {r Up}
Sendinput {r Up}
Sleep, 3300
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
SendInput {k Down}
SendInput {k Up}
SendInput, >fire stop, approx 20 secs.
SendInput {enter Down}
SendInput {enter Up}
}
Return#MaxThreadsPerHotkey 2

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
Sleep, 200
SendInput, {f2 Down}
Sleep, 1500
SendInput, {f2 Up}
Sleep, Random, rand, 40, 80
Sendinput {r Down}
Sendinput {r Down}
Sendinput {r Up}
Sendinput {r Up}
Sleep, 3300
SendInput, {f1 Down}
Sleep, 1500
SendInput, {f1 Up}
}
Return

;Recarga y dispara
~f6::
{
Sleep, 200
SendInput {Click down}
SendInput {Click up}
SendInput {f2 Down}
Sleep, 1500
SendInput {f2 Up}
Sendinput {r Down}
Sendinput {r Down}
Sendinput {r Up}
Sendinput {r Up}
Sleep, 3300
SendInput {f1 Down}
Sleep, 1500
SendInput {f1 Up}
Sleep, Random, rand, 40, 80
SendInput {Click down}
SendInput {Click up}
}
Return

;4 tiros(DISPERSION 15 MTS A 800 MTS)
~f7::
{
Sleep, 200
SendInput {Click down}
SendInput {Click up}
SendInput, {f2 Down}
Sleep, 1500
SendInput, {f2 Up}
Sleep, Random, rand, 40, 80
Sendinput {r Down}
Sendinput {r Down}
Sendinput {r Up}
Sendinput {r Up}
Sleep, 3300
SendInput, {f1 Down}
Sleep, 1500
SendInput, {f1 Up}
SendInput, {a Down}
Sleep, 200
SendInput, {f2 Down}
Sleep, 800
SendInput, {a Up}
SendInput {Click down}
SendInput {Click up}
Sleep, 500
SendInput, {f2 Up}
Sleep, Random, rand, 40, 80
Sendinput {r Down}
Sendinput {r Down}
Sendinput {r Up}
Sendinput {r Up}
Sleep, 3300
SendInput, {f1 Down}
Sleep, 1500
SendInput, {f1 Up}
SendInput, {d Down}
Sleep, 200
SendInput, {f2 Down}
Sleep, 800
SendInput, {d Up}
SendInput {Click down}
SendInput {Click up}
Sleep, 500
SendInput, {f2 Up}
Sleep, Random, rand, 40, 80
Sendinput {r Down}
Sendinput {r Down}
Sendinput {r Up}
Sendinput {r Up}
Sleep, 3300
SendInput, {f1 Down}
Sleep, 1500
SendInput, {f1 Up}
SendInput, {d Down}
Sleep, 200
SendInput, {f2 Down}
Sleep, 800
SendInput, {d Up}
SendInput {Click down}
SendInput {Click up}
Sleep, 500
SendInput, {f2 Up}
Sleep, Random, rand, 40, 80
Sendinput {r Down}
Sendinput {r Down}
Sendinput {r Up}
Sendinput {r Up}
Sleep, 3300
SendInput, {f1 Down}
Sleep, 1500
SendInput, {f1 Up}
}
Return

;3 tiros (fire mission)
~f8::
{
Sleep, 200
SendInput {Click down}
SendInput {Click up}
SendInput {f2 Down}
Sleep, 1500
SendInput {f2 Up}
Sendinput {r Down}
Sendinput {r Down}
Sendinput {r Up}
Sendinput {r Up}
Sleep, 3300
SendInput {f1 Down}
Sleep, 1500
SendInput {f1 Up}
Sleep, Random, rand, 40, 80
SendInput {Click down}
SendInput {Click up}
SendInput {f2 Down}
Sleep, 1500
SendInput {f2 Up}
Sendinput {r Down}
Sendinput {r Down}
Sendinput {r Up}
Sendinput {r Up}
Sleep, 3300
SendInput {f1 Down}
Sleep, 1500
SendInput {f1 Up}
Sleep, Random, rand, 40, 80
SendInput {Click down}
SendInput {Click up}
SendInput {f2 Down}
Sleep, 1500
SendInput {f2 Up}
Sendinput {r Down}
Sendinput {r Down}
Sendinput {r Up}
Sendinput {r Up}
Sleep, 3300
SendInput {f1 Down}
Sleep, 1500
SendInput {f1 Up}
Sleep, Random, rand, 40, 80
SendInput {Click down}
SendInput {Click up}
Sleep, Random, rand, 40, 80
SendInput {k Down}
SendInput {k Up}
SendInput, >fire stop, approx 20 secs.
SendInput {enter Down}
SendInput {enter Up}
}
Return

;LOOP Recarga y dispara
~f9::
Toggle := !Toggle
Loop
{
If (!Toggle)
Break
Sleep, 200
SendInput {Click down}
SendInput {Click up}
SendInput, {f2 Down}
Sleep, 1500
SendInput, {f2 Up}
Sleep, Random, rand, 40, 80
Sendinput {r Down}
Sendinput {r Down}
Sendinput {r Up}
Sendinput {r Up}
Sleep, 3300
SendInput, {f1 Down}
Sleep, 1500
SendInput, {f1 Up}
Sleep, Random, rand, 40, 80
SendInput {Click down}
SendInput {Click up}
}
Return

;4 TIROS LOOP (DISPERSION 15 MTS A 800 MTS)
~f10::
Toggle := !Toggle
Loop
{
If (!Toggle)
Break
Sleep, 200
SendInput {Click down}
SendInput {Click up}
SendInput, {f2 Down}
Sleep, 1500
SendInput, {f2 Up}
Sleep, Random, rand, 40, 80
Sendinput {r Down}
Sendinput {r Down}
Sendinput {r Up}
Sendinput {r Up}
Sleep, 3300
SendInput, {f1 Down}
Sleep, 1500
SendInput, {f1 Up}
SendInput, {a Down}
Sleep, 200
SendInput, {f2 Down}
Sleep, 800
SendInput, {a Up}
SendInput {Click down}
SendInput {Click up}
Sleep, 500
SendInput, {f2 Up}
Sleep, Random, rand, 40, 80
Sendinput {r Down}
Sendinput {r Down}
Sendinput {r Up}
Sendinput {r Up}
Sleep, 3300
SendInput, {f1 Down}
Sleep, 1500
SendInput, {f1 Up}
SendInput, {d Down}
Sleep, 200
SendInput, {f2 Down}
Sleep, 800
SendInput, {d Up}
SendInput {Click down}
SendInput {Click up}
Sleep, 500
SendInput, {f2 Up}
Sleep, Random, rand, 40, 80
Sendinput {r Down}
Sendinput {r Down}
Sendinput {r Up}
Sendinput {r Up}
Sleep, 3300
SendInput, {f1 Down}
Sleep, 1500
SendInput, {f1 Up}
SendInput, {d Down}
Sleep, 200
SendInput, {f2 Down}
Sleep, 800
SendInput, {d Up}
SendInput {Click down}
SendInput {Click up}
Sleep, 500
SendInput, {f2 Up}
Sleep, Random, rand, 40, 80
Sendinput {r Down}
Sendinput {r Down}
Sendinput {r Up}
Sendinput {r Up}
Sleep, 3300
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
Sleep, 200
SendInput {k Down}
SendInput {k Up}
SendInput, >fire stop, approx 20 secs.
SendInput {enter Down}
SendInput {enter Up}
}
Return
