@echo off

set PROMPT=$P$_$+$G$S

DOSKEY p4diff=p4 revert -n ./...
DOSKEY start_bash="%PROGRAMFILES%\Git\bin\sh.exe" --login

DOSKEY clear=cls
DOSKEY ls=dir /B $*

