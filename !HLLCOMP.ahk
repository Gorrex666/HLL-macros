;// CALCULATOR //
Process, Priority,, A

; Options for different nations
xMin := 100, xMax := 1600
options := {}
options["us/ge"] := { "m": -0.237, "b": 1001.465 }
options["ru"] := { "m": -0.214, "b": 1141.722 }
options["uk"] := { "m": -0.177, "b": 550.69 }

; History data
lastInputs := [], lastResults := []

; Main GUI
Gui, Color, afaca9
Gui, Font, s11, Bold
Gui -sysmenu -caption
Gui, Show, x1842 y923 w76 h44, Comp
Gui, Add, DropDownList, vNationSelect gUpdateResult x0 y-9 w39 h110, us/ge|ru|uk
Gui, color,, afaca9
Gui, Add, Edit, vDistanceInput gUpdateResult x39 y-5 w35 h20
Gui, Font, s20, Bold
Gui, Add, Text, vResultText x0 y11 w75 h30 center

; Update Result
UpdateResult:
    SetTimer, DelayedUpdate, -400
Return

DelayedUpdate:
    Gui, Submit, NoHide
    if (StrLen(DistanceInput) >= 3 && DistanceInput != lastInputs[lastInputs.Length()]) {
        result := calculate(DistanceInput, NationSelect)
        if (!IsNumber(result)) {
            GuiControl, , ResultText,
        } else {
            GuiControl, , ResultText, %result%
            updateHistory(DistanceInput, result)
            updateHistoryDisplay()
        }
    } else {
        GuiControl, , ResultText,
    }
Return

; Calculation
calculate(x, nation) {
    global options, xMin, xMax
    if (x >= xMin && x <= xMax) {
        m := options[nation].m, b := options[nation].b
        return Round(m * x + b)
    }
    return ""
}

; Update History
updateHistory(input, result) {
    global lastInputs, lastResults
    if (lastInputs.MaxIndex() > 7) {
        lastInputs.RemoveAt(1), lastResults.RemoveAt(1)
    }
    lastInputs.Push(input), lastResults.Push(result)
}

; Format and Update History Display
updateHistoryDisplay() {
    global lastInputs, lastResults, historyWindowVisible
    if (!historyWindowVisible) return
    text := ""
    Loop % lastInputs.Length() {
        idx := lastInputs.Length() - A_Index + 1
        text .= lastInputs[idx] " m | " lastResults[idx] "`n"
    }
    GuiControl, 2:, HistoryList, %text%
}

; Toggle History Window
~down::
    if (historyWindowVisible) {
        Gui, 2:Destroy
        historyWindowVisible := false
    } else {
        Gui, 2:New, , History
        Gui, Color, afaca9
        Gui -sysmenu -caption
		Gui, Font, s11, Bold
        Gui, Add, Text, x0 y0 w80 h110 vHistoryList center
        Gui, Show, x1839 y968 w80 h110
        WinSet, AlwaysOnTop, On, History
        historyWindowVisible := truerr
        updateHistoryDisplay()
    }
Return

