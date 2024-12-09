;control + backspace = always on top on/off // "-" = focus on window //

xMin := 100
xMax := 1600

; Options object for different nations
options := {}
options["us/ger"] := { "m": -0.237035714285714, "b": 1001.46547619048 }
options["ru"] := { "m": -0.2136691176, "b": 1141.7215 }
options["uk"] := { "m": -0.1773, "b": 550.69 }

; Font for the GUI
Gui, Font, s14, Bold
; GUI window
Gui -sysmenu
Gui, Add, Edit, vDistanceInput gCalculate x45 y0 w50 h30 ; us/gere gLabel to trigger calculation
Gui, Add, DropDownList, vNationSelect gCalculate x0 y0 w45 h110, us/ger|ru|uk
; Result text
Gui, Font, s26, Bold
Gui, Add, Text, vResultText x18 y25 w220 h40
Gui, Show, w95 h60 minimize, Calculation



; Hotkey to toggle Always on Top functionality
^Backspace::WinSet, AlwaysOnTop, Toggle, Calculation
return

~`::
{
WinActivate, Calculation
Send ^a
Send {Backspace}
}
return

Calculate:
; Get the input values
Gui, Submit, NoHide ; Get the values from the GUI
; Perform the calculation
result := calculate(DistanceInput, NationSelect)
; Display the result in the GUI
GuiControl, , ResultText, %result%
Return

calculate(x, nation) {
    global options, xMin, xMax
    if (x >= xMin && x <= xMax) {
        m := options[nation]["m"]
        b := options[nation]["b"]
        return Round(m * x + b)
    }
}
GuiClose:
ExitApp
#MaxThreadsPerHotkey 2
~pgdn::Reload ;Recarga el script

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

~=:: ;Mantiene apretado el click izq con ` (on/off)
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
Sleep, 80
Sendinput {r Up}
Sleep, 40
Send {r Down}
Sleep, 40
Send {r Up}
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
Sleep, 80
Sendinput {r Up}
Sleep, 40
Send {r Down}
Sleep, 40
Send {r Up}
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
Sleep, 80
Sendinput {r Up}
Sleep, 40
Send {r Down}
Sleep, 40
Send {r Up}
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
Sleep, 80
Sendinput {r Up}
Sleep, 40
Send {r Down}
Sleep, 40
Send {r Up}
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
Sleep, 80
Sendinput {r Up}
Sleep, 40
Send {r Down}
Sleep, 40
Send {r Up}
Sleep, 3400
SendInput, {f1 Down}
Sleep, 40
SendInput, {f1 Down}
Sleep, 1500
SendInput, {f1 Up}
return

SHOOT:
SendInput {Click down}
Sleep, 40
SendInput {Click down}
SendInput {Click up}
return

DELAY:
Sleep, 200
SendInput {Click down}
Sleep, 40
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
Sleep, 80
Sendinput {r Up}
Sleep, 40
Send {r Down}
Sleep, 40
Send {r Up}
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
