set PATH=%PATH:C:\Linkout\bat;=%
call C:\Linkout\bat\envpython3.bat
call C:\Linkout\bat\envnode.bat
call C:\Linkout\bat\envyarn.bat

start "" C:\local\VSCode\Code.exe "%~dp0"

