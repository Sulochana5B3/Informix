#!/bin/bash
#===================================================================================
# FILE        : ifxmonitor_rataktp1_vm.sh
# USAGE       : sh ifxmonitor_rataktp1_vm.sh
# DESCRIPTION : Informix monitoring for rataktp1_vm only.
# NOTES       : Consolidated from ifxmonitor.sh. Other instances were removed.
# AUTHOR      : Sulochana Vemula / consolidated for rataktp1_vm
# VERSION     : IFXMONITOR V2.00-rataktp1
#===================================================================================

WORKDIR=/opt/informix/ifxmonitor
INSTANCE=rataktp1_vm
BACKUP_ID=act1
NOCtime=""

function ClearVar {
    wl_rataktp1=0
    ol_rataktp1=0
    cl_rataktp1=0
    oi_rataktp1=0

    DayMon=""
    st_sec=""; st_min=""; st_hr=""; st_dt=""; st_mnth_numeric=""; st_year_cut=""
    end_sec=""; end_min=""; end_hr=""; end_dt=""; end_mnth_numeric=""; end_year_cut=""
    exact_time=""
    exact_diff_act1=""
    count_err_act1=""
    Begin_line_act1=""
    End_line_act1=""
    Begin_line_temp=""
    End_line_temp=""
    count_temp=""
    count_err_temp=""
    oi_temp=""
    wl_temp=""
    ol_temp=""
    cl_temp=""
}

