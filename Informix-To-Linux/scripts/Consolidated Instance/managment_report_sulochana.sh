#./managment_report_sulochana.sh

#!/bin/bash
#===================================================================================
#
# FILE        : managment_report_rataktp1_vm.sh
# USAGE       : sh managment_report_rataktp1_vm.sh
# DESCRIPTION : This script monitors and sends management report for rataktp1_vm only.
#
# OPTIONS     :  ---
# REQUIREMENTS:  ---
# NOTES       : Consolidated from original multi-instance script.
#               Only rataktp1_vm is monitored.
# AUTHOR      : Sulochana Vemula
# COMPANY     : Vodafone Shared Services India
# VERSION     : 2.0
# CREATED     : 04.08.2026
# REVISION    : rataktp1_vm only consolidation
#
#====================================================================================

#. /home/adbm/.profile 1>/dev/null

WORKDIR=/opt/informix/ifxmonitor

# Logical log threshold
logical_log_not_backup_critical_threshould=60
logical_log_not_backup_medium_threshould=35
logical_log_not_backup_lower_threshould=10

INSTANCE="rataktp1_vm"

space_code=""
space_per=""

Full_bkp_rataktp1=""
Full_bkp_rataktp11=""

rataktp1_status=""
rataktp1_status_tex=""

ll_code_rataktp1=""
ll_code_rataktp11=""

log_code_rataktp1=""
log_code_rataktp11=""

rollbk_rataktp1=""
rollbk_rataktp11=""

ov_buff_rataktp1=""
ov_buff_rataktp11=""

ov_lock_rataktp1=""
ov_lock_rataktp11=""

dbspace_percent_rataktp1=""
dbspace_percent_rataktp11=""

function set_color()
{

if [ "$1" -gt 0 ];
then
        echo "<td style='width: 320px;background-color: #68ff03;'>&nbsp;</td>" >> $html
else
        echo "<td style='width: 320px;background-color: #f55d5d;'>&nbsp;</td>" >> $html
fi

}

