
ECHO.
ECHO.[INFO] minify invoked...
ECHO.
ECHO.[INFO] using YUI Compressor (JavaScript / CSS minifyer and obfuscuation compiler)

ECHO.
ECHO.[INFO] minifying JavaScript resources started

DEL %TEMP_DIR%\js /F /S /Q
DEL %TEMP_DIR%\lib\jquery.innerfade\js /F /S /Q
DEL %TEMP_DIR%\lib\superfish-1.4.8\js /F /S /Q
XCOPY %DEPLOY_DIR%\js %TEMP_DIR%\js /Q
XCOPY %DEPLOY_DIR%\lib\jquery.innerfade\js %TEMP_DIR%\lib\jquery.innerfade\js /Q
XCOPY %DEPLOY_DIR%\lib\superfish-1.4.8\js %TEMP_DIR%\lib\superfish-1.4.8\js /Q

ECHO.
ECHO.[INFO] activating YUI compressor FOR JavaScript resources
PUSHD %TEMP_DIR%\js
::java -jar %YUI_COMP_HOME% -o %OUTPUT_JS_UTIL% %INPUT_JS_UTIL%
java -jar %YUI_COMP_HOME% -o %OUTPUT_JS% %INPUT_JS%
POPD
PUSHD %TEMP_DIR%\lib\jquery.innerfade\js
java -jar %YUI_COMP_HOME% -o %OUTPUT_JS_INNERFADE% %INPUT_JS_INNERFADE%
POPD
PUSHD %TEMP_DIR%\lib\superfish-1.4.8\js
java -jar %YUI_COMP_HOME% -o %OUTPUT_JS% %INPUT_JS%
POPD

ECHO.
ECHO.[INFO] moving minified JavaScript files to corresponding deploy directory
DEL %DEPLOY_DIR%\js /F /S /Q
DEL %DEPLOY_DIR%\lib\jquery.innerfade\js /F /S /Q
DEL %DEPLOY_DIR%\lib\superfish-1.4.8\js /F /S /Q
MOVE /Y %TEMP_DIR%\js\*-min.js %DEPLOY_DIR%\js
MOVE /Y %TEMP_DIR%\lib\jquery.innerfade\js\*-min.js %DEPLOY_DIR%\lib\jquery.innerfade\js
MOVE /Y %TEMP_DIR%\lib\superfish-1.4.8\js\*-min.js %DEPLOY_DIR%\lib\superfish-1.4.8\js

ECHO.
ECHO.[INFO] updating JavaScript refereces inside HTML files (replacing suffixes with '-min.js')
:: For all files inside js folder
PUSHD %~dp0
FOR /F "tokens=*" %%I IN ('DIR /B %TEMP_DIR%\js\*.js') DO CALL update-script-ref.bat %%I
:: For unminified external JS libraries
FOR /F "tokens=*" %%I IN ('DIR /B %TEMP_DIR%\lib\jquery.innerfade\js\*.js') DO CALL update-script-ref.bat %%I
FOR /F "tokens=*" %%I IN ('DIR /B %TEMP_DIR%\lib\superfish-1.4.8\js\*.js') DO CALL update-script-ref.bat %%I
POPD

ECHO.
ECHO.[INFO] minifying JavaScript resources finished


ECHO.
ECHO.[INFO] minifying CSS resources started

DEL %TEMP_DIR%\css /F /S /Q
DEL %TEMP_DIR%\lib\superfish-1.4.8\css /F /S /Q
DEL %TEMP_DIR%\lib\960gs\fluid /F /S /Q
XCOPY %DEPLOY_DIR%\css %TEMP_DIR%\css /Q
XCOPY %DEPLOY_DIR%\lib\superfish-1.4.8\css %TEMP_DIR%\lib\superfish-1.4.8\css /Q
XCOPY %DEPLOY_DIR%\lib\960gs\fluid %TEMP_DIR%\lib\960gs\fluid /Q

ECHO.
ECHO.[INFO] activating YUI compressor FOR CSS resources
PUSHD %TEMP_DIR%\css
java -jar %YUI_COMP_HOME% -o %OUTPUT_CSS% %INPUT_CSS%
POPD
PUSHD %TEMP_DIR%\lib\superfish-1.4.8\css
java -jar %YUI_COMP_HOME% -o %OUTPUT_CSS_SUPERFISH% %INPUT_CSS_SUPERFISH%
POPD
PUSHD %TEMP_DIR%\lib\960gs\fluid
java -jar %YUI_COMP_HOME% -o %OUTPUT_CSS_960GS% %INPUT_CSS_960GS%
POPD

ECHO.
ECHO.[INFO] moving minified CSS files to corresponding deploy directory
DEL %DEPLOY_DIR%\css /F /S /Q
DEL %DEPLOY_DIR%\lib\superfish-1.4.8\css /F /S /Q
DEL %DEPLOY_DIR%\lib\960gs\fluid /F /S /Q
MOVE /Y %TEMP_DIR%\css\*-min.css %DEPLOY_DIR%\css
MOVE /Y %TEMP_DIR%\lib\superfish-1.4.8\css\*-min.css %DEPLOY_DIR%\lib\superfish-1.4.8\css
MOVE /Y %TEMP_DIR%\lib\960gs\fluid\*-min.css %DEPLOY_DIR%\lib\960gs\fluid

ECHO.
ECHO.[INFO] updating CSS refereces inside HTML files (replacing suffixes with '-min.css')
PUSHD %~dp0
:: For all files inside css folder
FOR /F "tokens=*" %%I IN ('DIR /B %TEMP_DIR%\css\*.css') DO CALL update-script-ref.bat %%I
:: For unminified external libraries
FOR /F "tokens=*" %%I IN ('DIR /B %TEMP_DIR%\lib\superfish-1.4.8\css\*.css') DO CALL update-script-ref.bat %%I
FOR /F "tokens=*" %%I IN ('DIR /B %TEMP_DIR%\lib\960gs\fluid\*.css') DO CALL update-script-ref.bat %%I
POPD

ECHO.
ECHO.[INFO] minifying CSS resources finished
