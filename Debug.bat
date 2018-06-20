@ECHO OFF

:: Set the project password.
SET APP_DEBUG_PASSWORD=tele$WorkbookSplitter

:: Run the main project workbook.
CALL "%~dp0WorkbookSplitter.xlsm"
