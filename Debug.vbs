Option Explicit

' Set the project password.
CreateObject("WScript.Shell").Environment("PROCESS") _
	.Item("APP_DEBUG_PASSWORD") = "tele$ExcelWorkbookSplitter"

' Run the main project workbook.
With CreateObject("Excel.Application")
	.Visible = True
	.Workbooks.Open( _
		CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName) _
			& "\WorkbookSplitter.xlsm" _
	)
End With
