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
echo * 3. Clonar URL do Repositorio     *
echo * 4. Ver Configuracoes             *
echo * 5. Sair                          * 
echo  ==================================

set /p opcao= Escolha uma opcao: 
echo ------------------------------
if %opcao% equ 1 goto opcao1
if %opcao% equ 2 goto opcao2
if %opcao% equ 3 goto opcao3
if %opcao% equ 4 goto opcao4
if %opcao% equ 5 goto opcao5
if %opcao% equ "" goto opcao6
if %opcao% GEQ 6 goto opcao6

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
set /p repository= usuario/repositorio ou grupo/repositorio (%repository1%):
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
set /p repository= usuario/repositorio ou grupo/repositorio (%repository1%):
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
git clone -b master "https://%token1%@github.com/%repository1%" output
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
echo * 2. Push Padrao                    * 
echo * 3. Voltar                        *
echo  ==================================

set /p opcao= Escolha uma opcao: 
echo ------------------------------
if %opcao% equ 1 goto FOP
if %opcao% equ 2 goto publicar
if %opcao% equ 3 goto menu

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
set /p user= Nome do Usuario (%user1%):
set /p email= Email (%email1%):
set /p urlrepository= Url do Repositorio (%urlrepository%):
git config --global user.name %user%
git config --global user.email %email%
git config --global core.editor notepad
git config --list
git clone -b master "%urlrepository%" output
explorer output
echo EDITE OS ARQUIVOS E TECLE ENTER PARA FINALIZAR
)
pause
goto publicar

:opcao4
cls
git config --list
pause
goto menu

:opcao5
cls
exit

:temp1
cls
cd..
RMDIR output /S /Q
cls
goto menu

:opcao6
cls
echo ==============================================
echo * Opcao Invalida! Escolha outra opcao do menu *
echo ==============================================
pause
goto menu