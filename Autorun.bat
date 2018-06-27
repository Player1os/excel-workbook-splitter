@ECHO OFF

:: Set the autorun parameters.
SET APP_IS_AUTORUN_MODE=TRUE
SET APP_WORKBOOK_FILE_PATH=H:\WORKBOOK.xlsx

:: Run the main project workbook.
CALL "WorkbookSplitter.xlsm"
