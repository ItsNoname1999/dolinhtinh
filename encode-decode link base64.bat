@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

:menu
cls
echo ================================
echo        BASE64 TOOL (CMD)
echo ================================
echo.
echo 1. DECODE Base64 (n times)
echo 2. ENCODE Base64 (n times)
echo 0. EXIT
echo.
set /p choice=Choose function (0-2): 

if "%choice%"=="1" goto decode
if "%choice%"=="2" goto encode
if "%choice%"=="0" exit
goto menu

:: ================== DECODE ==================
:decode
cls
echo ==== DECODE BASE64 ====
echo.
set /p input=Input Base64 string: 
set /p n=Times to decode (n): 

echo !input! > step0.txt
set prev=step0.txt
set i=1
echo (Link should appear before the first error message)

:dec_loop
if !i! GTR !n! goto end_decode

certutil -decode !prev! step!i!.txt >nul 2>nul

echo.

echo Decode attempt !i! :
type step!i!.txt

set prev=step!i!.txt
set /a i+=1
goto dec_loop

:end_decode
del step*.txt >nul 2>nul
pause
goto menu

:: ================== ENCODE ==================
:encode
cls
echo ==== ENCODE BASE64 ====
echo.
set /p input=Input original string/link: 
set /p n=Times of encode (n): 
echo !input! > step0.txt
set prev=step0.txt
set i=1

:enc_loop
if !i! GTR !n! goto end_encode

certutil -encode !prev! raw!i!.txt >nul
findstr /v "CERTIFICATE" raw!i!.txt > step!i!.txt

echo.
echo Encode attempt !i!:
type step!i!.txt

set prev=step!i!.txt
set /a i+=1
goto enc_loop

:end_encode
del step*.txt raw*.txt >nul 2>nul
pause
goto menu
