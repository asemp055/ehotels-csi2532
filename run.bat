@echo off
echo ======================================
echo   e-Hotels - Compilation et demarrage
echo ======================================

if not exist "lib\postgresql.jar" (
    echo ERREUR : lib\postgresql.jar introuvable !
    echo Telechargez-le sur https://jdbc.postgresql.org/download/
    pause & exit /b 1
)

if not exist "out" mkdir out

echo [1/2] Compilation...

javac -cp "lib\postgresql.jar" -d out src\DB.java src\Util.java src\ChambreHandler.java src\ClientHandler.java src\EmployeHandler.java src\ReservationHandler.java src\Main.java

if errorlevel 1 (
    echo ERREUR de compilation !
    pause & exit /b 1
)

echo OK
echo [2/2] Demarrage...
echo.
echo Ouvrez : http://localhost:8080
echo Ctrl+C pour arreter
echo.

java -cp "out;lib\postgresql.jar" Main

pause