' Chinese need GBK
' ���������ݷ�ʽ
' �����������ַ������� VBS �ű���ʹ�� GBK �����ʽ

set WshShell = WScript.CreateObject("WScript.Shell")
set fs = CreateObject("Scripting.FileSystemObject")
' Chrome λ��
chromeCmd = "C:\Program Files\Google\Chrome\Application\chrome.exe"
' Chrome ����
' ���������ļ����ʣ���Ҫ�������� chrome ����
chromeArgs =_
  " --allow-file-access-from-files"+_
  " --window-position=""1500,20"""+_
  " --window-size=""400,700"""+_
  " --app=""file:///"

' ԭʼĿ¼
sourcePath = fs.GetFolder(".").Path
' ԭʼ�ļ�λ��
sourceFile = sourcePath + "\index.html"""
' ��ݷ�ʽλ��
' targetPath=WshShell.SpecialFolders("Desktop")
targetPath = "."

' ������ݷ�ʽ
Set lnk = WshShell.CreateShortcut(targetPath & "\start.lnk")
lnk.TargetPath = chromeCmd
lnk.Arguments = ChromeArgs + sourceFile
lnk.WorkingDirectory = sourcePath
lnk.WindowStyle = 1
lnk.Hotkey = "CTRL+SHIFT+E"
lnk.IconLocation = sourcePath + "\assets\fav.ico,0"
lnk.Description = "�ҵĳ���"
lnk.Save

' ������������
set file = fs.OpenTextFile("env.js", 2, true) ' 1 ��ʾ�� 2��ʾд 8��ʾ׷��
file.Write("var WorkDir = String.raw`" + sourcePath + "\``;")

' ��ʾ��ʾ����
MsgBox "��װ��Ϻ�ĵ�һ�����У���ر������������е� Chrome ���ڣ�������������", vbYes, "��װ�ɹ�"