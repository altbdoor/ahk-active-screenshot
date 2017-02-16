ahk-active-screenshot
===

A simple, configurable application to take screenshots of the active window in Windows.

Created after the forced anti-aliasing settings from my graphics card was not visible in the in-game screenshot function, but was visible on the game window.

This application relies heavily on [GDI+ library by tariqporter](https://github.com/tariqporter/Gdip) and [WinGetPosEx by jballi](https://autohotkey.com/boards/viewtopic.php?t=3392). Do check these projects out!


### Usage

1. Download the `.zip`, or the `.exe` from Releases
1. Run the application respectively (`main.ahk` for AHK)
1. Press the defined hotkey (`Ctrl` + `F11`)
1. Get screenshots!


### Configuration

Open up the `settings.ini` file to configure the following.

- **bindHotkey** (default: ^F11) <br>
  Specifies the hotkey to call the screenshot function. This hotkey is binded dynamically with AHK's syntax, so the hotkey combination needs to follow [AHK's keylist](https://autohotkey.com/docs/KeyList.htm). As an example, `Ctrl` and `F11` is defined by `^F11`.

- **outputFolderPath** (default: screenshots) <br>
  An absolute path to where you want the screenshots to be saved in. By default, the application will create a folder called `screenshots` at the same level. For example, if you want them to go into the Pictures folder, specify `outputFolderPath=C:\Users\JohnDoe\Pictures\`.

- **imageFormat** (default: png) <br>
  As defined by [GDI+ library](https://github.com/tariqporter/Gdip/blob/0f14e62/Gdip.ahk#L1306), the acceptable values are `bmp`, `dib`, `rle`, `jpg`, `jpeg`, `jpe`, `jfif`, `gif`, `tif`, `tiff`, `png`.

- **imageQuality** (default: 95) <br>
  As defined by [GDI+ library](https://github.com/tariqporter/Gdip/blob/0f14e62/Gdip.ahk#L1345), the image quality will only affect the `jpg`, `jpeg`, `jpe`, `jfif` formats.

- **includeWindowBorder** (default: 0) <br>
  Acceptable values are 0 or 1. If disabled (0), the application will attempt to calculate the window border, and exclude them from the screenshot. It does not work well with applications that have "eaten" the window title bar, like Mozilla Firefox or Google Chrome.
