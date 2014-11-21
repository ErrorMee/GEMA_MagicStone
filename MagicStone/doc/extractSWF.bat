@echo off
echo SQ BUILD
Rem * 说明: FLEX_SDK配置SDK路径 RAREXE配置WinRAR路径 BASEDIR配置项目根路径 MODULE_LIST配置所有模块 MAIN_PUB可调整GameMain发布路径 *

:ChoiceBuild
set /p ChoiceBuild=Please select [Y](batch build) or [N](Don't build extraction SWF):
if "%ChoiceBuild%"=="y" (
		echo batch build
		set BATBUILD=true
	) else (
		echo Don't build extraction SWF
		set BATBUILD=false
	)

if %BATBUILD%==false (
	goto NOCHIOCE
)

:ChoiceDebug
set /p ChoiceDebug=Please select [Y](build debug) or [N](build release):
if "%ChoiceDebug%"=="y" (
		echo debug
		set ISDEBUG=true
		goto CHOICEEND
	) else (
		echo release
		set ISDEBUG=false
		goto CHOICEEND
	)

:NOCHIOCE
set ISDEBUG=false
:CHOICEEND

echo BATBUILD = %BATBUILD%
echo ISDEBUG = %ISDEBUG%

set FLEX_SDK="D:\anzhuangweizhi\fb\Adobe Flash Builder 4.6\sdks\4.6.0"
Set RAREXE=D:\anzhuangweizhi\winrar\WinRAR
set BASEDIR=F:\mydata\work\Mobile\GEMA_MagicStone
set MODULE_SAVE_DIR=%BASEDIR%\MagicStone\assets\modules

set COMMON_PUB="%BASEDIR%\Common\bin"
set COMMON_APP="%BASEDIR%\Common\src"
if %BATBUILD%==true (
	echo ...COMPC Common START
	%FLEX_SDK%\bin\compc 	-swf-version=17 -target-player=11.1 -output=%COMMON_PUB%\Common.swc -optimize=true -strict=false -debug=%ISDEBUG% -locale=en_US^
							-include-libraries+=%BASEDIR%\Common\libs -external-library-path+=%BASEDIR%\Moebius\bin\Moebius.swc ^
							-external-library-path+=%FLEX_SDK%\frameworks\libs\player\11.1\playerglobal.swc -incremental=true -show-actionscript-warnings=true ^
							-static-link-runtime-shared-libraries=true -include-sources+=%COMMON_APP%
	echo ...COMPC Common SUCCESSFUL
)

rem set UNZIPFILECOMMON=%COMMON_PUB%\Common.swc
rem %RAREXE% x %UNZIPFILECOMMON% %MODULE_SAVE_DIR%\ -y -IBCK
rem Move %MODULE_SAVE_DIR%\library.swf %MODULE_SAVE_DIR%\Common.swf
rem echo %MODULE_SAVE_DIR%\Common.swf

set MAIN_PUB="%BASEDIR%\Main\GameMain\bin-release"
set MAIN_APP="%BASEDIR%\Main\GameMain\src\GameMain.as"
if %BATBUILD%==true (
	echo ...MXMLC main START
	%FLEX_SDK%\bin\mxmlc 	-swf-version=17 -target-player=11.1 -output=%MAIN_PUB%\GameMain.swf -optimize=true -strict=false -debug=%ISDEBUG% -locale=en_US^
							-include-libraries+=%BASEDIR%\Main\GameMain\libs ^
							-library-path+=%BASEDIR%\Moebius\bin\Moebius.swc -external-library-path+=%BASEDIR%\Common\bin\Common.swc ^
							-external-library-path+=%FLEX_SDK%\frameworks\libs\player\11.1\playerglobal.swc -incremental=true -show-actionscript-warnings=true ^
							-static-link-runtime-shared-libraries=true %MAIN_APP%
	echo ...MXMLC main SUCCESSFUL
)


if %BATBUILD%==true (echo ...COMPC MODULES START)
set MODULEDIR="%BASEDIR%\Module"
set MODULE_LIST=(ControlModule,StartModule,FightModule)

for %%i in %MODULE_LIST% do (
	if %BATBUILD%==true (
		echo ......COMPC %%i TO %MODULEDIR%\%%i\bin\%%i.swc...
   		%FLEX_SDK%\bin\compc -swf-version=17 -target-player=11.1 -output=%MODULEDIR%\%%i\bin\%%i.swc -optimize=true -strict=false -debug=%ISDEBUG% -locale=en_US^
						-include-libraries+=%MODULEDIR%\%%i\lib ^
						-external-library-path+=%BASEDIR%\Moebius\bin\Moebius.swc ^
						-external-library-path+=%BASEDIR%\Common\bin\Common.swc ^
						-external-library-path+=%FLEX_SDK%\frameworks\libs\player\11.1\playerglobal.swc ^
						-incremental=true -show-actionscript-warnings=true ^
						-static-link-runtime-shared-libraries=true -include-sources+=%MODULEDIR%\%%i\src
	)

	%RAREXE% x %MODULEDIR%\%%i\bin\%%i.swc %MODULE_SAVE_DIR%\ -y -IBCK
	Move %MODULE_SAVE_DIR%\library.swf %MODULE_SAVE_DIR%\%%i.swf
	echo %MODULE_SAVE_DIR%\%%i.swf
)
Del %MODULE_SAVE_DIR%\*.xml
if %BATBUILD%==true (echo ...COMPC MODULES SUCCESSFUL)
echo ...TASK SUCCESSFUL
pause
