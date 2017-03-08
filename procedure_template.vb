Public Sub Handler()
    'Opt: Disable method preemptively
    
    DataModule.Initialize "HandlerProcedureCaptionName" 'Initialize data module.
    'Opt: Initialize on-demand resources.
    UtilityModule.EnableSpeedMode 'Enable speed mode.

    'Declare local variables

    If DataModule.RunModeFlags("CatchErrors") Then On Error GoTo ErrorHandler: 'Setup error handling.
    
    'Call internal module procedure.
    
Terminate:
    On Error GoTo 0 'Reset error handling.
    UtilityModule.DisableSpeedMode 'Disable speed mode.
    DataModule.Terminate 'Terminate data module.
    Exit Sub
HandleError:
    ErrorModule.Notify 'Opt: Unknown error message override.
    Resume Terminate:
End Sub

Public Sub InternalSubRoutine()
    'Declare local variables
    If DataModule.RunModeFlags("CatchErrors") Then On Error GoTo ErrorHandler: 'Setup error handling.
    
    'Actual application logic.
    
Terminate:
    On Error GoTo 0 'Reset error handling.
    'Conditionally release locally allocated resources.
    'Clear local variables.
    ErrorModule.Pass 'Conditionally pass error to the next level.
    Exit Sub
HandleError:
    ErrorModule.Save 'Opt: Unknown error message override.
    Resume Terminate:
End Sub

Public Function InternalFunction()
    'Declare local variables
    If DataModule.RunModeFlags("CatchErrors") Then On Error GoTo ErrorHandler: 'Setup error handling.
    
    'Actual application logic.
    
Terminate:
    On Error GoTo 0 'Reset error handling.
    'Conditionally release locally allocated resources.
    'Clear local variables
    'Opt: Procedure specific behavior
    ErrorModule.Pass 'Conditionally pass error to the next level.
    Exit Function
HandleError:
    'Conditionally release allocated return value resources.
    'Clear return value
    ErrorModule.Save 'Opt: Unknown error message override.
    Resume Terminate:
End Function
