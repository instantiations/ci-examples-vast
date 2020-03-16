@echo Builder Image Creation Script

COPY /Y "c:\Program Files\Instantiations\VA Smalltalk\9.2.1x64\newimage\abt.icx"
COPY /Y "c:\Program Files\Instantiations\VA Smalltalk\9.2.1x64\newimage\abt.ini"

@IF EXIST output.txt DEL output.txt
"c:\Program Files\Instantiations\VA Smalltalk\9.2.1x64\nodialog.exe" -iabt.icx -ini:abt.ini -loutput.txt "-user=Supervisor" "-map=Seaside Traffic Light Builder" "-xdmap=Seaside Traffic Light XD"
@set RC=%ERRORLEVEL%
@TYPE output.txt
@EXIT /B %RC%