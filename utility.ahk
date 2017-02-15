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
