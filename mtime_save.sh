#!/bin/bash
# ;;;;;;;;;;;;;;;;;; mtime_save.sh ver.02 lang=ru,en ;;;;;;;;;;
# Скрипт сохраняет прежнее время модификации после редактирования файла
# Script precerved mtime attribut file after his editing
##########
# Warning: my colorize scheme in your terminal may look bad. it's requires personal tuning.
clr1="\e[1;31m"      # red bold
clr2=$(tput setaf 220; tput setab 88) # yellow on red
clr3=$(tput setaf 11) # yellow
clr4=$(tput setaf 15) # white
end_=$(tput sgr0)
badex_=6999
# Если обьявить переменную $mtime_ здесь, то stat будет выдавать ошибку при отсутствии или неверном имени файла в аргументе скрипта
# If declare variable $mtime here, possible errors from stat
if [[ -z "$1"  ]]; then
#   echo "$clr3""Скрипт для сохранения прежнего времени модификации файла после его редактирования""$end_"
echo "$clr3""Script precerved mtime attribut after editing file""$end_"
    echo "$clr2""Using:"$end_" "${0##*/}" \"/full/name/file\""
    exit $badex_
    else
        if [[ -f "$1" ]]; then
echo "Put editor name (or first letter) for file"$clr4""${1##*/}"$end_"":
"$clr4"v"$end_"im, "$clr4"x"$end_"ed, "$clr4"lo"$end_" (LibreOffice) or "$clr4"ko"$end_" (KomodoEdit):"
# For Ubuntu, Mint 17.xx( and before, or other Ubuntu-based OS, used
#  "$clr4"v"$end_"im, "$clr4"g"$end_"edit, "$clr4"lo"$end_" (LibreOffice) or "$clr4"ko"$end_" (KomodoEdit):"
mtime_=$(stat -c %y "$1" 2>/dev/null)
            read edit
                case $edit in
v|vim) /usr/bin/vim "$1"                                  ;;
x|xed) /usr/bin/xed "$1"                                   ;;
# g|gedit) /usr/bin/gedit "$1"                             ;;   # for Ubuntu etc see above
lo)  /usr/bin/libreoffice "$1"                            ;;
ko) $HOME/Komodo-Edit-*/lib/mozilla/komodo "$1"     ;;
*) echo -e "$clr1""Unknow editor...""$end_"    ;;
                esac
                    else
            echo -e "$clr1""File "$end_""$clr4""$1""$end_" "$clr1"not found""$end_"
            exit $badex_
        fi
fi
    wait
touch -d "${mtime_}" "$1"
exit 0
