@ECHO OFF

@echo Application Packaging Script

IF [%3] NEQ [] (set "VERARG=-ver=%~3") ELSE (SET "VERARG=")

IF EXIST output.txt DEL output.txt

@echo example: build_image.bat

"c:\Program Files\Instantiations\VA Smalltalk\9.2.1x64\nodialog.exe" -ibuild.icx -ini:abt.ini -loutput.txt "-map=Seaside Traffic Light Runtime" "-pkg=XDSeasideTrafficLightPackagingInstructions" %VERARG%


set RC=%ERRORLEVEL%
TYPE output.txt
EXIT /B %RC%
