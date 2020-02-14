RunInCurrentPath(App, AlternativePath) {
  RegExMatch(WinGetText("A"), "(?<=Address: )[a-zA-Z]:\\[\\\S|*\S]?.*", M)
  If (M) {
    Run(App, M.Value())
  } Else {
    Run(App, AlternativePath)
  }
  Return
}

RunWT() {
  If WinExist("ahk_exe WindowsTerminal.exe") {
    WinActivate("ahk_exe WindowsTerminal.exe")
  } Else {
    RunInCurrentPath("wt.exe", "C:\Users\i\workspace")
    WinWait("ahk_exe WindowsTerminal.exe")
    WinActivate("ahk_exe WindowsTerminal.exe")
  }
  Return
}

#D::RunWT()
