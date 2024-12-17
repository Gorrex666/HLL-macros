;;;// CALCULATOR // ;;;;;;dispersion automatic control is limited at long distances series of shots with low dispersion (when shooting with lower dispersion than 0.8 degrees it will always turn 0.8 degrees as a minimum "error start at 1000 mts and scales to limit dispersion to 30 mts between shooting points at 1600 mts"), it surely can be fixed but the firing rate will be the same
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
; Main GUI
Gui, Color, afaca9
Gui, Font, s11, Bold
Gui -sysmenu -caption
Gui, Show, x1848 y923 w70 h44, Comp
Gui, Add, DropDownList, vNationSelect gUpdateResult x49 y-9 w39 h110, us/ge|ru|uk
Gui, color,, afaca9
Gui, Add, Edit, vDistanceInput gUpdateResult x7 y-5 w35 h20
Gui, Font, s20, Bold
Gui, Add, Text, vResultText x-4 y12 w75 h30 center

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
        Gui, Show, x1839 y968 w80 h140
        WinSet, AlwaysOnTop, On, History
        historyWindowVisible := true
        updateHistoryDisplay()
    }
Return

; Hotkeys

~`::
WinActivate, Comp
SendInput ^a{Backspace}
Return

~up:: WinSet, AlwaysOnTop, Toggle, Comp

; Helper
IsNumber(value) {
    return (value is number)
}

;//MISC//

~pgdn::Reload ;Recarga el script

~f12::ExitApp ;Cierra



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
        ; Calculate Part3 (remainder after 1200 is allocated)
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

	}


/*

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
*/

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
Sleep, 250
SendInput {r Down}{r Up}
Sleep, 3500
SendInput, {f1 Down}
Sleep, 1200
SendInput, {f1 Up}
return

AMMODYN:
Sleep, 250
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