function generate_html()
{

>/opt/informix/ifxmonitor/files/mgm_report.html
html=/opt/informix/ifxmonitor/files/mgm_report.html


echo "<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.01 Transitional//EN' 'http://www.w3.org/TR/html4/loose.dtd'>" >> $html
echo "<html>" >> $html
echo "<head>" >> $html
echo "<body>" >> $html
echo "<p>Hi All,<br>" >> $html
echo "Please find Informix Database status report.</p>" >> $html


echo "<table style='height: 439px; width: 534px; border-radius: 25px;' border='2'>" >> $html
echo "<tbody>" >> $html


echo "<tr>" >> $html
echo "<td style='width: 522px; border-radius: 25px;text-align: center;font-size:18px;background-color:#47d2fc;' colspan='2'><b>Informix Monitoring Report</b></td>" >> $html
echo "</tr>" >> $html

echo "<tr>" >> $html
echo "<td style='width: 119.333px; text-align: center;font-size:15px;background-color:#c7f2ff;' colspan='2'><b>Critical Parameters.</b></td>" >> $html
echo "</tr>" >> $html


echo "<tr>" >> $html
echo "<td style='width: 182px;background-color:#c7f2ff;'>&nbsp;</td>" >> $html
echo "<td style='width: 320px; text-align: center;background-color:#c7f2ff;'>rataktp1_vm</td>" >> $html
echo "</tr>" >> $html


echo "<tr>" >> $html
echo "<td style='width: 182px; text-align: center;background-color:#c7f2ff;'>Instance Status</td>" >> $html
echo "<td style='width: 320px;background-color: $rataktp1_status;text-align: center;'>$rataktp1_status_tex</td>" >> $html
echo "</tr>" >> $html


echo "<tr>" >> $html
echo "<td style='width: 182px; text-align: center;background-color:#c7f2ff;'>Full Backup Status</td>" >> $html
echo "<td style='width: 320px;background-color: $Full_bkp_rataktp1;text-align: center;'>$Full_bkp_rataktp11</td>" >> $html
echo "</tr>" >> $html


echo "<tr>" >> $html
echo "<td style='width: 182px; text-align: center;background-color:#c7f2ff;'>Logical backup</td>" >> $html
echo "<td style='width: 320px;background-color: $ll_code_rataktp1;text-align: center;'>$ll_code_rataktp11</td>" >> $html
echo "</tr>" >> $html


echo "<tr>" >> $html
echo "<td style='width: 182px; text-align: center;background-color:#c7f2ff;'>/opt/informix space full.</td>" >> $html
echo "<td style='width: 320px; background-color: $space_code;text-align: center;'>$space_per</td>" >> $html
echo "</tr>" >> $html

echo "</tbody>" >> $html
echo "</table>" >> $html

echo "<br>" >> $html

echo "<table style='height: 439px; width: 534px; border-radius: 25px;' border='2'>" >> $html
echo "<tbody>" >> $html


echo "<tr>" >> $html
echo "<td style='width: 119.333px; text-align: center;font-size:15px;background-color:#c7f2ff;' colspan='2'><b>Non Critical Parameters.</b></td>" >> $html
echo "</tr>" >> $html


echo "<tr>" >> $html
echo "<td style='width: 182px; text-align: center;background-color:#c7f2ff;'>Online Log Error</td>" >> $html
echo "<td style='width: 320px;background-color: $log_code_rataktp1;text-align: center;'>$log_code_rataktp11</td>" >> $html
echo "</tr>" >> $html


echo "<tr>" >> $html
echo "<td style='width: 182px; text-align: center;background-color:#c7f2ff;'>rollback count</td>" >> $html
echo "<td style='width: 320px;background-color: $rollbk_rataktp1;text-align: center;'>$rollbk_rataktp11</td>" >> $html
echo "</tr>" >> $html


echo "<tr>" >> $html
echo "<td style='width: 182px; text-align: center;background-color:#c7f2ff;'>ovbuff count</td>" >> $html
echo "<td style='width: 320px;background-color: $ov_buff_rataktp1;text-align: center;'>$ov_buff_rataktp11</td>" >> $html
echo "</tr>" >> $html


echo "<tr>" >> $html
echo "<td style='width: 182px; text-align: center;background-color:#c7f2ff;'>onlock count</td>" >> $html
echo "<td style='width: 320px;background-color: $ov_lock_rataktp1;text-align: center;'>$ov_lock_rataktp11</td>" >> $html
echo "</tr>" >> $html


echo "<tr>" >> $html
echo "<td style='width: 182px; text-align: center;background-color:#c7f2ff;'>DBSpace Utilization (% free)</td>" >> $html
echo "<td style='width: 320px;background-color: $dbspace_percent_rataktp11;text-align: center;'>$dbspace_percent_rataktp1</td>" >> $html
echo "</tr>" >> $html


echo "<tr>" >> $html
echo "<td style='width: 182px; border-radius: 25px;background-color:#c7f2ff;' colspan='2'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>" >> $html
echo "</tr>" >> $html

echo "</tbody>" >> $html
echo "</table>" >> $html

echo "<br>" >> $html

echo "<table style='height: 46px; width: 333px;border-radius: 15px;' border='1'>" >> $html
echo "<tbody>" >> $html

echo "<tr>" >> $html
echo "<td style='width: 75px; background-color: #68ff03;'>&nbsp;</td>" >> $html
echo "<td style='width: 206px;text-align: center;background-color:#c7f2ff;'>within threshold.</td>" >> $html
echo "</tr>" >> $html

echo "<tr>" >> $html
echo "<td style='width: 75px; background-color: #f55d5d;'>&nbsp;</td>" >> $html
echo "<td style='width: 206px;text-align: center;background-color:#c7f2ff;'>critical threshold breached</td>" >> $html
echo "</tr>" >> $html

echo "<tr>" >> $html
echo "<td style='width: 75px; background-color: orange;'>&nbsp;</td>" >> $html
echo "<td style='width: 206px;text-align: center;background-color:#c7f2ff;'>major threshold breached</td>" >> $html
echo "</tr>" >> $html

echo "<tr>" >> $html
echo "<td style='width: 75px; background-color: yellow;'>&nbsp;</td>" >> $html
echo "<td style='width: 206px;text-align: center;background-color:#c7f2ff;'>minor threshold breached</td>" >> $html
echo "</tr>" >> $html

echo "</tbody>" >> $html
echo "</table>" >> $html

echo "<p>Regards,<br>" >> $html
echo "TIDE Team.</p>" >> $html


echo "</body>" >> $html
echo "</html>" >> $html


# Send HTML mail report. This section is kept same as main script.
cat <<'EOF' - $html | /usr/sbin/sendmail -f "adetrmdb2.de-monitoring@dc-ratingen.de" -t
To:sulochana.vemula@vodafone.com
#To:dl-tssc-adba-central-alert@vodafone.com
Subject: ALERT-DE-INFORMIX-Database-Status-Report.
Content-Type: text/html

EOF

}


