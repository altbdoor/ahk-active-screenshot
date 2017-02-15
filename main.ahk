#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

#SingleInstance force
#MaxThreadsPerHotkey 2

#Include Gdip.ahk
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
imageFormat := ReadSettings("imageFormat", "png")
imageQuality := ReadSettings("imageQuality", 95)
includeBorder := ReadSettings("includeWindowBorder", 0)

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

Hotkey, %bindHotkey%, gdipScreenshot

gdipScreenshot:
    ; get active window stats
    WinGetActiveStats, winTitle, winWidth, winHeight, winPosX, winPosY
    
    ; adjustments to get client window
    SysGet, borderX, 32
    SysGet, borderY, 33
    SysGet, titleHeight, 4
    
    If (includeBorder == 0) {
        winPosX := winPosX + borderX
        winWidth := winWidth - (borderX * 2)
        
        winPosY := winPosY + borderY + titleHeight
        winHeight := winHeight - (borderY * 2) - titleHeight
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
    fileName := JoinArray([A_YYYY, A_MM, A_DD, A_Hour, A_Min, A_Sec], "_")
    savePath := folderPath . fileName . "." . imageFormat
    
    ; let the black magic run
    gdipImage := Gdip_BitmapFromScreen(gdipPos)
    Gdip_SaveBitmapToFile(gdipImage, savePath, imageQuality)
    Gdip_DisposeImage(gdipImage)
Return

gdipShutdown:
    Gdip_Shutdown(gdipToken)
    ExitApp
Return