function write_html {
    : > "$HTMLFILE"
    echo "<html>" >> "$HTMLFILE"
    echo "<head>" >> "$HTMLFILE"
    echo "<title class='header'>Tramomonitor</title>" >> "$HTMLFILE"
    echo "<meta http-equiv='refresh' content='1066'>" >> "$HTMLFILE"
    echo "<meta http-equiv='pragma' content='no-cache'>" >> "$HTMLFILE"
    echo "<link rel='stylesheet' type='text/css' href='logmonitor.css'>" >> "$HTMLFILE"
    echo "</head>" >> "$HTMLFILE"
    echo "<body class='backgrd'>" >> "$HTMLFILE"
    echo "<table width='100%' border='0' bgcolor='red' cellspacing='0' cellpadding='0'>" >> "$HTMLFILE"
    echo "<tr>" >> "$HTMLFILE"
    echo "<td width='20%' height='56' align='center' valign='center'><img src='vodafone.gif' align='center'></td>" >> "$HTMLFILE"
    echo "<td width='60%' align='center' valign='center' class='header'>Informix Instance rataktp1_vm @ Tramo Environment</td>" >> "$HTMLFILE"
    echo "<td width='20%' align='center' valign='center'><img src='vodafone.gif' align='center'></td>" >> "$HTMLFILE"
    echo "</tr>" >> "$HTMLFILE"
    echo "</table>" >> "$HTMLFILE"

    echo "<table width='100%' border='3' class='backgrd' align='center' cellspacing='0' cellpadding='2'>" >> "$HTMLFILE"
    echo "<tr align='left'>" >> "$HTMLFILE"
    echo "<td width='40%'><b>Running since: $RUNNING_SINCE_DATE</b></td>" >> "$HTMLFILE"
    echo "<td width='20%'>&nbsp;</td>" >> "$HTMLFILE"
    echo "<td width='40%'><b>Last update: $DATUM_LAUF</b></td>" >> "$HTMLFILE"
    echo "</tr></table>" >> "$HTMLFILE"

    echo "<div>" >> "$HTMLFILE"
    echo "<table style='float:left;width:40%;border-width:3px;border-color:#FFFFFF;border-style:outset;padding:2px;background-color:#AAAAAA'>" >> "$HTMLFILE"
    echo "<tr align='center' valign='top'>" >> "$HTMLFILE"
    echo "<th class='app_header' style='width:140px;height:38.13px;'>DB Instance</th>" >> "$HTMLFILE"
    echo "<th class='app_header' style='width:324px;height:38.13px;'>Full Backup ($DayMon)</th>" >> "$HTMLFILE"
    echo "<th class='app_header' style='width:112px;height:38.13px;'>Full backup duration</th>" >> "$HTMLFILE"
    echo "<th class='app_header' style='width:144.5px;height:38.13px;'>Errors during backup</th>" >> "$HTMLFILE"
    echo "</tr>" >> "$HTMLFILE"

    echo "<tr style='height:18px;' align='left' valign='top'>" >> "$HTMLFILE"
    echo "<td class='app_header' style='width:140px;height:18px;'><strong>rataktp1</strong></td>" >> "$HTMLFILE"
    echo "<td class='eposBright' style='width:324px;height:18px;' nowrap='nowrap'>$Begin_line_act1</td>" >> "$HTMLFILE"
    echo "<td class='eposBright' style='width:112px;height:36px;text-align:center;' rowspan='2' nowrap='nowrap'>$exact_diff_act1</td>" >> "$HTMLFILE"
    if [ "${count_err_act1:-0}" -gt 0 ]; then
        echo "<td class='eposBright' style='width:144.5px;height:36px;text-align:center;' rowspan='2' nowrap='nowrap'><span style='background-color:#ff0000;'>$count_err_act1</span></td>" >> "$HTMLFILE"
    else
        echo "<td class='eposBright' style='width:144.5px;height:36px;text-align:center;' rowspan='2' nowrap='nowrap'>$count_err_act1</td>" >> "$HTMLFILE"
    fi
    echo "</tr>" >> "$HTMLFILE"
    echo "<tr style='height:18px;' align='center' valign='top'>" >> "$HTMLFILE"
    echo "<td class='app_header' style='width:140px;height:18px;' align='left'><strong>rataktp1</strong></td>" >> "$HTMLFILE"
    echo "<td class='eposBright' style='width:324px;height:18px;' align='left' nowrap='nowrap'>$End_line_act1</td>" >> "$HTMLFILE"
    echo "</tr></table></div>" >> "$HTMLFILE"

    echo "<div>" >> "$HTMLFILE"
    echo "<table style='float:left;width:40%;border-width:3px;border-color:#FFFFFF;border-style:outset;padding:2px;background-color:#AAAAAA'>" >> "$HTMLFILE"
    echo "<tr align='center' valign='top'>" >> "$HTMLFILE"
    echo "<th class='app_header' style='width:30px'>DB Instance</th>" >> "$HTMLFILE"
    echo "<th class='app_header' style='width:30px'>Num.Log.Logs written today</th>" >> "$HTMLFILE"
    echo "<th class='app_header' style='width:30px'>not saved Logs</th>" >> "$HTMLFILE"
    echo "<th class='app_header' style='width:30px'>Num.Log.Logs of Instance</th>" >> "$HTMLFILE"
    echo "<th class='app_header' style='width:30px'>Num of Oninit Processes</th>" >> "$HTMLFILE"
    echo "</tr>" >> "$HTMLFILE"
    echo "<tr align='left' valign='top'>" >> "$HTMLFILE"
    echo "<td class='app_header'><b>rataktp1</b></td>" >> "$HTMLFILE"
    echo "<td class='epos' align='center' valign='middle'>$wl_rataktp1</td>" >> "$HTMLFILE"

    if [ "$ol_rataktp1" != "?" ] && [ "$ol_rataktp1" -ge 10 ] && [ "$ol_rataktp1" -le 15 ]; then
        echo "<td class='eposBright' align='center' valign='middle'><span style='background-color:#ffff00;'>$ol_rataktp1</span></td>" >> "$HTMLFILE"
    elif [ "$ol_rataktp1" != "?" ] && [ "$ol_rataktp1" -gt 15 ]; then
        echo "<td class='eposBright' align='center' valign='middle'><span style='background-color:#ff0000;'>$ol_rataktp1</span></td>" >> "$HTMLFILE"
    else
        echo "<td class='eposBright' align='center' valign='middle'>$ol_rataktp1</td>" >> "$HTMLFILE"
    fi

    echo "<td class='epos' align='center' valign='middle'>$cl_rataktp1</td>" >> "$HTMLFILE"
    if [ "$oi_rataktp1" != "?" ] && [ "$oi_rataktp1" -lt 15 ]; then
        echo "<td class='epos' align='center' valign='middle'><span style='background-color:#ff0000;'>$oi_rataktp1</span></td>" >> "$HTMLFILE"
    else
        echo "<td class='epos' align='center' valign='middle'>$oi_rataktp1</td>" >> "$HTMLFILE"
    fi
    echo "</tr></table></div>" >> "$HTMLFILE"

    echo "<div>" >> "$HTMLFILE"
    echo "<table style='width:100%;border-width:2px;border-color:#FFFFFF;border-style:outset;background-color:#AAAAAA'>" >> "$HTMLFILE"
    echo "<thead><tr>" >> "$HTMLFILE"
    echo "<th class='app_header' style='width:100%'><a href='rataktp1.html'><b><font size='4'>rataktp1</font></b></a></th>" >> "$HTMLFILE"
    echo "</tr></thead><tbody><tr><td class='epos'>" >> "$HTMLFILE"
    echo "<textarea style='background-color:white;font-weight:bold;width:100%;height:700px' wrap='off' disabled>" >> "$HTMLFILE"
    cat "$WORKDIR/files/log-prot.rataktp1_vm" >> "$HTMLFILE" 2>/dev/null
    echo "</textarea>" >> "$HTMLFILE"
    echo "</td></tr></tbody></table></div>" >> "$HTMLFILE"
    echo "</body></html>" >> "$HTMLFILE"
}

