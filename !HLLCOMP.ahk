;;;// CALCULATOR //  calculation is expensive in cpu resources relatively, dont know if its the gui updating too many times or the loop of line 109
#MaxThreadsPerHotkey 2
Process, Priority,, A
; Options for different nations
xMin := 100, xMax := 1600
options := {}
options["us/ge"] := { "m": -0.237, "b": 1001.465 }
options["ru"] := { "m": -0.214, "b": 1141.722 }
options["uk"] := { "m": -0.177, "b": 550.69 }

; History data
lastInputs := [], lastResults := []

; Calculate position for bottom-right corner
SysGet, ScreenWidth, 78
SysGet, ScreenHeight, 79
GuiWidth := 66
GuiHeight := 40
GuiX := ScreenWidth - GuiWidth - 0  ; Adjust relative to edge
GuiY := ScreenHeight - GuiHeight - 110
; Main GUI
Gui, Color, afaca9
Gui, Font, s11, Bold
Gui -sysmenu -caption
Gui, Show, x%GuiX% y%GuiY% w%GuiWidth% h%GuiHeight%, Comp
Gui, Add, DropDownList, vNationSelect gUpdateresult x47 y-10 w39 h110, us/ge|ru|uk
Gui, Color,, afaca9
Gui, Add, Edit, Number vDistanceInput gUpdateresult x6 y-6 w35 h20 center
Gui, Font, s20, Bold
Gui, Add, Text, vResultText x0 y10 w66 h26 center
WinActivate, Hell Let Loose

; Toggle History Window
~down::
    if (historyWindowVisible) {
        Gui, 2:Destroy
        historyWindowVisible := false
    } else {
        ; Calculate position for bottom-right corner
        GuiWidth := 74
        GuiHeight := 110
        GuiX := ScreenWidth - GuiWidth - 0  
        GuiY := ScreenHeight - GuiHeight - 0
        ; Create the GUI
        Gui, 2:New, , History
        Gui, Color, afaca9
        Gui -sysmenu -caption
        Gui, Font, s11, Bold
        Gui, Add, Text, x0 y0 w%GuiWidth% h%GuiHeight% vHistoryList center
        Gui, Show, x%GuiX% y%GuiY% w%GuiWidth% h%GuiHeight%
        WinSet, AlwaysOnTop, On, History
        historyWindowVisible := true
        updateHistoryDisplay()
    }
    WinActivate, Hell Let Loose
Return

Updateresult: ; Update history list with a delay to only record after the user made the whole input
Gui, Submit, NoHide
SetTimer, DelayedHistoryUpdate, 600 ; Resets every time input is detected
if (StrLen(DistanceInput) >= 3) 
{
    result := calculate(DistanceInput, NationSelect)
    GuiControl, , ResultText, %result%
}
Return

DelayedHistoryUpdate:
SetTimer, DelayedHistoryUpdate, Off ; Stop the timer after it runs
Gui, Submit, NoHide ; Ensure latest input is captured
if (StrLen(DistanceInput) >= 3 && (lastInputs.Length() == 0 || DistanceInput != lastInputs[lastInputs.Length()])) 
{
    result := calculate(DistanceInput, NationSelect)
    updateHistory(DistanceInput, result)
    updateHistoryDisplay()
}
Return

; Calculation
calculate(x, nation) {
    global options, xMin, xMax
    if (x >= xMin && x <= xMax) {
        m := options[nation].m, b := options[nation].b
        return Round(m * x + b)
    }
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
    Loop % lastInputs.Length() {
        idx := lastInputs.Length() - A_Index + 1
        text .= lastInputs[idx] "m | " lastResults[idx] "`n"
    }
    GuiControl, 2:, HistoryList, %text%
}

; Hotkeys

