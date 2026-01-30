@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

:menu
cls
echo ================================
echo        BASE64 TOOL (CMD)
echo ================================
echo.
echo 1. GIAI MA Base64 (n lan)
echo 2. MA HOA Base64 (n lan)
echo 0. Thoat
echo.
set /p choice=Chon chuc nang (0-2): 

if "%choice%"=="1" goto decode
if "%choice%"=="2" goto encode
if "%choice%"=="0" exit
goto menu

:: ================== DECODE ==================
:decode
cls
echo ==== GIAI MA BASE64 ====
echo.
set /p input=Nhap chuoi Base64: 
set /p n=Nhap so lan muon giai (n): 

echo !input! > step0.txt
set prev=step0.txt
set i=1

:dec_loop
if !i! GTR !n! goto end_decode

certutil -decode !prev! step!i!.txt >nul 2>nul

echo.
echo Giai lan !i!:
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
echo ==== MA HOA BASE64 ====
echo.
set /p input=Nhap chuoi / link goc: 
set /p n=Nhap so lan muon ma hoa (n): 

echo !input! > step0.txt
set prev=step0.txt
set i=1

:enc_loop
if !i! GTR !n! goto end_encode

certutil -encode !prev! raw!i!.txt >nul
findstr /v "CERTIFICATE" raw!i!.txt > step!i!.txt

echo.
echo Ma lan !i!:
type step!i!.txt

set prev=step!i!.txt
set /a i+=1
goto enc_loop

:end_encode
del step*.txt raw*.txt >nul 2>nul
pause
goto menu