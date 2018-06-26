@ECHO OFF

:: Switch to the deploy directory.
PUSHD \\kedata\Data1\B2B_Business_Inteligence\Osama Hassanein\ExcelWorkbookSplitter

:: Set the autorun parameters.
SET APP_IS_AUTORUN_MODE=TRUE
SET APP_WORKBOOK_FILE_PATH=H:\WORKBOOK.xlsx

:: Run the main project workbook.
CALL "WorkbookSplitter.xlsm"

:: Return to the original working directory.
POPD
