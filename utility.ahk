JoinArray(Arr, Glue) {
    FinalString := ""
    
    Loop % Arr.Length() {
        FinalString .= Arr[A_Index] . Glue
    }
    
    Return SubStr(FinalString, 1, StrLen(FinalString) - 1)
}

WriteSettings(Key, Value) {
    global settingsFile
    IniWrite, %Value%, %settingsFile%, settings, %Key%
    Return
}

ReadSettings(Key, DefaultValue) {
    global settingsFile
    
    If (DefaultValue == "") {
        IniRead, Value, %settingsFile%, settings, %Key%, %A_Space%
    }
    Else {
        IniRead, Value, %settingsFile%, settings, %Key%, %DefaultValue%
    }
    
    Return Value
}

; https://autohotkey.com/board/topic/91733-command-to-get-gui-client-areas-sizes/
GetClientSize(hwnd, ByRef w, ByRef h) {
    VarSetCapacity(rc, 16)
    DllCall("GetClientRect", "uint", hwnd, "uint", &rc)
    w := NumGet(rc, 8, "int")
    h := NumGet(rc, 12, "int")
}

; https://autohotkey.com/board/topic/17922-func-relativepath-absolutepath/page-2#entry117350
RelToAbs(root, dir, s = "\") {
    pr := SubStr(root, 1, len := InStr(root, s, "", InStr(root, s . s) + 2) - 1)
        , root := SubStr(root, len + 1), sk := 0
    If InStr(root, s, "", 0) = StrLen(root)
        StringTrimRight, root, root, 1
    If InStr(dir, s, "", 0) = StrLen(dir)
        StringTrimRight, dir, dir, 1
    Loop, Parse, dir, %s%
    {
        If A_LoopField = ..
            StringLeft, root, root, InStr(root, s, "", 0) - 1
        Else If A_LoopField =
            root =
        Else If A_LoopField != .
            Continue
        StringReplace, dir, dir, %A_LoopField%%s%
    }
    Return, pr . root . s . dir
}

NeutralizePathLastSlash(path) {
    path := path . "\"
    path := RegExReplace(path, "\\+$", "\")
    Return path
}
