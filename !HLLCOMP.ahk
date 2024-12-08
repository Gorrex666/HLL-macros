;control + backspace = always on top on/off
;control + enter = focus on window
;shift + enter = gib result
xMin := 100
xMax := 1600

; Options object for different nations
options := {}
options["ru"] := { "m": -0.2136691176, "b": 1141.7215 }
options["us"] := { "m": -0.237035714285714, "b": 1001.46547619048 }
options["bri"] := { "m": -0.1773, "b": 550.69 }

; Set a larger font size for the GUI
Gui, Font, s14, Bold, 

; Create the GUI window
Gui, Add, Text, x0 y0 w150 h30,
Gui, Add, Edit, vDistanceInput x5 y0 w100 h30,
Gui, Add, Text, x5 y70 w150 h30,
Gui, Add, DropDownList, vNationSelect x5 y30 w45 h25, ru|us|bri

; Set even larger font for the result text
Gui, Font, s26, Bold, 
Gui, Add, Text, vResultText x60 y25 w220 h40,

Gui, Show, w150 h60, Calculation

; Assign the hotkey to trigger the calculation
#IfWinActive Calculation
~Enter:: ; Shift + Enter
    Gosub, Calculate
return
#IfWinActive

; Hotkey to toggle Always on Top functionality
+Backspace:: ; shift + backspace
    ; Toggle Always on Top for the window
    WinSet, AlwaysOnTop, Toggle, Calculation
return

; Hotkey to focus on the Distance Input text box (Ctrl + I
+Enter:: ; Ctrl + I
    ; Bring the GUI window to the foreground
    WinActivate, Calculation
    ; Focus on the input control (DistanceInput)
    ControlFocus, DistanceInput, Calculation
return

Calculate:
    ; Get the input values
    Gui, Submit, NoHide ; Get the values from the GUI

    ; Check if the input is a valid number
    if (DistanceInput == "" || !IsNumber(DistanceInput)) {
        MsgBox, 16, Input Error, Please enter a valid distance.
        return
    }

    ; Check if a nation is selected
    if (NationSelect = "") {
        MsgBox, 16, Selection Error, Please select a nation.
        return
    }

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
    } else {
        ; Throwing error if the distance is out of range
        DistanceError()
    }
}

DistanceError() {
    global xMin, xMax
    MsgBox, 16, Distance Error, Enter a distance between %xMin% and %xMax% meters
}

IsNumber(val) {
    ; Simple function to check if a string is a valid number
    return val is number
}

GuiClose:
ExitApp

#MaxThreadsPerHotkey 2

~pgup::Reload ;Recarga el script
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
return

~f7:: ;4 tiros(DISPERSION 15 MTS A 800 MTS)
{
Gosub DELAY
SendInput, {f2 Down}
Sleep, 1400
SendInput, {f2 Up}
Sendinput {r Down}
Sleep, 40
Sendinput {r Up}
Sleep, 20
Send {r Down}
Sleep, 20
Send {r Up}
Sleep, 3200
SendInput, {f1 Down}
Sleep, 20
SendInput, {f1 Down}
Sleep, 1400
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
Sleep, 400
SendInput, {f2 Up}
Sendinput {r Down}
Sleep, 20
Sendinput {r Up}
Sleep, 20
Send {r Down}
Sleep, 20
Send {r Up}
Sleep, 3400
SendInput, {f1 Down}
Sleep, 20
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
Sleep, 1400
SendInput, {f2 Up}
Sendinput {r Down}
Sleep, 20
Sendinput {r Up}
Sleep, 20
Send {r Down}
Sleep, 20
Send {r Up}
Sleep, 3200
SendInput, {f1 Down}
Sleep, 20
SendInput, {f1 Down}
Sleep, 1400
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
Sleep, 400
SendInput, {f2 Up}
Sendinput {r Down}
Sleep, 40
Sendinput {r Up}
Sleep, 20
Send {r Down}
Sleep, 20
Send {r Up}
Sleep, 3200
SendInput, {f1 Down}
Sleep, 20
SendInput, {f1 Down}
Sleep, 1400
SendInput, {f1 Up}
SendInput, {a Down}
Sleep, 200
Sleep, 800
SendInput, {a Up}
}
Return

f11:: ;"FIRE MISSION OVER" por chat
{
Sleep, 20
Goto CHATY
}
Return

;LABELS
AMMO:
SendInput, {f2 Down}
Sleep, 1400
SendInput, {f2 Up}
Sendinput {r Down}
Sleep, 20
Sendinput {r Up}
Sleep, 20
Send {r Down}
Sleep, 20
Send {r Up}
Sleep, 3200
SendInput, {f1 Down}
Sleep, 20
SendInput, {f1 Down}
Sleep, 1400
SendInput, {f1 Up}
return

SHOOT:
SendInput {Click down}
Sleep, 20
SendInput {Click down}
SendInput {Click up}
return

DELAY:
SendInput {Click down}
Sleep, 20
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
Sleep, 400
SendInput, {f2 Up}
Sendinput {r Down}
Sleep, 20
Sendinput {r Up}
Sleep, 20
Send {r Down}
Sleep, 20
Send {r Up}
Sleep, 3200
SendInput, {f1 Down}
Sleep, 20
SendInput, {f1 Down}
Sleep, 1400
SendInput, {f1 Up}
SendInput, {d Down}
Sleep, 200
SendInput, {f2 Down}
Sleep, 800
SendInput, {d Up}
return
