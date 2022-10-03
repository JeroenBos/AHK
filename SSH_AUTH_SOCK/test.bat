@REM "C:\Program Files\Git\usr\bin\bash.exe" -c "source ~/.bashrc; echo SSH: $SSH_AUTH_SOCK!"
@REM "C:\Program Files\Git\usr\bin\bash.exe" -c "test -f $HOME/.ssh/agent.env && source $HOME/.ssh/agent.env >^| /dev/null; echo SSH: $SSH_AUTH_SOCK!"
@REM "C:\Program Files\Git\usr\bin\bash.exe" -c "test -f $HOME/.ssh/agent.env && source $HOME/.ssh/agent.env >^| /dev/null; bash -c 'echo SSH: $SSH_AUTH_SOCK!'"
@REM ORIGINAL: "C:\Program Files\Git\usr\bin\bash.exe" -c "test -f \"$HOME/.ssh/agent.env\" && source \"$HOME/.ssh/agent.env\" >^| /dev/null; \"/c/Program Files/Microsoft VS Code/code.exe\" \"$@\""
@REM "C:\Program Files\Git\usr\bin\bash.exe" -c "test -f ""$HOME/.ssh/agent.env"" && source ""$HOME/.ssh/agent.env"" >^| /dev/null; ""/c/Program Files/Microsoft VS Code/code.exe"" ""$@"""
@REM "C:\Program Files\Git\usr\bin\bash.exe" -c "SSH_AUTH_SOCK=hi; \"/c/Program Files/Microsoft VS Code/code.exe\" \"$@\"" "C:\git\health-tech\api"

"C:\Program Files\Git\usr\bin\bash.exe" -c "echo ""/c/Program Files/Microsoft VS Code/code.exe"" ""$@"""

PAUSE
