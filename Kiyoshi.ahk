RunInCurrentPath(App, AlternativePath) {
  RegExMatch(WinGetText("A"), "(?<=[Address: ])[a-zA-Z]:\\[\\\S|*\S]?.*", &M)
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
    RunInCurrentPath("wt.exe", "C:\Users\" A_UserName "\Source")
    WinWait("ahk_exe WindowsTerminal.exe")
    WinActivate("ahk_exe WindowsTerminal.exe")
  }
  Return
}

RunQQ() {
  If !ProcessExist("QQ.exe") {
    Run("C:\Program Files (x86)\Tencent\QQ\Bin\QQScLauncher.exe")
  }
  Return
}

#D::RunWT()
#Q::RunQQ()
