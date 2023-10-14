@echo off

REM Step 1: Remove all files with .a extension
del /S *.a

REM Step 2: Copy all files and folders to the "package" subfolder
mkdir package
xcopy /S /I /E /Y *.* package\

REM Step 3: Go to the "package" folder
cd package

REM Step 4: Zip all files and folders to a zip file with the current date
for /f "tokens=2 delims==" %%G in ('wmic os get localdatetime /value') do set "datetime=%%G"
set "datestamp=%datetime:~0,8%"
set "timestamp=%datetime:~8,6%"
set "zipfile=cb-%datestamp:~0,4%-%datestamp:~4,2%-%datestamp:~6,2%-%timestamp%.zip"


REM Compress all files and folders (excluding "release" folder) to a zip file using the "zip" command
zip -r "%zipfile%" . -x "release/*"


REM Optional: Verify the zip file was created successfully
if exist "%zipfile%" (
    echo Zip file created: %zipfile%
) else (
    echo Failed to create zip file.
)


REM Step 5: Move the zip file to the "release" folder
move "%zipfile%" "release\"

REM Optional: Verify the file was moved successfully
if exist "release\%zipfile%" (
    echo File moved to the release folder.
) else (
    echo Failed to move the file.
)


REM Step 6: Optional - Display a message when the process is complete
echo Batch file execution completed successfully.
pause