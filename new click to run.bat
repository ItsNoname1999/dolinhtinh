@echo off
setlocal enabledelayedexpansion

:: --- Hiển thị tiêu đề và hướng dẫn ---
echo --------------------------------------------
echo      YT-DLP VIDEO DOWNLOADER FOR WINDOWS
echo --------------------------------------------
echo.
echo Paste video URL below (right-click or Ctrl+V), then press Enter:
set /p "video_url=> "

:: --- Kiểm tra yt-dlp.exe tồn tại ---
if not exist yt-dlp.exe (
    echo ERROR: yt-dlp.exe not found in current directory!
    pause
    exit /b
)

:: --- Kiểm tra cookies.txt ---
if exist cookies.txt (
    set "cookies_opt=--cookies cookies.txt"
) else (
    echo [WARNING] cookies.txt not found. Some videos may fail.
    set "cookies_opt="
)

:: --- Tải video với chất lượng tốt nhất ---
yt-dlp.exe ^
  --user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64)" ^
  %cookies_opt% ^
  -f "bv*+ba/b" ^
  --merge-output-format mp4 ^
  --output "%%(title)s.%%(ext)s" ^
  "%video_url%"

echo.
echo [DONE] Download completed.
pause
