; http://autohotkey.com/board/topic/90702-encrypt-decrypt-text/
; https://www.autohotkey.com/boards/viewtopic.php?t=5838

; ===================================================================================
; AHK Version ...: AHK_L 1.1.11.01 x64 Unicode
; Win Version ...: Windows 7 Professional x64 SP1
; Author ........: Originated from jNizM, tweaked by Soft
; Script ........: EnCrypt_DeCrypt.ahk
; Description ...: Encrypt & Decrypt Data
; License .......: WTFPL
; ===================================================================================

; GLOBAL SETTINGS ===================================================================

#NoEnv
#SingleInstance force

#Include lib/Crypt.ahk
#Include lib/CryptConst.ahk
#Include lib/CryptFoos.ahk

; SCRIPT ============================================================================

Gui, Margin, 10, 10
Gui, Font, s10, Segoe UI

Gui, Add, Edit, xm ym w300 h120 vStr hwndEditEnDecrypt, ���⿡ ��ȣȭ/��ȣȭ�� �ؽ�Ʈ�� �Է��ϰų� ������ ����� �����ʽÿ�.

Gui, Add, Edit, xm y+5 w300 vStr2, Password
;Gui, Add, Edit, xm y+5 w300 vStr2 hwndEditPw,
;EM_SetCueBanner(EditPw, "Password")
Gui, Add, Edit, xm y+10 w300 h120 vEnDeCrypt ReadOnly, ��ȣȭ/��ȣȭ �ؽ�Ʈ�� ���⿡ ��Ÿ���� Ŭ������ε� ����˴ϴ�!

Gui, Add, DropDownList, xm y+5 w300 AltSubmit vEncryption, RC4 (������Ʈ ��ȣ)
    |RC2 (������Ʈ ��ȣ)
    |3DES (������ ��ȣȭ ǥ��)
    |3DES 112 (������ ��ȣȭ ǥ��)
    |AES 128 (��� ��ȣȭ ǥ��)
    |AES 192 (��� ��ȣȭ ǥ��)
    |AES 256 (��� ��ȣȭ ǥ��)||
Gui, Add, Button, xm-1 y+5 w100, Encrypt
Gui, Add, Button, xm+201 yp w100, Decrypt
Gui, +LastFound
Gui, Show,, En/Decrypt
WinSet, Redraw
Return

ButtonEncrypt:
    Gui, Submit, NoHide
    GuiControl,, EnDeCrypt, % Crypt.Encrypt.StrEncrypt(Str, Str2, Encryption, 1)
    Clipboard := % Crypt.Encrypt.StrEncrypt(Str, Str2, Encryption, 1)
Return

ButtonDecrypt:
    Gui, Submit, NoHide
    GuiControl,, EnDeCrypt, % Crypt.Encrypt.StrDecrypt(Str, Str2, Encryption, 1)
    Clipboard := % Crypt.Encrypt.StrDecrypt(Str, Str2, Encryption, 1)
Return

GuiDropFiles:
if A_GuiControl = Str
{
    Draged := FileOpen(A_GuiEvent, "r")
    GuiControl,, Str, % Draged.Read()

}
Return

; EXIT ==============================================================================

GuiClose:
GuiEscape:
ExitApp

EM_SetCueBanner(hWnd, Cue)
{
    Static EM_SETCUEBANNER := 0x1501
    Return DllCall("User32.dll\SendMessage", "Ptr", hWnd, "UInt", EM_SETCUEBANNER, "Ptr", True, "WStr", Cue)
}