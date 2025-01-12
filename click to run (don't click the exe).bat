@echo off

echo Dan link YouTube vao day
set /p params=
cd /d C:\Users\Nguye\Desktop\youtubedowloader
start yt-dlp.exe %params%
