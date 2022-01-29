set PATH=%PATH:C:\Linkout\bat;=%
call C:\Linkout\bat\envpython3.bat
call C:\Linkout\bat\envnode.bat
call C:\Linkout\bat\envyarn.bat
call C:\Linkout\bat\envpipx.bat

set PATH=%PATH%;%~dp0node_modules\.bin

start "" C:\local\VSCode\Code.exe "%~dp0"