; Hotkeys
~`::
WinActivate, Comp
Send ^a{Backspace}
Return

up:: WinSet, AlwaysOnTop, Toggle, Comp

; Helper
IsNumber(value) {
    return (value is number)
}

;//MISC//
#MaxThreadsPerHotkey 2

~pgdn::Reload ;Recarga el script

~f12::ExitApp ;Cierra

~f4:: ;LOOP r (spamea recarga)
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
!CapsLock::
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

;//SCRIPTS ARTILLERIA//
~!1:: ;Recarga
{
Gosub DELAY
Gosub AMMO
}
Return

~!2:: ;Recarga y dispara
{
Gosub DELAY
Gosub AMMO
Gosub SHOOT
}
Return

~!4:: ;4 tiros(DISPERSION 15 MTS A 800 MTS)
{
Gosub DELAY
SendInput, {f2 Down}
Sleep, 1400
SendInput, {f2 Up}
Sendinput {r Down}
Sleep, 50
Sendinput {r Up}
Send {r Down}
Send {r Up}
Sleep, 3400
Send, {f1 Down}
SendInput, {f1 Down}
Sleep, 1500
SendInput, {f1 Up}
Send, {f1 Up}
SendInput, {a Down}
Sleep, 275
SendInput, {f2 Down}
Sleep, 700
SendInput, {a Up}
Gosub SHOOT
Gosub SRCONT
Gosub SHOOT
Gosub SRCONT
Gosub SHOOT
Sleep, 500
SendInput, {f2 Up}
Sendinput {r Down}
Sleep, 50
Sendinput {r Up}
Send {r Down}
Send {r Up}
Sleep, 3400
Send, {f1 Down}
SendInput, {f1 Down}
Sleep, 1500
SendInput, {f1 Up}
Send, {f1 Up}
}
Return

~!3:: ;3 tiros (fire mission)
{
Gosub DELAY
Gosub AMMO
Gosub SHOOT
Gosub AMMO
Gosub SHOOT
Gosub AMMO
Gosub SHOOT
}
Return


~!5:: ;4 tiros(DISPERSION 15 MTS) Dynamic Calculation
{
    gui, Submit, NoHide ; Ensure the distance is updated from GUI
    distance := DistanceInput ; Get the distance input
    Time := round((800 * 1075) / distance) ; Calculate the press time
    Gosub DELAY
    SendInput, {f2 Down}
    Sleep, 1400
    SendInput, {f2 Up}
    Sendinput {r Down}
    Sleep, 50
    Sendinput {r Up}
    Send {r Down}
    Send {r Up}
    Sleep, 3400
    Send, {f1 Down}
    SendInput, {f1 Down}
    Sleep, 1400
    SendInput, {f1 Up}
    Send, {f1 Up}
    SendInput, {a Down}
    Sleep, Time
	SendInput, {a Up}
    Gosub SHOOT
    Gosub SRCONTDYN
    Gosub SHOOT
    Gosub SRCONTDYN
    Gosub SHOOT
    Sleep, 500
    Send, {f2 Up}
    Sendinput {r Down}
    Sleep, 50
    Sendinput {r Up}
    Send {r Down}
    Send {r Up}
    Sleep, 3400
    Send, {f1 Down}
    SendInput, {f1 Down}
    Sleep, 1400
    SendInput, {f1 Up}
    Send, {f1 Up}
}
Return
SRCONTDYN: ;Shoot right continuous DYNAMIC
SendInput, {f2 Down}
Sleep, 1400
SendInput, {f2 Up}
Sendinput {r Down}
Sleep, 50
Sendinput {r Up}
Send {r Down}
Send {r Up}
Sleep, 3400
Send, {f1 Down}
SendInput, {f1 Down}
Sleep, 1400
Send, {f1 Up}
SendInput, {d Down}
Sleep, Time
SendInput, {d Up}
return

~F9:: ;LOOP Recarga y dispar
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

~F6:: ;4 TIROS LOOP (DISPERSION 15 MTS A 800 MTS)
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
Sleep, 50
Sendinput {r Up}
Send {r Down}
Send {r Up}
Sleep, 3400
Send, {f1 Down}
SendInput, {f1 Down}
Sleep, 1500
SendInput, {f1 Up}
Send, {f1 Up}
SendInput, {a Down}
Sleep, 275
SendInput, {f2 Down}
Sleep, 700
SendInput, {a Up}
Gosub SHOOT
Gosub SRCONT
Gosub SHOOT
Gosub SRCONT
Gosub SHOOT
Sleep, 500
SendInput, {f2 Up}
Sendinput {r Down}
Sleep, 50
Sendinput {r Up}
Send {r Down}
Send {r Up}
Sleep, 3400
Send, {f1 Down}
SendInput, {f1 Down}
Sleep, 1500
SendInput, {f1 Up}
Send, {f1 Up}
SendInput, {a Down}
Sleep, 275
Sleep, 800
SendInput, {a Up}
}
Return

~f11:: ;"FIRE MISSION OVER" por chat
{
Sleep, 200
Goto CHATY
}
Return

;LABELS
AMMO:
SendInput, {f2 Down}
Sleep, 1400
SendInput, {f2 Up}
Sendinput {r Down}
Sleep, 50
Sendinput {r Up}
Send {r Down}
Send {r Up}
Sleep, 3400
Send, {f1 Down}
SendInput, {f1 Down}
Sleep, 1500
SendInput, {f1 Up}
Send, {f1 Up}
return

SHOOT:
SendInput {Click down}
Sleep, 50
SendInput {Click down}
SendInput {Click up}
return

DELAY:
Sleep, 200
SendInput {Click down}
Sleep, 50
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
Sleep, 50
Sendinput {r Up}
Send {r Down}
Send {r Up}
Sleep, 3400
Send, {f1 Down}
SendInput, {f1 Down}
Sleep, 1500
SendInput, {f1 Up}
Send, {f1 Up}
SendInput, {d Down}
Sleep, 275
SendInput, {f2 Down}
Sleep, 700
SendInput, {d Up}
return
