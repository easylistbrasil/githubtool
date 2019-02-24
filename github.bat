@echo off
title EasyList Brasil Config
cls
:menu
if exist "output" (
	RMDIR output /S /Q
)
cls
color 80

echo  ==================================
echo * 1. Configurar git                * 
echo * 2. Atualizar                     *
echo * 3. Sair                          * 
echo  ==================================

set /p opcao= Escolha uma opcao: 
echo ------------------------------
if %opcao% equ 1 goto opcao1
if %opcao% equ 2 goto opcao2
if %opcao% equ 3 goto opcao3
if %opcao% equ "" goto opcao4
if %opcao% GEQ 4 goto opcao4

:opcao1
cls
del .gitconfig /S
cls

if exist "gconfig.bat" (
	goto config1
) else (
    goto config2
)

:config1
call gconfig.bat
del .gitconfig /S
cls
set /p user= Nome do Usuario (%user1%):
set /p email= Email (%email1%):
set /p repository= Repositorio (%repository1%):
set /p token= Token:
echo. set user1=%user%> gconfig.bat
echo. set email1=%email%>> gconfig.bat
echo. set repository1=%repository%>> gconfig.bat
echo. set token1=%token%>> gconfig.bat
git config --global user.name %user%
git config --global user.email %email%
git config --global core.editor notepad
git config --list
pause
goto menu

:config2
del .gitconfig /S
cls
set /p user= Nome do Usuario (%user1%):
set /p email= Email (%email1%):
set /p repository= Repositorio (%repository1%):
set /p token= Token:
echo. set user1=%user%> gconfig.bat
echo. set email1=%email%>> gconfig.bat
echo. set repository1=%repository%>> gconfig.bat
echo. set token1=%token%>> gconfig.bat
git config --global user.name %user%
git config --global user.email %email%
git config --global core.editor notepad
git config --list
pause
goto menu

:opcao2
cls

if exist "gconfig.bat" (
	goto clonar
) else (
    goto config2
)

:clonar
cls
echo CLONAR REPOSITORIO:
call gconfig.bat
if exist "output" (
	RMDIR output /S /Q
goto clonar
) else (
call gconfig.bat
git clone -b master "https://%token1%@github.com/%user1%/%repository1%.git" output
explorer output
echo EDITE OS ARQUIVOS E TECLE ENTER PARA FINALIZAR
)
pause
goto confirmar
echo goto publicar

:confirmar
cls
echo  ==================================
echo * 1. Continuar                     * 
echo * 2. Voltar                        *
echo  ==================================

set /p opcao= Escolha uma opcao: 
echo ------------------------------
if %opcao% equ 1 goto FOP
if %opcao% equ 2 goto menu

:FOP
cd output
FOP.py
pause
goto temp1

:publicar
cls
set /p message= Menssagem do Commit: 
call gconfig.bat
cls
cd output
git add --all .
git commit -m "%message%"
git push origin master
pause
goto temp1

:opcao3
cls
exit

:temp1
cls
cd..
RMDIR output /S /Q
cls
goto menu

:opcao4
cls
echo ==============================================
echo * Opcao Invalida! Escolha outra opcao do menu *
echo ==============================================
pause
goto menu