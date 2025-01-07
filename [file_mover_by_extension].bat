@echo off

:input
rem Nhập định dạng đuôi file từ người dùng
set /p fileExtension="Nhap dinh dang duoi file (khong nhap dau cham, VD: jpg, png, mp3, ...): "

rem Kiểm tra xem định dạng đuôi file có hợp lệ hay không
if "%fileExtension%"=="" (
    echo Dinh dang duoi file khong hop le. Vui long nhap lai.
    goto input
)

rem Kiểm tra xem có file nào có định dạng đuôi file đã nhập không
set "fileExists=0"
for %%f in (*.%fileExtension%) do (
    set "fileExists=1"
    goto break
)
:break

if "%fileExists%"=="0" (
    echo Khong ton tai file co dinh dang .%fileExtension%.
    goto inputlater
)

rem Hỏi người dùng có muốn lưu vào thư mục tên tự đặt không
:inputnext
set /p customFolder="Ban co muon luu vao thu muc ten tu dat khong? [yes (y)/no (n)]: "
if /i "%customFolder%"=="y" (
    rem Nhập tên thư mục từ người dùng
    set /p folderName="Nhap ten thu muc: "
) else (
    if /i "%customFolder%"=="n" (
        rem Sử dụng tên thư mục là định dạng file nhập vào
        set "folderName=%fileExtension%"
    ) else (
        echo Nhap vao khong hop le. Vui long nhap lai.
        goto inputnext
    )
)

rem Tạo thư mục mới với tên đã được chọn
mkdir "%folderName%"

rem Di chuyển các file có định dạng như vậy vào thư mục mới tạo
for %%f in (*.%fileExtension%) do (
    rem Bỏ qua tệp đang chạy
    if not "%%~nxf"=="%~nx0" (
        move "%%f" "%folderName%\"
    )
)

rem Mở thư mục mới tạo trong cửa sổ Windows mới
start "" "%cd%\%folderName%"

echo Da di chuyen cac file co dinh dang ".%fileExtension%" vao thu muc "%folderName%" va mo thu muc.
pause

:inputlater
set /p continue="Ban co muon tiep tuc? [yes (y)/no (n)]: "
if /i "%continue%"=="y" (
    goto input
) else (
    if /i "%continue%"=="n" (
        exit /b
    ) else (
        echo Nhap vao khong hop le. Vui long nhap lai.
        goto inputlater
    )
)
