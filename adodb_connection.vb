' Hints
' Preloading ADODB.Field objects before iterating through a large recordset increases performance
' Commands help prevent sql injection but parameters cannot be named so ordered application is the only feasible method for using parameters

Sub DoSomeDatabaseStuff
	Dim iConnection As ADODB.Connection
	Dim iCommand As ADODB.Command
	Dim iParameter As ADODB.Parameter
	Dim iRecordset As ADODB.Recordset

	' Create and Open Connection Object.
	Set iConnection = New ADODB.Connection
	iConnection.ConnectionString = "DSN=Biblio;UID=admin;PWD=xxx;"
	iConnection.Open

	' Create Command Object.
	Set iCommand = New ADODB.Command
	iCommand.ActiveConnection = iConnection
	iCommand.CommandText = "SELECT * FROM authors WHERE au_id < ?"

	' Create Parameter Object.
	Set iParameter = iCommand.CreateParameter(, adInteger, adParamInput, 5)
	iParameter.Value = 5
	iCommand.Parameters.Append iParameter
	Set iParameter = Nothing

	' Open Recordset Object.
	Set iRecordset = iCommand.Execute()

	'Do something ...

	'Terminate connection and variables
End Sub
