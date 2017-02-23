#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

#SingleInstance force
#MaxThreadsPerHotkey 2

#Include Gdip.ahk
#Include WinGetPosEx.ahk
#Include utility.ahk

; ========================================

; start gdip
gdipToken := Gdip_Startup()
OnExit, gdipShutdown

; read settings
settingsFile := A_ScriptDir . "\settings.ini"
defaultFolderPath := A_ScriptDir . "\screenshots\"

bindHotkey := ReadSettings("bindHotkey", "^F11")
folderPath := ReadSettings("outputFolderPath", defaultFolderPath)
filenameFormat := ReadSettings("filenameFormat", "yyyyMMdd_HHmmss")
imageFormat := ReadSettings("imageFormat", "png")
imageQuality := ReadSettings("imageQuality", 95)
includeBorder := ReadSettings("includeWindowBorder", 0)
shutterSoundPath := ReadSettings("shutterSoundPath", "")

; fix the folder path
If (Substr(folderPath, 0) != "\") {
    folderPath := folderPath . "\"
}

; check if folder is missing
If (!InStr(FileExist(folderPath), "D")) {
    ; if its default folder, lets create it
    If (folderPath == defaultFolderPath) {
        FileCreateDir, %defaultFolderPath%
    }
    Else {
        MsgBox, Please create the output folder, or the images will not be created.
    }
}

; ========================================

mainRoutine:
    Hotkey, %bindHotkey%, gdipScreenshot
Return

gdipScreenshot:
    ; get active window stats
    currentWindow := WinExist("A")
    
    WinGetPosEx(currentWindow, winPosX, winPosY, winWidth, winHeight)
    GetClientSize(currentWindow, clientWidth, clientHeight)
    
    If (includeBorder == 0) {
        borderSize := (winWidth - clientWidth) / 2
        borderSize := Floor(borderSize)
        If (borderSize < 0) {
            borderSize := 0
        }
        
        titleSize := (winHeight - clientHeight) - (2 * borderSize)
        titleSize := Floor(titleSize)
        If (titleSize < 0) {
            titleSize := 0
        }
        
        winPosX := winPosX + borderSize
        winPosY := winPosY + borderSize + titleSize
        
        winWidth := clientWidth
        winHeight := clientHeight
    }
    Else {
        If (winPosX < 0) {
            winWidth := winWidth + (winPosX * 2)
            winPosX := 0
        }
        If (winPosY < 0) {
            winHeight := winHeight + (winPosY * 2)
            winPosY := 0
        }
    }
    
    ; prepare position
    gdipPos := JoinArray([winPosX, winPosY, winWidth, winHeight], "|")
    
    ; prepare path
    FormatTime, currentFilenameFormat, A_Now, %filenameFormat%
    savePath := folderPath . currentFilenameFormat . "." . imageFormat
    
    ; let the black magic run
    gdipImage := Gdip_BitmapFromScreen(gdipPos)
    Gdip_SaveBitmapToFile(gdipImage, savePath, imageQuality)
    Gdip_DisposeImage(gdipImage)
    
    ; play the shutter sound
    If (FileExist(shutterSoundPath)) {
        SoundPlay, %shutterSoundPath%
    }
Return

gdipShutdown:
    Gdip_Shutdown(gdipToken)
    ExitApp
Return
