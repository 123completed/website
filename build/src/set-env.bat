
:: ECHO.[DEBUG] set-env invoked with the following arguments: [%*]

SET SRC=D:\EliranMalka\PerDevWorkspace\123completed-website\WebContent
SET JAXER_WORK_DIR=D:\EliranMalka\Servers\Jaxer\public
SET DEPLOY_DIR=%JAXER_WORK_DIR%
SET LOGS_DIR=%~dp0\..\logs

:params
SHIFT
IF "%0"=="" GOTO :EOF
IF "%0"=="backup" GOTO backup
IF "%0"=="deploy" GOTO deploy
IF "%0"=="minify" GOTO minify

:backup
:: ECHO.[DEBUG] set-env :backup invoked
	SET BACKUP_DIR=D:\EliranMalka\Backup
	SET BACKUP_NEW=%BACKUP_DIR%\new\123completed-site-deployment
	SET BACKUP_OLD=%BACKUP_DIR%\old\123completed-site-deployment
	GOTO params

:deploy
:: ECHO.[DEBUG] set-env :deploy invoked
	SET OLD_BASE_PATH=/123completed-website/WebContent/
	SET NEW_BASE_PATH=/
	GOTO params

:minify
:: ECHO.[DEBUG] set-env :minify invoked
	SET TEMP_DIR=%~dp0\temp
	SET YUI_COMP_HOME=D:\EliranMalka\Tools\yuicompressor-2.4.7\build\yuicompressor-2.4.7.jar
	SET INPUT_JS=*.js
	SET OUTPUT_JS=.js$:-min.js
::	SET INPUT_JS_UTIL=util.js
::	SET OUTPUT_JS_UTIL=util-min.js
	SET INPUT_JS_INNERFADE=jquery.innerfade.js
	SET OUTPUT_JS_INNERFADE=jquery.innerfade-min.js
	SET INPUT_CSS=*.css
	SET OUTPUT_CSS=.css$:-min.css
	SET INPUT_CSS_SUPERFISH=superfish.css
	SET OUTPUT_CSS_SUPERFISH=superfish-min.css
	SET INPUT_CSS_960GS=fluid_grid.css
	SET OUTPUT_CSS_960GS=fluid_grid-min.css
	GOTO params

