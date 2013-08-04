@ECHO OFF
:: script for Windows to supply fork() to rakudo
:: based on IO-Socket-INET.sh
SET TEST=%1
SET PORT=%2

:: clear the status message flag but don't whinge about the file not being there
DEL t\spec\S32-io\server-ready-flag 2> NUL

:: Use START to fork the server and set the window title so we can kill it later
START "P6IOSOCKETtest" /MIN perl6 t\spec\S32-io\IO-Socket-INET.pl %TEST% %PORT% server

perl6 t\spec\S32-io\IO-Socket-INET.pl %TEST% %PORT% client

:: Clean up any stray processes
TASKKILL /FI "WINDOWTITLE eq P6IOSOCKETtest" > NUL