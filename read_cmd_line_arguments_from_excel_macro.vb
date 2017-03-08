' Library module.

Option Base 0
Option Explicit
 
Declare Function GetCommandLine Lib "kernel32" Alias "GetCommandLineW" () As Long
Declare Function lstrlenW Lib "kernel32" (ByVal lpString As Long) As Long
Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (MyDest As Any, MySource As Any, ByVal MySize As Long)
 
Function CmdToSTr(Cmd As Long) As String
	Dim Buffer() As Byte
	Dim StrLen As Long
   
   If Cmd Then
      StrLen = lstrlenW(Cmd) * 2
      If StrLen Then
         ReDim Buffer(0 To (StrLen - 1)) As Byte
         CopyMemory Buffer(0), ByVal Cmd, StrLen
         CmdToSTr = Buffer
      End If
   End If
End Function

' Usage example module.

Option Explicit

Private Sub Workbook_Open()
    Dim CmdLine As String
    CmdLine = CmdToSTr(GetCommandLine)
    MsgBox CmdLine
End Sub

' Test command
' start excel "C:\Projects\MagentaOfficeMax\Book1.xlsm" /gg
