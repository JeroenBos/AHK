SetKeyDelay, 0
^Ins::
^+v::	
    if (Clipboard != A_Space and Clipboard != A_Tab and Clipboard != "") {
        clipboardCopy = %clipboard%
        truncatedCopy := SubStr(clipboardCopy, 1)
        truncatedCopy := StrReplace(truncatedCopy, "\", "/")
        if (SubStr(truncatedCopy, 2, 1) = ":")
        {
            if (SubStr(truncatedCopy, 1, 1) = "C")
            {
                truncatedCopy := "/c/" . SubStr(truncatedCopy, 4)
            }
            if (SubStr(truncatedCopy, 1, 1) = "D")
            {
                truncatedCopy := "/d/" . SubStr(truncatedCopy, 4)
            }
        }
        truncatedCopy := StrReplace(truncatedCopy, "`r`n", "`n")
        truncatedCopy := StrReplace(truncatedCopy, "`r", "")
        truncatedCopy := RegExReplace(truncatedCopy, "[\x{200B}\x{200C}\x{200D}\x{FEFF}]", "") ; common zero-width characters
        truncatedCopy := LTrim(truncatedCopy, OmitChars := " `r`n")
        truncatedCopy := RTrim(truncatedCopy, OmitChars := " `t`r`n")
        Send {Raw}%truncatedCopy%
    }
Return
