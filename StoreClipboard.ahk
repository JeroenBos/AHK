#Persistent

global Filename
Filename=C:\Users\Windows\Desktop\Clipboard.txt

OnClipboardChange("WriteClipboardToFile")

WriteClipboardToFile(Type)
{
    ; 1 = Clipboard contains something that can be expressed as text (this includes files copied from an Explorer window).
    if (Type = 1)
    {
        copy = %clipboard%
        copy := Trim(copy, OmitChars := " `t`r`n")
        copy := StrReplace(copy, "`r")
        copy := StrReplace(copy, "`n")

        FormatTime, timestamp,, hh:mm:ss tt

        FileAppend, %A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_sec%.%A_MSec% | %copy%`n, %Filename%
    }
    Else
    {
        FileAppend, Not text`n, %Filename%
    }
    return
}

