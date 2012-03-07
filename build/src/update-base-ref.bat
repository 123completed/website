
:: Replace all occurences inside html files under content folder
FOR /F "tokens=*" %%I IN ('DIR /B /S /N %DEPLOY_DIR%\content\*.html') DO cscript //Nologo %~dp0\..\util\replace.vbs %%I %OLD_BASE_PATH% %NEW_BASE_PATH%

:: Replace all occurences inside html files under content folder
FOR /F "tokens=*" %%I IN ('DIR /B /S /N %DEPLOY_DIR%\admin\*.html') DO cscript //Nologo %~dp0\..\util\replace.vbs %%I %OLD_BASE_PATH% %NEW_BASE_PATH%

:: Replace all occurences inside index.html
cscript //Nologo %~dp0\..\util\replace.vbs %DEPLOY_DIR%\index.html %OLD_BASE_PATH% %NEW_BASE_PATH%

:: Replace all occurences inside components.html
cscript //Nologo %~dp0\..\util\replace.vbs %DEPLOY_DIR%\snippets\components.html %OLD_BASE_PATH% %NEW_BASE_PATH%

:: Replace base path inside util.js
cscript //Nologo %~dp0\..\util\replace.vbs %DEPLOY_DIR%\js\util.js %OLD_BASE_PATH% %NEW_BASE_PATH%
