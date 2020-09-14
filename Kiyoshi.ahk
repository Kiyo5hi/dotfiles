RunInCurrentPath(App, AlternativePath) {
  RegExMatch(WinGetText("A"), "(?<=[Address: ])[a-zA-Z]:\\[\\\S|*\S]?.*", M)
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
    RunInCurrentPath("wt.exe", "C:\Users\Kiyoshi\workspace")
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

RunIDEA() {
  If !ProcessExist("idea64.exe") {
    Run("idea64.exe")
  } Else {
    WinActivate("ahk_exe idea64.exe")
  }
  Return
}

RunPyCharm() {
    If !ProcessExist("pycharm64.exe") {
    Run("pycharm64.exe")
  } Else {
    WinActivate("ahk_exe pycharm64.exe")
  }
  Return
}

#D::RunWT()
#Q::RunQQ()
#J::RunIDEA()
#P::RunPyCharm()
