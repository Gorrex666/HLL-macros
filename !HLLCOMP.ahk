;// CALCULATOR //
Process, Priority,, A
; Options object for different nations
xMin := 100
xMax := 1600
options := {}
options["us/ge"] := { "m": -0.237035714285714, "b": 1001.46547619048 }
options["ru"] := { "m": -0.2136691176, "b": 1141.7215 }
options["uk"] := { "m": -0.1773, "b": 550.69 }
; Arrays to store last inputs and results
lastInputs := []
lastResults := []
; Set timer to update the history every 10 seconds (reduced frequency)
SetTimer, UpdateHistoryInBackground, 10000

; --- Main GUI window ---
Gui, Color, afaca9
Gui, Font, s11, Bold
Gui -sysmenu
Gui -caption
Gui, Show, x1842 y923 w76 h44, Comp
; Add Nation Dropdown and Input fields
Gui, Add, DropDownList, vNationSelect gSubmitInput x0 y-9 w39 h110, us/ge|ru|uk 
Gui, color,, afaca9
Gui, Add, Edit, vDistanceInput x39 y-5 w35 h20 gSubmitInput
Gui, Font, s20, Bold
Gui, Add, Text, vResultText x0 y11 w75 h30 center


; --- Submit Input Function ---
SubmitInput:
    SetTimer, DelayedUpdate, -300 ; Increased delay to 300ms to reduce CPU usage
Return

DelayedUpdate:
    Gui, Submit, NoHide
    ; Only calculate if input is valid and different from last input
    if (StrLen(DistanceInput) >= 3) {
        if (DistanceInput != lastInputs[lastInputs.Length()]) {
            result := calculate(DistanceInput, NationSelect)
            updateHistory(DistanceInput, result)
            GuiControl, , ResultText, %result%
        }
    } else {
        GuiControl, , ResultText, ; Clear result text if input is less than 3 characters
    }
Return

; --- Calculate Function ---
xMin := 100
xMax := 1600
calculate(x, nation) {
    global options, xMin, xMax
    if (x >= xMin && x <= xMax) {
        m := options[nation]["m"]
        b := options[nation]["b"]
        return Round(m * x + b)
    }
}

; --- Update History Function ---
updateHistory(input, result) {
    global lastInputs, lastResults
    ; Check if input and result are numbers
    if (IsNumber(input) && IsNumber(result)) {
        ; Limit history size to avoid unnecessary resource usage
        if (lastInputs.MaxIndex() > 7) {
            lastInputs.RemoveAt(1) ; Remove the oldest input
            lastResults.RemoveAt(1) ; Remove the oldest result
        }
        lastInputs.Push(input) ; Add new entry at the end
        lastResults.Push(result) ; Add new result at the end
    }
}

; --- Format History Function ---
formatHistory() {
    global lastInputs, lastResults
    text := ""
    Loop % lastInputs.Length() {
        idx := lastInputs.Length() - A_Index + 1
        ; Only append numeric history entries
        if (IsNumber(lastInputs[idx]) && IsNumber(lastResults[idx])) {
            text .= lastInputs[idx] " m | " lastResults[idx] "`n"
        }
    }
    return text
}

; --- Update History in Background ---
UpdateHistoryInBackground:
    if (historyWindowVisible) {
        Gui, 2:Submit, NoHide ; Update the history window even if it is not focused
        GuiControl, 2:, HistoryList, % formatHistory()
    }
Return

; --- Toggle History Window Visibility ---
~down:: 
ToggleHistory:
    if (historyWindowVisible) {
        Gui, 2:Destroy ; Close the history window
        historyWindowVisible := false
    } else {
        ; Create and show the history GUI
        Gui, 2:New, , History
        Gui, Color, afaca9
        Gui -sysmenu
        Gui -caption
        Gui, 2:Font, s11
        Gui, 2:Add, Text, x0 y0 w80 h110 center vHistoryList, % formatHistory()
        Gui, 2:Show, x1839 y968 w80 h110, History 
        -Caption
        WinSet, AlwaysOnTop, On, History ; Ensure the history window is always on top
        historyWindowVisible := true
    }
Return

; --- Hotkey to Focus and Clear Main Window ---
~`::
{
    WinActivate, Comp
    Sendinput ^a
    Sendinput {Backspace}
}
return

; --- Toggle AlwaysOnTop for Main Window ---
up::
    WinSet, AlwaysOnTop, Toggle, Comp
return

; --- Helper Function to Check if a Value is Numeric ---
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

;//SCRIPTS ARTILLERIA//
~^1:: ;Recarga
{
Gosub DELAY
Gosub AMMO
}
Return

~^2:: ;Recarga y dispara
{
Gosub DELAY
Gosub AMMO
Gosub SHOOT
}
Return

~^4:: ;4 tiros(DISPERSION 15 MTS A 800 MTS)
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

~^3:: ;3 tiros (fire mission)
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


~^5:: ;4 tiros(DISPERSION 15 MTS) Dynamic Calculation
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
