
ECHO.
ECHO.[INFO] deploy invoked...

DEL %DEPLOY_DIR% /F /S /Q
XCOPY %SRC% %DEPLOY_DIR% /S /Q

PUSHD %~dp0
CALL update-base-ref.bat
POPD

