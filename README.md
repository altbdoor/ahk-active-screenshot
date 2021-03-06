ahk-active-screenshot
===

![](https://cdn.rawgit.com/altbdoor/ahk-active-screenshot/25e98f04/icon/icon.ico)

A simple, configurable application to take screenshots of the active window in Windows.

Created after the forced anti-aliasing settings from my graphics card was not visible in the in-game screenshot function, but was visible on the game window.

This application relies heavily on [GDI+ library by tariqporter](https://github.com/tariqporter/Gdip) and [WinGetPosEx by jballi](https://autohotkey.com/boards/viewtopic.php?t=3392). Do check these projects out!


### Usage

1. Download the latest `.zip` from [Releases](https://github.com/altbdoor/ahk-active-screenshot/releases) and unzip it
1. Run the executable application
1. Press the defined hotkey (`Ctrl` + `F11`)
1. Get screenshots!


### Configuration

Open up the `settings.ini` file to configure the following.

- **bindHotkey** (default: ^F11) <br>
  Specifies the hotkey to call the screenshot function. This hotkey is binded dynamically with AHK's syntax, so the hotkey combination needs to follow [AHK's keylist](https://autohotkey.com/docs/KeyList.htm). As an example, `Ctrl` and `F11` is defined by `^F11`.

- **outputFolderPath** (default: screenshots) <br>
  An absolute or relative path to where you want the screenshots to be saved in. By default, the application will create a folder called `screenshots` at the same level. For example, if you want them to go into the Pictures folder, specify `outputFolderPath=C:\Users\JohnDoe\Pictures\`.

- **filenameFormat** (default: yyyyMMdd_HHmmss) <br>
  The file name format for the screenshot picture. The format is generated by [AHK's FormatTime](https://autohotkey.com/docs/commands/FormatTime.htm), so please refer to the page if you want to change it. Do note that if you wish to put in a text, you need to enclose it in single quotes. For example, for a format of "capture" followed by "current year", it would be `filenameFormat="'capture'yyyy"`.

- **imageFormat** (default: png) <br>
  As defined by [GDI+ library](https://github.com/tariqporter/Gdip/blob/0f14e62/Gdip.ahk#L1306), the acceptable values are `bmp`, `dib`, `rle`, `jpg`, `jpeg`, `jpe`, `jfif`, `gif`, `tif`, `tiff`, `png`.

- **imageQuality** (default: 95) <br>
  As defined by [GDI+ library](https://github.com/tariqporter/Gdip/blob/0f14e62/Gdip.ahk#L1345), the image quality will only affect the `jpg`, `jpeg`, `jpe`, `jfif` formats.

- **includeWindowBorder** (default: 0) <br>
  Acceptable values are 0 or 1. If disabled (0), the application will attempt to calculate the window border, and exclude them from the screenshot. It does not work well with applications that have "eaten" the window title bar, like Mozilla Firefox or Google Chrome.

- **shutterSoundPath** (default: None) <br>
  An absolute or relative path to an audio file to be played when the application takes a screenshot. This uses [AHK's SoundPlay](https://autohotkey.com/docs/commands/SoundPlay.htm), which depends on the OS ability to play the audio. To quote the AHK page,
  
  > All Windows OSes should be able to play .wav files. However, other files (.mp3, .avi, etc.) might not be playable if the right codecs or features aren't installed on the OS.
  
  If you are hunting for a camera shutter sound, [SoundJay](https://www.soundjay.com/camera-sound-effect.html) has a nice collection to start with.

- **postProcess** (default: None) <br>
  A script or command that you can specify to execute after the image has been captured. The following variables can be used in the command.
  
  - `{$imgDir}` the directory which the image is stored. E.g., `C:\Users\JohnDoe\Pictures\`.
  - `{$imgName}` the file name of the image. E.g., `20170524_100935.png`.
  - `{$imgFullPath}` the full file path of the image. E.g., `C:\Users\JohnDoe\Pictures\20170524_100935.png`.
  - `{$imgBasename}` the base name of the image. E.g., `20170524_100935`.
  - `{$imgExt}` the extension of the image. E.g., `png`.
  
  For example, let's say you would like to convert every PNG image captured to JPG with [png2jpeg](https://sourceforge.net/projects/png2jpeg/), it would be `postProcess=png2jpeg.exe -q 95 -o "{$imgDir}{$imgBasename}.jpg" "{$imgFullPath}"`
