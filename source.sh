#!/bin/bash

RED=""
GREEN=""
YELLOW=""
RESET=""

format_time() {
    # TODO: zamień sekundy na MM:SS
    local time_sec=$1
    minutes=$(( time_sec / 60 ))
    seconds=$(( time_sec - minutes * 60 ))
    if [[ $minutes -le 9 ]]; then
    	echo -n "0"
    fi
    echo -n $minutes":"
    if [[ $seconds -le 9 ]];then
	echo -n "0"
    fi
    echo -n $seconds" "
     
}

progress_bar() {
    local current=$1 total=$2
    # TODO: policz procent i wyświetl pasek
    currentProgressBar=$((current/total))
    precentProgressBar=$(( currentProgressBar * 100 ))
    echo -n "[#"
    while [[ $currentProgressBar -ne 0 ]]; do
    	currentProgressBar=$currentProgressBar-1
	echo -n "#"
    done
    echo "] "$precentProgressBar"%"
}

log_event() {
    # TODO: logowanie do pliku
    echo "log" >> ~/laboratoria/lab4/logs.txt
}

#interrupt() {
    # TODO: potwierdzenie zakończenia
    
#}
trap interrupt SIGINT

run_pomodoro() {
    local work=${1:-25}
    local breaks=${2:-5}
    local cycles=${3:-4}

    local newWork=$work
    local newBreaks=0
    local time=0
    local breakTime=0

    while [[ $cycles -ne 0 ]];
    do
    	work=$1
	while [[ $work -ne 0 ]]; do
		work=$work-1
		time=$((time + 1))
		format_time $time
		progress_bar $(( newWork-work )) $newWork
		sleep 1
	done
	breaks=$2
	newBreaks=$(( newBreaks + 1 ))
	breakTime=0
	echo "Przerwa: "$newBreaks
	while [[ $breaks -ne 0 ]]; do
		breaks=$breaks-1
		sleep 1
		format_time $breakTime
		breakTime=$(( breakTime + 1))
		echo ""
	done
	echo "Koniec Przerwy!!"

	cycles=$cycles-1
    done
    echo $work
    echo $break
    echo $cycles
    # TODO: pętla cykli pomodoro
}

run_stoper() {
    local running=false
    local sec=0

    while true; do
        echo "1) Start"
        echo "2) Stop"
        echo "3) Reset"
        echo "4) Exit"
        echo -n "Wybór: "
        read choice

        case $choice in
            1)
                # TODO: start
                ;;
            2)
                # TODO: stop
                ;;
            3)
                # TODO: reset
                ;;
            4)
                exit 0
                ;;
            *)
                echo "Nieznana opcja"
                ;;
        esac
    done
}

case "$1" in
    pomodoro)
        run_pomodoro "$2" "$3" "$4"
        ;;
    stoper)
        run_stoper
        ;;
    *)
        echo "Użycie:"
        echo "  $0 pomodoro [czas_pracy] [czas_przerwy] [cykle]"
        echo "  $0 stoper"
        ;;
esac


