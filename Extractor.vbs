option explicit

Const vbext_ct_ClassModule = 2
Const vbext_ct_Document = 100
Const vbext_ct_MSForm = 3
Const vbext_ct_StdModule = 1

Const vbext_pp_locked = 1

Const dir_to_max = "C:\Projects\MagentaMaxDiff\"

Const dir_from_max_modeling = "C:\Projects\MaxOfferTools\legacy\MagentaMobileMax.xlsm"
Const dir_to_max_modeling = "C:\Projects\MagentaMaxDiff\Modeling"
Const password_max_modeling = "tele$MaxOfferTools"

Const dir_from_max_generating = "C:\Projects\MaxOfferTools\legacy\Support\RZ1Dev.xlsm"
Const dir_to_max_generating = "C:\Projects\MagentaMaxDiff\Generating"
Const password_max_generating = "tele$MaxOfferTools"

Const dir_from_max_sender_html = "C:\Projects\MaxOfferTools\legacy\Support\MAX_SENDER.htm"
Const dir_from_max_approver_html = "C:\Projects\MaxOfferTools\legacy\Support\MAX.htm"
Const dir_from_max_sumar_html = "C:\Projects\MaxOfferTools\legacy\Support\Sumar.htm"
Const dir_from_max_generator_html = "C:\Projects\MaxOfferTools\legacy\Support\MAX_SENDER_BO1.htm"

Const dir_from_jscode_sender_js = "C:\Projects\MaxOfferTools\legacy\Support\jscode_SENDER.js"
Const dir_from_jscode2_app_js = "C:\Projects\MaxOfferTools\legacy\Support\jscode2_app.js"
Const dir_from_jscode2_su_js = "C:\Projects\MaxOfferTools\legacy\Support\jscode2_su.js"
Const dir_from_jscode3_app_js = "C:\Projects\MaxOfferTools\legacy\Support\jscode3_app.js"
Const dir_from_jscode3_sender_js = "C:\Projects\MaxOfferTools\legacy\Support\jscode3_SENDER.js"
Const dir_from_jscode5_sender_js = "C:\Projects\MaxOfferTools\legacy\Support\jscode5_SENDER.js"
Const dir_from_jscode7_sender_js = "C:\Projects\MaxOfferTools\legacy\Support\jscode7_SENDER.js"
Const dir_from_inp_max_clf_js = "C:\Projects\MaxOfferTools\legacy\Support\INP_MAX_CLF.js"

Dim objFSO
Set objFSO = CreateObject("Scripting.FileSystemObject")

objFSO.DeleteFile dir_to_max_modeling & "\*", True
Extract dir_from_max_modeling, dir_to_max_modeling, password_max_modeling
objFSO.DeleteFile dir_to_max_generating & "\*", True
Extract dir_from_max_generating, dir_to_max_generating, password_max_generating

objFSO.CopyFile dir_from_max_sender_html, dir_to_max & "sender.html", True
objFSO.CopyFile dir_from_max_approver_html, dir_to_max & "approver.html", True
objFSO.CopyFile dir_from_max_sumar_html, dir_to_max & "sumar.html", True
objFSO.CopyFile dir_from_max_generator_html, dir_to_max & "generator.html", True

objFSO.CopyFile dir_from_jscode_sender_js, dir_to_max & "jscode_sender.js", True
objFSO.CopyFile dir_from_jscode2_app_js, dir_to_max & "jscode2_app.js", True
objFSO.CopyFile dir_from_jscode2_su_js, dir_to_max & "jscode2_su.js", True
objFSO.CopyFile dir_from_jscode3_app_js, dir_to_max & "jscode3_app.js", True
objFSO.CopyFile dir_from_jscode3_sender_js, dir_to_max & "jscode3_sender.js", True
objFSO.CopyFile dir_from_jscode5_sender_js, dir_to_max & "jscode5_sender.js", True
objFSO.CopyFile dir_from_jscode7_sender_js, dir_to_max & "jscode7_sender.js", True
objFSO.CopyFile dir_from_inp_max_clf_js, dir_to_max & "inp_max_clf.js", True

Sub Extract(ImportDir, ExportDir, strPassword)
	Dim xl
	Dim fs
	Dim WBook
	Dim VBComp
	Dim Sfx

	Set xl = CreateObject("Excel.Application")
	Set fs = CreateObject("Scripting.FileSystemObject")

	xl.Visible = true

	Set WBook = xl.Workbooks.Open(ImportDir)
	UnprotectVBProject WBook, strPassword

	For Each VBComp In WBook.VBProject.VBComponents
		Select Case VBComp.Type
			Case vbext_ct_ClassModule, vbext_ct_Document
				Sfx = ".cls"
			Case vbext_ct_MSForm
				Sfx = ".frm"
			Case vbext_ct_StdModule
				Sfx = ".bas"
			Case Else
				Sfx = ""
		End Select
		
		If Sfx <> "" Then
			On Error Resume Next
			
			Err.Clear
			VBComp.Export ExportDir & "\" & VBComp.Name & Sfx
			
			If Err.Number <> 0 Then
				MsgBox "Failed to export " & ExportDir & "\" & VBComp.Name & Sfx
			End If
			
			On Error Goto 0
		End If
	Next

	WBook.Close False
	xl.Quit
End Sub

Sub UnprotectVBProject(wb, strPassword)
	Dim xl
	Dim vbp

	Set xl = wb.Application
	Set vbp = wb.VBProject

	If vbp.Protection <> vbext_pp_locked Then
		Exit Sub
	End If

	xl.SendKeys "%{F11}", True
	xl.Wait 100

	vbp.VBE.MainWindow.SetFocus

	xl.SendKeys "%TE", True
	xl.Wait 100
	xl.SendKeys strPassword, True
	xl.Wait 100
	xl.SendKeys "~", True
	xl.Wait 100
	xl.SendKeys "~", True
	
	While vbp.Protection = vbext_pp_locked
		xl.Wait 1000
	Wend
End Sub