function Calculate_time_difference {
    function seconds2time {
        T=$1
        D=$((T/60/60/24))
        H=$((T/60/60%24))
        M=$((T/60%60))
        S=$((T%60))
        if [ "$D" -ne 0 ]; then
            printf '%d days %02d hours %02d minutes %02d seconds\n' "$D" "$H" "$M" "$S"
        else
            printf '%02d hours %02d minutes %02d seconds\n' "$H" "$M" "$S"
        fi
    }

    epoch1=$(/opt/informix/ifxmonitor/scripts/epoch_timer.pl "$st_sec" "$st_min" "$st_hr" "$st_dt" "$st_mnth_numeric" "$st_year_cut")
    epoch2=$(/opt/informix/ifxmonitor/scripts/epoch_timer.pl "$end_sec" "$end_min" "$end_hr" "$end_dt" "$end_mnth_numeric" "$end_year_cut")
    TOTAL_TIME=$((epoch2 - epoch1))
    exact_diff=$(seconds2time "$TOTAL_TIME")
    set_values "$1" Calculate_time_difference
}

function get_noc_timestamp {
    NOCtime=$(/opt/informix/ifxmonitor/scripts/get_NOC_timestamp.pl)
}

function checkFullBackups {
    i=act1
    INFORMIXSERVER=$INSTANCE
    DayMon=$(date | awk '{print substr($0,1,10)}')
    CHECK_WHAT_FLAG full_backup_flag "$INFORMIXSERVER"

    Begin_line_temp=$(head -1 "$WORKDIR/files/bar_$i.log.backup" 2>/dev/null)
    End_line_temp=$(tail -1 "$WORKDIR/files/bar_$i.log.backup" 2>/dev/null)
    count_temp=$(wc -l < "$WORKDIR/files/bar_$i.log.backup" 2>/dev/null)
    datum=$(date +%Y-%m-%d)
    count_err_temp=$(grep "$datum" "$INFORMIXDIR/tmp/bar_$i.log" 2>/dev/null | egrep -i 'failed|error|warning' | wc -l)

    if [ "$count_temp" -eq 2 ]; then
        st_sec=$(sed -e 's/ /#/g' -e 's/:/#/g' -e 's/-/#/g' -e 's/###/#/g' "$WORKDIR/files/bar_$i.log.backup" | grep Begin | awk -F'#' '{print $6}')
        st_min=$(sed -e 's/ /#/g' -e 's/:/#/g' -e 's/-/#/g' -e 's/###/#/g' "$WORKDIR/files/bar_$i.log.backup" | grep Begin | awk -F'#' '{print $5}')
        st_hr=$(sed -e 's/ /#/g' -e 's/:/#/g' -e 's/-/#/g' -e 's/###/#/g' "$WORKDIR/files/bar_$i.log.backup" | grep Begin | awk -F'#' '{print $4}')
        st_dt=$(sed -e 's/ /#/g' -e 's/:/#/g' -e 's/-/#/g' -e 's/###/#/g' "$WORKDIR/files/bar_$i.log.backup" | grep Begin | awk -F'#' '{print $3}')
        st_mnth_numeric=$(sed -e 's/ /#/g' -e 's/:/#/g' -e 's/-/#/g' -e 's/###/#/g' "$WORKDIR/files/bar_$i.log.backup" | grep Begin | awk -F'#' '{print $2}')
        st_year_cut=$(sed -e 's/ /#/g' -e 's/:/#/g' -e 's/-/#/g' -e 's/###/#/g' "$WORKDIR/files/bar_$i.log.backup" | grep Begin | awk -F'#' '{print $1}')
        end_sec=$(sed -e 's/ /#/g' -e 's/:/#/g' -e 's/-/#/g' -e 's/###/#/g' "$WORKDIR/files/bar_$i.log.backup" | grep End | awk -F'#' '{print $6}')
        end_min=$(sed -e 's/ /#/g' -e 's/:/#/g' -e 's/-/#/g' -e 's/###/#/g' "$WORKDIR/files/bar_$i.log.backup" | grep End | awk -F'#' '{print $5}')
        end_hr=$(sed -e 's/ /#/g' -e 's/:/#/g' -e 's/-/#/g' -e 's/###/#/g' "$WORKDIR/files/bar_$i.log.backup" | grep End | awk -F'#' '{print $4}')
        end_dt=$(sed -e 's/ /#/g' -e 's/:/#/g' -e 's/-/#/g' -e 's/###/#/g' "$WORKDIR/files/bar_$i.log.backup" | grep End | awk -F'#' '{print $3}')
        end_mnth_numeric=$(sed -e 's/ /#/g' -e 's/:/#/g' -e 's/-/#/g' -e 's/###/#/g' "$WORKDIR/files/bar_$i.log.backup" | grep End | awk -F'#' '{print $2}')
        end_year_cut=$(sed -e 's/ /#/g' -e 's/:/#/g' -e 's/-/#/g' -e 's/###/#/g' "$WORKDIR/files/bar_$i.log.backup" | grep End | awk -F'#' '{print $1}')

        echo 0 > "$WORKDIR/files/err_cnt/$INFORMIXSERVER/full_backup_mailsent_flag"
        if [ "$FLAG_STATUS" != "CLEARED" ]; then
            reset_flag_date
            echo "$flag_date#full_backup_flag#$INFORMIXSERVER#CLEARED" >> "$WORKDIR/files/flags.txt"
            ERR_MSG="CLEARED Full Backup not done for $INFORMIXSERVER."
            echo "$ERR_MSG"
            echo "$ERR_MSG" | /usr/bin/mailx -s 'CLEARED Full backup not done for Informix Instance.' "$mailid"
        fi
        Calculate_time_difference "$i"
    else
        abbrechen=$(date +%H%M)
        if [ "$abbrechen" -ge "$full_bkp_low_time" ] && [ "$abbrechen" -le "$full_bkp_high_time" ]; then
            date
            echo "Current time is within the configured full-backup window."
            set_values IFLOOP checkFullBackups
        else
            full_backup_mailsent_flag=$(cat "$WORKDIR/files/err_cnt/$INFORMIXSERVER/full_backup_mailsent_flag" 2>/dev/null)
            full_backup_mailsent_flag=${full_backup_mailsent_flag:-0}
            full_backup_mailsent_flag=$((full_backup_mailsent_flag + 1))
            echo "$full_backup_mailsent_flag" > "$WORKDIR/files/err_cnt/$INFORMIXSERVER/full_backup_mailsent_flag"

            if [ "$FLAG_STATUS" = "CLEARED" ] && [ "$full_backup_mailsent_flag" -eq 1 ]; then
                reset_flag_date
                echo "$flag_date#full_backup_flag#$INFORMIXSERVER#FIRSTMAILSENT" >> "$WORKDIR/files/flags.txt"
                ERR_MSG="Full Backup not done for $INFORMIXSERVER."
                echo "$ERR_MSG"
                echo "$ERR_MSG" | /usr/bin/mailx -s 'Full backup not done for Informix Instance.' "$mailid"
                if [ "$TTWOS_AKTIV" = "1" ]; then
                    get_noc_timestamp
                    MSG="Full Backup failed."
                    ssh adbm@adeoas01s "echo '$NOCtime;Major;$INFORMIXSERVER;$MSG' >> /home/adbm/prod/Informix/NOC_DATA/tramo_monitor.log" 2>/dev/null
                fi
            else
                echo "First mail is already sent for full backup not done for $INFORMIXSERVER"
            fi
        fi
    fi
    set_values "$i" checkFullBackups
}

