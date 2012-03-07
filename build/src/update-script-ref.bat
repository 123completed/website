:: ECHO.[DEBUG] update-script-ref invoked...

:: arguments [ref-filename]

SET REF=%1
SET SUFFIX=%REF:~-3%
IF "%SUFFIX%"==".js" GOTO set-js
IF "%SUFFIX%"=="css" GOTO set-css

:set-js
:: ECHO.DEBUG set-js...
	SET SUBSTR=%REF:~0,-3%
	SET OLD=/%SUBSTR%.js
	SET NEW=/%SUBSTR%-min.js
	GOTO replace

:set-css
:: ECHO.DEBUG set-css...
	SET SUBSTR=%REF:~0,-4%
	SET OLD=/%SUBSTR%.css
	SET NEW=/%SUBSTR%-min.css
	GOTO replace

:: This function uses an external script to search and replace text strings IN files.
:replace
:: ECHO.DEBUG replace...
	:: Replace all occurences inside html files under content folder
	FOR /F "tokens=*" %%I IN ('DIR /B /S /N %DEPLOY_DIR%\content\*.html') DO cscript //Nologo %~dp0\..\util\replace.vbs %%I %OLD% %NEW%
	:: Replace all occurences inside html files under administration folder
	FOR /F "tokens=*" %%I IN ('DIR /B /S /N %DEPLOY_DIR%\admin\*.html') DO cscript //Nologo %~dp0\..\util\replace.vbs %%I %OLD% %NEW%
	:: Replace all occurences inside index.html
	cscript //Nologo %~dp0\..\util\replace.vbs %DEPLOY_DIR%\index.html %OLD% %NEW%

