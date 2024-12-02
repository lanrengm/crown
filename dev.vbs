' Chinese need GBK
' 创建桌面快捷方式
' 若包含中文字符串，本 VBS 脚本需使用 GBK 编码格式

set WshShell = WScript.CreateObject("WScript.Shell")
set fs = CreateObject("Scripting.FileSystemObject")
' Chrome 位置
chromeCmd = "C:\Program Files\Google\Chrome\Application\chrome.exe"
' Chrome 参数
' 开启本地文件访问，需要重启所有 chrome 进程
chromeArgs =_
  " --allow-file-access-from-files"+_
  " --window-position=""1500,20"""+_
  " --window-size=""400,700"""+_
  " --app=""file:///"

' 原始目录
sourcePath = fs.GetFolder(".").Path
' 原始文件位置
sourceFile = sourcePath + "\index.html"""
' 快捷方式位置
' targetPath=WshShell.SpecialFolders("Desktop")
targetPath = "."

' 创建快捷方式
Set lnk = WshShell.CreateShortcut(targetPath & "\start.lnk")
lnk.TargetPath = chromeCmd
lnk.Arguments = ChromeArgs + sourceFile
lnk.WorkingDirectory = sourcePath
lnk.WindowStyle = 1
lnk.Hotkey = "CTRL+SHIFT+E"
lnk.IconLocation = sourcePath + "\assets\fav.ico,0"
lnk.Description = "我的程序"
lnk.Save

' 创建环境变量
set file = fs.OpenTextFile("env.js", 2, true) ' 1 表示读 2表示写 8表示追加
file.Write("var WorkDir = String.raw`" + sourcePath + "\``;")

' 显示提示窗口
MsgBox "安装完毕后的第一次运行，请关闭所有正在运行的 Chrome 窗口，再启动本程序", vbYes, "安装成功"