function execute_report()
{

rataktp1_count=`cat $WORKDIR/files/err_cnt/rataktp1_vm/oi_temp_err_cnt`

echo "Value of instance status rataktp1_count $rataktp1_count"

if [ $rataktp1_count -eq 0 ]
then
        rataktp1_status="#68ff03"
        rataktp1_status_tex="Up"
else
        rataktp1_status="#f55d5d"
        rataktp1_status_tex="Down"
fi


# act1 backup file mapped to rataktp1_vm as per original script
Full_bkp_rataktp1_count=`cat $WORKDIR/files/bar_act1.log.backup | wc -l`

if [ $Full_bkp_rataktp1_count -ge 2 ]
then
        Full_bkp_rataktp1="#68ff03"
        Full_bkp_rataktp11="Done"
else
        Full_bkp_rataktp1="#f55d5d"
        Full_bkp_rataktp11="Not Done"
fi


# Logical log backup check for rataktp1_vm only
i=rataktp1_vm
ol_temp=`cat $WORKDIR/files/$i.logs.2 | cut -d ';' -f 3`

if [ $ol_temp -gt $logical_log_not_backup_critical_threshould ]
then
        ll_code_rataktp1="#f55d5d"
elif [ $ol_temp -gt $logical_log_not_backup_medium_threshould ]
then
        ll_code_rataktp1="orange"
elif [ $ol_temp -gt $logical_log_not_backup_lower_threshould ]
then
        ll_code_rataktp1="yellow"
else
        ll_code_rataktp1="#68ff03"
fi

if [ $ll_code_rataktp1 = "#68ff03" ]
then
        ll_code_rataktp11="Done"
else
        ll_code_rataktp11="Not Done"
fi


echo "$i Logical log is $ll_code_rataktp1"


space_per=`df -h /opt/informix | tail -1 | awk '{print $5}'`
space=`echo "${space_per//%}"`

if [ $space -gt 80 ]
then
        space_code="#f55d5d"
elif [ $space -gt 70 ]
then
        space_code="orange"
elif [ $space -gt 60 ]
then
        space_code="yellow"
else
        space_code="#68ff03"
fi

echo "space is $space_code"


datum=`date +%m/%d/%y`

log_error_cnt_rataktp1=`cat /opt/informix/IDS/14.10.12/tmp/online.log.rataktp1_vm | grep $datum | grep -i error | wc -l`

if [ $log_error_cnt_rataktp1 -gt 0 ]
then
        log_code_rataktp1="orange"
        log_code_rataktp11="Error found"
else
        log_code_rataktp1="#68ff03"
        log_code_rataktp11="No Error"
fi


echo "Log error log_error_cnt_rataktp1 is  $log_error_cnt_rataktp1"


ov_lock_rataktp11=`cat $WORKDIR/files/onstat.p.rataktp1_vm | tail -8 | head -1 | awk '{print $1}'`

if [ $ov_lock_rataktp11 -gt 0 ]
then
        ov_lock_rataktp1="yellow"
else
        ov_lock_rataktp1="#68ff03"
fi


ov_buff_rataktp11=`cat $WORKDIR/files/onstat.p.rataktp1_vm | tail -8 | head -1 | awk '{print $3}'`

if [ $ov_buff_rataktp11 -gt 0 ]
then
        ov_buff_rataktp1="yellow"
else
        ov_buff_rataktp1="#68ff03"
fi


rollbk_rataktp11=`cat $WORKDIR/files/onstat.p.rataktp1_vm | head -10 | tail -1 | awk '{print $9}'`

if [ $rollbk_rataktp11 -gt 0 ]
then
        rollbk_rataktp1="yellow"
else
        rollbk_rataktp1="#68ff03"
fi


dbspace_percent_rataktp1=`cat $WORKDIR/files/onstat.d.rataktp1_vm | tail -10 | egrep 'data|root' | awk '{print $5}' | sort -rn | tail -1 | awk -F"." '{print $1}'`

if [ $dbspace_percent_rataktp1 -le 10 ]
then
        dbspace_percent_rataktp11="#f55d5d"
elif [ $dbspace_percent_rataktp1 -le 20 ]
then
        dbspace_percent_rataktp11="orange"
elif [ $dbspace_percent_rataktp1 -le 30 ]
then
        dbspace_percent_rataktp11="yellow"
else
        dbspace_percent_rataktp11="#68ff03"
fi


generate_html

}


#while true
#do
#        flag_p=`cat $WORKDIR/files/managment_report_flag`
#        if [ $flag_p -eq 1 ]
#        then
                execute_report
                exit 0
#        else
#                echo "Parent Script is still executing"
#                sleep 3
#        fi

#done
