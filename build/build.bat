@ECHO OFF

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: serves as a source builder:
:: initializes phases according to passed arguments (backup / deploy / minify)
:: each argument is optional, order of parameters is significant.
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:: If no arguments passed - recall this script with default configuration.
IF "%1"=="" GOTO default

:: Delegates a call to set local variables according to the specified phases.
CALL %~dp0\src\set-env.bat %*

:: Clear log files
ECHO > %LOGS_DIR%\backup.log
ECHO > %LOGS_DIR%\deploy.log
ECHO > %LOGS_DIR%\minify.log

:: Loop through command arguments and invoke required phases accordingly.
:params
SHIFT
IF "%0"=="" GOTO :EOF
IF "%0"=="backup" GOTO backup
IF "%0"=="deploy" GOTO deploy
IF "%0"=="minify" GOTO minify
:backup
	CALL %~dp0\src\backup.bat > %LOGS_DIR%\backup.log 2>&1
	GOTO params
:deploy
	CALL %~dp0\src\deploy.bat > %LOGS_DIR%\deploy.log 2>&1
	GOTO params
:minify
	CALL %~dp0\src\minify.bat > %LOGS_DIR%\minify.log 2>&1
	GOTO params

:default
	CALL %~dp0\build.bat deploy minify

