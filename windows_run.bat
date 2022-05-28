
@echo off
set "$py=0"
set "$version=0"
call:construct

for /f "delims=" %%a in ('python #.py ^| findstr "2"') do set "$py=2" & set "$version=%%a"
for /f "delims=" %%a in ('python #.py ^| findstr "3"') do set "$py=3" & set "$version=%%a"
del #.py
goto:%$py%

echo python is not installed or python's path Path is not in the %%$path%% env. var
exit/b

:2
echo running with Pthon %$version%
echo Your python version is not OK!
echo python version should be higher than 3.2
pause
exit/b

:3
if %ERRORLEVEL% EQU 0 ( 
   if %$version% GEQ 3.2 (
   echo Your python version is OK!
   echo running with Pthon %$version%
  pip install virtualenv -i https://pypi.doubanio.com/simple
  virtualenv schinper_env
  .\schinper_env\Scripts\pip.exe install -r requirements.txt -i https://pypi.doubanio.com/simple
  .\schinper_env\Scripts\python.exe best_pipeline_20220527154931.py "dataset_20220527154931.csv"
  pause
  )^
else (
  echo python version should be higher than 3.2
  pause
  )
)
exit/b

:construct

echo import sys; print('{0[0]}.{0[1]}'.format(sys.version_info^)^) >#.py