function checkLogBackups {
    i=$INSTANCE
    INFORMIXSERVER=$i
    CHECK_DATE=$(cut -d';' -f1 "$WORKDIR/files/$i.logs.2")
    compare_timestamp "$DATUM_LAUF" "$CHECK_DATE"
    RC=$?

    if [ "$RC" -eq 0 ]; then
        wl_temp=$(cut -d';' -f2 "$WORKDIR/files/$i.logs.2")
        ol_temp=$(cut -d';' -f3 "$WORKDIR/files/$i.logs.2")
        cl_temp=$(cut -d';' -f4 "$WORKDIR/files/$i.logs.2")
        ol_temp_err_cnt_critical=$(cat "$WORKDIR/files/err_cnt/$i/ol_temp_err_cnt_critical")
        ol_temp_err_cnt_medium=$(cat "$WORKDIR/files/err_cnt/$i/ol_temp_err_cnt_medium")
        ol_temp_err_cnt=$(cat "$WORKDIR/files/err_cnt/$i/ol_temp_err_cnt")

        if [ "$ol_temp" -gt "$logical_log_not_backup_critical_threshould" ]; then
            ol_temp_err_cnt_critical=$((ol_temp_err_cnt_critical + 1))
            echo "$ol_temp_err_cnt_critical" > "$WORKDIR/files/err_cnt/$i/ol_temp_err_cnt_critical"
            CHECK_WHAT_FLAG ol_temp_flag_critical "$INFORMIXSERVER"
            if [ "$FLAG_STATUS" = "CLEARED" ] && [ "$ol_temp_err_cnt_critical" -eq "$Monitor_attempt_ol_temp_first" ]; then
                reset_flag_date
                echo "$flag_date#ol_temp_flag_critical#$INFORMIXSERVER#FIRSTMAILSENT" >> "$WORKDIR/files/flags.txt"
                ERR_MSG="Check the output of 'onstat -l' for $i instance. The logical logs are not getting backed up."
                echo "$ERR_MSG" | /usr/bin/mailx -s 'onstat -l Logical logs not backed up: Critical threshold breached' "$mailid"
                if [ "$TTWOS_AKTIV" = "1" ]; then
                    get_noc_timestamp
                    MSG="Logical Logs are not saved."
                    ssh adbm@adeoas01s "echo '$NOCtime;Major;$INFORMIXSERVER;$MSG' >> /home/adbm/prod/Informix/NOC_DATA/tramo_monitor.log" 2>/dev/null
                fi
            else
                echo "First mail already sent or critical threshold retry count not reached."
            fi
        elif [ "$ol_temp" -gt "$logical_log_not_backup_medium_threshould" ]; then
            ol_temp_err_cnt_medium=$((ol_temp_err_cnt_medium + 1))
            echo "$ol_temp_err_cnt_medium" > "$WORKDIR/files/err_cnt/$i/ol_temp_err_cnt_medium"
            CHECK_WHAT_FLAG ol_temp_flag_medium "$INFORMIXSERVER"
            if [ "$FLAG_STATUS" = "CLEARED" ] && [ "$ol_temp_err_cnt_medium" -eq "$Monitor_attempt_ol_temp_first" ]; then
                reset_flag_date
                echo "$flag_date#ol_temp_flag_medium#$INFORMIXSERVER#FIRSTMAILSENT" >> "$WORKDIR/files/flags.txt"
                ERR_MSG="Logical logs are not getting saved for $i. Medium threshold breached."
                echo "$ERR_MSG" | /usr/bin/mailx -s 'Logical logs not getting backed up.' "$mailid"
                if [ "$TTWOS_AKTIV" = "1" ]; then
                    get_noc_timestamp
                    MSG="Logical Logs are not saved."
                    ssh adbm@adeoas01s "echo '$NOCtime;Major;$INFORMIXSERVER;$MSG' >> /home/adbm/prod/Informix/NOC_DATA/tramo_monitor.log" 2>/dev/null
                fi
            else
                echo "First mail already sent or medium threshold retry count not reached."
            fi
        elif [ "$ol_temp" -gt "$logical_log_not_backup_lower_threshould" ]; then
            ol_temp_err_cnt=$((ol_temp_err_cnt + 1))
            echo "$ol_temp_err_cnt" > "$WORKDIR/files/err_cnt/$INFORMIXSERVER/ol_temp_err_cnt"
            CHECK_WHAT_FLAG ol_temp_flag "$INFORMIXSERVER"
            if [ "$FLAG_STATUS" = "CLEARED" ] && [ "$ol_temp_err_cnt" -eq "$Monitor_attempt_ol_temp_third" ]; then
                reset_flag_date
                echo "$flag_date#ol_temp_flag#$INFORMIXSERVER#FIRSTMAILSENT" >> "$WORKDIR/files/flags.txt"
                ERR_MSG="Check the output of 'onstat -l' for $i instance. The logical logs are not getting backed up."
                echo "$ERR_MSG" | /usr/bin/mailx -s 'onstat -l Logical logs not backed up: Minor threshold breached' "$mailid"
                if [ "$TTWOS_AKTIV" = "1" ]; then
                    get_noc_timestamp
                    MSG="Logical Logs are not saved."
                    ssh adbm@adeoas01s "echo '$NOCtime;Minor;$INFORMIXSERVER;$MSG' >> /home/adbm/prod/Informix/NOC_DATA/tramo_monitor.log" 2>/dev/null
                fi
            else
                echo "First mail already sent or minor threshold retry count not reached."
            fi
        else
            echo "Logs not saved are below the lower threshold."
            for flag_name in ol_temp_flag_critical ol_temp_flag_medium ol_temp_flag; do
                CHECK_WHAT_FLAG "$flag_name" "$INFORMIXSERVER"
                if [ "$FLAG_STATUS" != "CLEARED" ]; then
                    reset_flag_date
                    echo "$flag_date#$flag_name#$INFORMIXSERVER#CLEARED" >> "$WORKDIR/files/flags.txt"
                    ERR_MSG="CLEARED Logical log backup is normal for $i."
                    echo "$ERR_MSG" | /usr/bin/mailx -s 'CLEARED Logical log backup normal now.' "$mailid"
                fi
            done
            echo 0 > "$WORKDIR/files/err_cnt/$i/ol_temp_err_cnt_critical"
            echo 0 > "$WORKDIR/files/err_cnt/$i/ol_temp_err_cnt_medium"
            echo 0 > "$WORKDIR/files/err_cnt/$i/ol_temp_err_cnt"
        fi
    else
        echo "Time difference is more than 2 min for $i logs file."
        wl_temp="?"; ol_temp="?"; cl_temp="?"
    fi
    set_values "$i" checkLogBackups
}