~`:: ; Trigger on the backtick key
WinActivate, Comp ; Activate the "Comp" window
GuiControl, Focus, DistanceInput
SendInput ^a{Backspace} ; Select all text and delete it
KeySequence := "" 
Loop {
    Input, SingleKey, V L1
    KeySequence .= SingleKey
    if (StrLen(KeySequence) == 3 && SubStr(KeySequence, 1, 1) != "1") {
        WinActivate, Hell Let Loose
        Break
    }
    else if (StrLen(KeySequence) == 4 && SubStr(KeySequence, 1, 1) == "1") {
        WinActivate, Hell Let Loose
        Break
    }
}
Return

~up::WinSet, AlwaysOnTop, Toggle, Comp

;//MISC//

~pgdn::Reload ;Recarga el script

~f12::ExitApp ;Cierra

#IfWinActive ahk_exe HLL-Win64-Shipping.exe

~CapsLock:: ;HOLDS "W" capslock, "S"  alt+capslock (on/off)
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

~j:: ;HOLDS F por 5 seCS J.
Sleep, 200
SendInput, {f Down}
Sleep, 7000
SendInput, {f Up}
Return

~=:: ;HOLDS LEFT click (on/off)
KeyDown := !KeyDown
If KeyDown
SendInput {Click down}
Else
SendInput {Click up}
Return

;//ARTILLERY SCRIPTS//

~/:: ;RELOAD
Gosub DELAY
Gosub AMMO
Return

~.:: ;RELOAD AND SHOOT
Gosub DELAY
Gosub AMMO
Gosub SHOOT
Return

~,:: ;3 SHOTS (fire mission)
Gosub DELAY
Gosub AMMO
Gosub SHOOT
Gosub AMMO
Gosub SHOOT
Gosub AMMO
Gosub SHOOT
Return

;//FUNCTIONS//

~;:: ; 4 shots (20 MTS dispersion)
HandleShots(20)
Return

~':: ; 4 shots (30 MTS dispersion)
HandleShots(30)
Return

~\:: ; 4 shots (40 MTS dispersion)
HandleShots(40)
Return

~F6:: ; Loop 4 shots (20 MTS dispersion)
HandleShotLoop(20)
Return

~F7:: ; Loop 4 shots (30 MTS dispersion)
HandleShotLoop(30)
Return

~F8:: ; Loop 4 shots (40 MTS dispersion)
HandleShotLoop(40)
Return

; Calculation Function
CalculateParts(dispersion) {
    global Part1N, Part1A, Part2N, Part3, DistanceInput, Time
    Gui, Submit, NoHide ; Ensure the distance is updated from GUI
    distance := DistanceInput ; Get the distance input
    Time := Round(((101 * 28436) / distance) / 49.48 * dispersion) ; Calculate the press time
    ; Initialize all parts
    Part1N := 0 ; The natural state of Part1
    Part1A := 0 ; Artificial filling for Part1
    Part2N := 0 ; The natural state of Part2
    Part3 := 0  ; Remaining time
        ; Calculate Part1 Natural and Artificial
    if (Time >= 800) {
        Part1N := 800
        Part1A := 0
    } else {
        Part1N := Time
        Part1A := 800 - Time
    }
        ; Calculate remaining time after Part1
    RemainingTime := Max(Time - 800, 0)
        ; Calculate Part2 Natural
    if (RemainingTime >= 400) {
        Part2N := 400
    } else {
        Part2N := RemainingTime
    }	
        ; Calculate Part3 (remainder after 1200 (natural time) allocated)
    Part3 := Time - 1200
        ; Ensure all values are positive
    Part1N := Max(Part1N, 0)
    Part1A := Max(Part1A, 0)
    Part2N := Max(Part2N, 0)
    Part3 := Max(Part3, 0)
    ; Return the parts as an object (without it the caller would not get any value)
    return {Part1N: Part1N, Part1A: Part1A, Part2N: Part2N, Part3: Part3,Time: Time}
}

HandleShots(dispersion) {
global Part1N, Part1A, Part2N, Part3, Time
Sleep, 200
parts := CalculateParts(dispersion)
Gosub SHOOT
Gosub AMMO
SendInput, {a Down}
Sleep, Part3
Sleep, Part2N
SendInput, {F2 Down}
Sleep, Part1N
SendInput, {a Up}
SendInput {Click down}{Click up}
Sleep, Part1A
Sleep, 400
SendInput, {F2 Up}
Gosub AMMODYN
Gosub SRDYN 
Gosub AMMODYN
SendInput, {d Down}
Sleep, Part3
Sleep, Part1N
Sleep, Part2N
SendInput, {d Up} 
SendInput {Click down}{Click up}
	}
Return

;//LOOPS//
global Loop1Active := false
global Loop2Active := false
global Loop3Active := false

;start/stop with a key press
HandleShotLoop(dispersion) {
    global Part1N, Part1A, Part2N, Part3, Time, Loop1Active
    Sleep, 200
    Loop1Active := !Loop1Active  ; Toggle the loop state (start/stop)
        Loop
    {
        If (!Loop1Active)
            Break
        parts := CalculateParts(dispersion)
        Gosub SHOOT
        Gosub AMMO
SendInput, {a Down}
Sleep, Part3
Sleep, Part2N
SendInput, {F2 Down}
Sleep, Part1N
SendInput, {a Up}
SendInput {Click down}{Click up}
Sleep, Part1A
Sleep, 400
SendInput, {F2 Up}
        Gosub AMMODYN
        Gosub SRDYN 
        Gosub AMMODYN
        Gosub SRDYN 
        Gosub AMMODYN
        SendInput, {a Down}
Sleep, Part3
Sleep, Part1N
Sleep, Part2N
        SendInput, {a Up}
    }
}
Return

~F9:: 
    global Loop2Active
    Loop2Active := !Loop2Active 
        Loop
    {
        If (!Loop2Active)
            Break
            Sendinput {r Down}
        Sleep, 200
        Sendinput {r Up}
    }
Return

~F5:: 
    global Loop3Active
    Loop3Active := !Loop3Active  ; Toggle the loop state (start/stop)
        Loop
    {
        If (!Loop3Active)
            Break
            Gosub DELAY
        Gosub AMMO
        Gosub SHOOT
    }
Return

~F4:: ; Press to stop all loops
    global Loop1Active, Loop2Active, Loop3Active
	Sleep, 200
    Loop1Active := false
    Loop2Active := false
    Loop3Active := false
Return

;//LABELS//

DELAY:
Sleep, 200
SendInput {Click down}{Click up}
return

SHOOT:
SendInput {Click down}{Click up}
return

AMMO:
SendInput, {f2 Down}
Sleep, 1200
SendInput, {f2 Up}
Sleep, 200
SendInput {r Down}{r Up}
Sleep, 3500
SendInput, {f1 Down}
Sleep, 1200
SendInput, {f1 Up}
return

AMMODYN:
Sleep, 200
SendInput {r Down}{r Up}
Sleep, 3500
SendInput, {f1 Down}
Sleep, 1200
SendInput, {f1 Up}
return

SRDYN:
SendInput, {d Down}
Sleep, Part3
Sleep, Part2N
SendInput, {F2 Down}
Sleep, Part1N
SendInput, {d Up}
SendInput {Click down}{Click up}
Sleep, Part1A
Sleep, 400
SendInput, {F2 Up}
return
