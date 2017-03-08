' If you want to sort from autosort, and you want the sheet to remain protected,
' use the allow ranges to be editable, while locking the cells and disabling them from being selectable

Sub protecttest()
	Dim wsh As Worksheet
	For Each wsh In Worksheets
		With wsh
			.EnableOutlining = True
			.EnableAutoFilter = True
			.EnableSelection = xlUnlockedCells
			
			.Protection.AllowEditRanges.Add Title:="Range1", Range:=Range("B4:M10")
			
			.Protect Password:="ggwp", DrawingObjects:=True, Contents:=True, Scenarios:=True, _
				UserInterfaceOnly:=True, AllowDeletingColumns:=False, AllowDeletingRows:=False, _
				AllowFiltering:=True, AllowFormattingCells:=False, AllowFormattingColumns:=False, _
				AllowFormattingRows:=False, AllowInsertingColumns:=False, AllowInsertingHyperlinks:=False, _
				AllowInsertingRows:=False, AllowSorting:=True, AllowUsingPivotTables:=True
		End With
	Next wsh
End Sub