function set_values {
    if [ "$1" = "$INSTANCE" ] && [ "$2" = "checkLogBackups" ]; then
        wl_rataktp1=$wl_temp
        ol_rataktp1=$ol_temp
        cl_rataktp1=$cl_temp
    fi
    if [ "$1" = "$INSTANCE" ] && [ "$2" = "check_oninit_procs" ]; then
        oi_rataktp1=$oi_temp
    fi
    if [ "$1" = "act1" ] && [ "$2" = "checkFullBackups" ]; then
        Begin_line_act1=$Begin_line_temp
        End_line_act1=$End_line_temp
        count_act1=$count_temp
        count_err_act1=$count_err_temp
    fi
    if [ "$1" = "IFLOOP" ] && [ "$2" = "checkFullBackups" ]; then
        Begin_line_act1="?"
        End_line_act1="?"
        count_act1="?"
        count_err_act1="?"
        exact_diff_act1="?"
    fi
    if [ "$1" = "act1" ] && [ "$2" = "Calculate_time_difference" ]; then
        exact_diff_act1=$exact_diff
    fi
}

function CHECK_WHAT_FLAG {
    INFORMIXSERVER=$2
    FLAG_STATUS=$(grep "$1" "$WORKDIR/files/flags.txt" 2>/dev/null | grep "$INFORMIXSERVER" | tail -1 | awk -F'#' '{print $5}')
}

