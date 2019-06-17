Option Explicit

' Set the autorun parameters.
With CreateObject("WScript.Shell").Environment("PROCESS")
	.Item("APP_IS_AUTORUN_MODE") = "TRUE"
	.Item("APP_WORKBOOK_FILE_PATH") = "H:\WORKBOOK.xlsx"
End With

' Run the main project workbook.
Call CreateObject("Excel.Application").Workbooks.Open( _
	CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName) & "\WorkbookSplitter.xlsm" _
)