function reset_flag_date {
    flag_date=$(date +"%Y-%m-%d#%H:%M:%S")
}

function check_oninit_procs {
    i=$INSTANCE
    INFORMIXSERVER=$i
    CHECK_DATE=$(cut -d';' -f1 "$WORKDIR/files/$i.procs")
    compare_timestamp "$DATUM_LAUF" "$CHECK_DATE"
    RC=$?

    if [ "$RC" -eq 0 ]; then
        oi_temp=$(cut -d';' -f2 "$WORKDIR/files/$i.procs")
        CHECK_WHAT_FLAG oi_temp_flag "$INFORMIXSERVER"
        oi_temp_err_cnt=$(cat "$WORKDIR/files/err_cnt/$i/oi_temp_err_cnt")

        if [ "$oi_temp" -lt 13 ]; then
            oi_temp_err_cnt=$((oi_temp_err_cnt + 1))
            echo "$oi_temp_err_cnt" > "$WORKDIR/files/err_cnt/$INFORMIXSERVER/oi_temp_err_cnt"
            if [ "$FLAG_STATUS" = "CLEARED" ] && [ "$oi_temp_err_cnt" -eq "$Monitor_attempt_oi_temp" ]; then
                reset_flag_date
                echo "$flag_date#oi_temp_flag#$INFORMIXSERVER#FIRSTMAILSENT" >> "$WORKDIR/files/flags.txt"
                ERR_MSG="Check 'onstat -g glo' for $i. The oninit process count is below 13."
                echo "$ERR_MSG" | /usr/bin/mailx -s 'Oninit process count below threshold: Critical' "$mailid"
                if [ "$TTWOS_AKTIV" = "1" ]; then
                    get_noc_timestamp
                    MSG="DB-Server is down."
                    ssh adbm@adeoas01s "echo '$NOCtime;Major;$INFORMIXSERVER;$MSG' >> /home/adbm/prod/Informix/NOC_DATA/tramo_monitor.log" 2>/dev/null
                fi
            else
                echo "Oninit alert mail already sent or retry count not reached."
            fi
        else
            if [ "$FLAG_STATUS" != "CLEARED" ]; then
                reset_flag_date
                echo "$flag_date#oi_temp_flag#$INFORMIXSERVER#CLEARED" >> "$WORKDIR/files/flags.txt"
                ERR_MSG="CLEARED Oninit process count is normal for $i."
                echo "$ERR_MSG" | /usr/bin/mailx -s 'CLEARED Oninit process count normal now.' "$mailid"
            fi
            echo 0 > "$WORKDIR/files/err_cnt/$i/oi_temp_err_cnt"
        fi
    else
        echo "Time difference is more than 2 min for $i procs file."
        oi_temp="?"
    fi
    set_values "$i" check_oninit_procs
}

function compare_timestamp {
    local ts1="$1"
    local ts2="$2"
    local epoch1 epoch2 diff
    epoch1=$(date -d "$ts1" +%s 2>/dev/null) || return 1
    epoch2=$(date -d "$ts2" +%s 2>/dev/null) || return 1
    diff=$((epoch1 - epoch2))
    [ "$diff" -lt 0 ] && diff=$((0 - diff))
    [ "$diff" -le 120 ]
}

RUNNING_SINCE_DATE=$(date +"%d.%m.%y  %H:%M:%S")

while true
do
    WORKDIR=/opt/informix/ifxmonitor
    echo "0" > "$WORKDIR/files/managment_report_flag"

    ClearVar
    cd "$WORKDIR/scripts/" || exit 1

    # Existing collection scripts are retained. If these scripts collect all
    # instances, their generated files for the other instances are simply ignored.
    "$WORKDIR/scripts/db_fullbackup.sh"
    "$WORKDIR/scripts/db_logs_logical_backup.sh"
    "$WORKDIR/scripts/db_oninits_new.sh"
    "$WORKDIR/scripts/db_logs_info.sh"

    echo "===Script generate_html_per_instance.sh Started ....==="
    date
    "$WORKDIR/scripts/generate_html_per_instance.sh"
    date
    echo "===Script generate_html_per_instance.sh End....==="

    . /opt/informix/ifxmonitor/scripts/config_ifxmonitor.sh

    if [ "$DO_YOU_WANT_TO_EXIT" = "Y" ]; then
        echo "You opted to exit the script execution."
        exit 0
    fi

    DATUM_LAUF=$(date +"%Y-%m-%d  %H:%M:%S")
    startsec=$($WORKDIR/scripts/getsec.perl)

    if [ "$DEBUG" = "Y" ]; then
        echo "Starting !" > "$DEBUGLOG"
        date >> "$DEBUGLOG"
    fi

    checkLogBackups
    if [ "$DEBUG" = "Y" ]; then echo "checkLogBackups finished" >> "$DEBUGLOG"; date >> "$DEBUGLOG"; fi

    checkFullBackups
    if [ "$DEBUG" = "Y" ]; then echo "checkFullBackups finished" >> "$DEBUGLOG"; date >> "$DEBUGLOG"; fi

    check_oninit_procs
    if [ "$DEBUG" = "Y" ]; then echo "check_oninit_procs finished" >> "$DEBUGLOG"; date >> "$DEBUGLOG"; fi

    write_html
    if [ "$DEBUG" = "Y" ]; then echo "write_html finished" >> "$DEBUGLOG"; date >> "$DEBUGLOG"; fi

    endsec=$($WORKDIR/scripts/getsec.perl)

    scp "$HTMLFILE" adbm@adeoas01s:/home/adbm/prod/webdata/htdocs/informix/webportal

    abbrechen=$(date +%H%M)
    if [ "$abbrechen" -gt "$Stop_executing_time" ]; then
        date
        echo "Time to say goodbye..."
        exit 0
    fi

    # Releases managment_report_rataktp1_vm.sh after this monitoring cycle.
    echo "1" > "$WORKDIR/files/managment_report_flag"

    LOOPTIME=$((120 - (endsec - startsec)))
    if [ "$LOOPTIME" -lt 1 ]; then LOOPTIME=1; fi
    sleep "$LOOPTIME"
done
