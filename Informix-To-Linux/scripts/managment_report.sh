cat /opt/informix/ifxmonitor/scripts/managment_report.sh
#!/bin/bash
#===================================================================================
#
# FILE        : managment_report.sh
# USAGE       : sh managment_report.sh
# DESCRIPTION : This script monitors and send report to managment.
#
# OPTIONS     :  ---
# REQUIREMENTS:  ---
# NOTES       :
# AUTHOR      : Sagar Linge
# COMPANY     : Vodafone Sha#f55d5d Services India
# VERSION     : 1.0
# CREATED     : 11.03.2020
# REVISION    : 11.03.2020
#
#====================================================================================

#. /home/adbm/.profile 1>/dev/null

WORKDIR=/opt/informix/ifxmonitor
#Logical log threshold
logical_log_not_backup_critical_threshould=60
logical_log_not_backup_medium_threshould=35
logical_log_not_backup_lower_threshould=10
space_code=""

Full_bkp_rataktp1=""
Full_bkp_rataktp2=""
Full_bkp_rataktp4=""
Full_bkp_ratcalp2=""

rataktp1_status=""
rataktp2_status=""
rataktp4_status=""
ratcalp2_status=""

rataktp1_status_tex=""
rataktp2_status_tex=""
rataktp4_status_tex=""
ratcalp2_status_tex=""


ll_code_rataktp1=""
ll_code_rataktp2=""
ll_code_rataktp4=""
ll_code_ratcalp2=""

ll_code_rataktp11=""
ll_code_rataktp21=""
ll_code_rataktp41=""
ll_code_ratcalp21=""

log_code_rataktp1=""
log_code_rataktp2=""
log_code_rataktp4=""
log_code_ratcalp2=""



function set_color()
{

if [ $1 -gt 0 ];
then
        echo "<td style='width: 80.6667px;background-color: #68ff03;'>&nbsp;</td>" >> $html
else
        echo "<td style='width: 80.6667px;background-color: #f55d5d;'>&nbsp;</td>" >> $html
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
echo "<td style='width: 522px; border-radius: 25px;text-align: center;font-size:18px;background-color:#47d2fc;' colspan='5'><b>Informix Monitoring Report</b></td>" >> $html
echo "</tr>" >> $html

echo "<tr>" >> $html
echo "<td style='width: 119.333px; text-align: center;font-size:15px;background-color:#c7f2ff;' colspan='5'><b>Critical Parameters.</b></td>" >> $html
echo "</tr>" >> $html


echo "<tr>" >> $html
echo "<td style='width: 182px;background-color:#c7f2ff;'>&nbsp;</td>" >> $html
echo "<td style='width: 80.6667px; text-align: center;background-color:#c7f2ff;'>rataktp1_vm</td>" >> $html
echo "<td style='width: 80.6667px; text-align: center;background-color:#c7f2ff;'>rataktp2_vm</td>" >> $html
echo "<td style='width: 80.6667px; text-align: center;background-color:#c7f2ff;'>rataktp4_vm</td>" >> $html
echo "<td style='width: 80.6667px; text-align: center;background-color:#c7f2ff;'>ratcalp2_vm</td>" >> $html
echo "</tr>" >> $html


echo "<tr>" >> $html
echo "<td style='width: 182px; text-align: center;background-color:#c7f2ff;'>Instance Status</td>" >> $html



echo "<td style='width: 80.6667px;background-color: $rataktp1_status;text-align: center;'>$rataktp1_status_tex</td>" >> $html
echo "<td style='width: 80.6667px;background-color: $rataktp2_status;text-align: center;'>$rataktp2_status_tex</td>" >> $html
echo "<td style='width: 80.6667px;background-color: $rataktp4_status;text-align: center;'>$rataktp4_status_tex</td>" >> $html
echo "<td style='width: 80.6667px;background-color: $ratcalp2_status;text-align: center;'>$ratcalp2_status_tex</td>" >> $html


echo "</tr>" >> $html



echo "<tr>" >> $html
echo "<td style='width: 182px; text-align: center;background-color:#c7f2ff;'>Full Backup Status</td>" >> $html
echo "<td style='width: 80.6667px;background-color: $Full_bkp_rataktp1;text-align: center;'>$Full_bkp_rataktp11</td>" >> $html
echo "<td style='width: 89.3333px;background-color: $Full_bkp_rataktp2;text-align: center;'>$Full_bkp_rataktp21</td>" >> $html
echo "<td style='width: 72px;background-color:      $Full_bkp_rataktp4;text-align: center;'>$Full_bkp_rataktp41</td>" >> $html
echo "<td style='width: 74px;background-color:      $Full_bkp_ratcalp2;text-align: center;'>$Full_bkp_ratcalp21</td>" >> $html
echo "</tr>" >> $html


echo "<tr>" >> $html
echo "<td style='width: 182px; text-align: center;background-color:#c7f2ff;'>Logical backup</td>" >> $html
echo "<td style='width: 80.6667px;background-color: $ll_code_rataktp1;text-align: center;'>$ll_code_rataktp11</td>" >> $html
echo "<td style='width: 89.3333px;background-color: $ll_code_rataktp2;text-align: center;'>$ll_code_rataktp21</td>" >> $html
echo "<td style='width: 72px;background-color:      $ll_code_rataktp4;text-align: center;'>$ll_code_rataktp41</td>" >> $html
echo "<td style='width: 74px;background-color:      $ll_code_ratcalp2;text-align: center;'>$ll_code_ratcalp21</td>" >> $html
echo "</tr>" >> $html


echo "<tr>" >> $html
echo "<td style='width: 182px; text-align: center;background-color:#c7f2ff;'>/opt/informix space full.</td>" >> $html
echo "<td style='width: 80.6667px; background-color: $space_code;text-align: center;' colspan='4'>$space_per</td>" >> $html
echo "</tr>" >> $html

echo "</tbody>" >> $html
echo "</table>" >> $html

echo "<br>" >> $html

echo "<table style='height: 439px; width: 534px; border-radius: 25px;' border='2'>" >> $html
echo "<tbody>" >> $html


echo "<tr>" >> $html
echo "<td style='width: 119.333px; text-align: center;font-size:15px;background-color:#c7f2ff;' colspan='5'><b>Non Critical Parameters.</b></td>" >> $html
echo "</tr>" >> $html

echo "<tr>" >> $html
echo "<td style='width: 182px; text-align: center;background-color:#c7f2ff;'>Online Log Error</td>" >> $html
echo "<td style='width: 80.6667px;background-color: $log_code_rataktp1;text-align: center;'>$log_code_rataktp11</td>" >> $html
echo "<td style='width: 89.3333px;background-color: $log_code_rataktp2;text-align: center;'>$log_code_rataktp21</td>" >> $html
echo "<td style='width: 72px;background-color:      $log_code_rataktp4;text-align: center;'>$log_code_rataktp41</td>" >> $html
echo "<td style='width: 74px;background-color:      $log_code_ratcalp2;text-align: center;'>$log_code_ratcalp21</td>" >> $html
echo "</tr>" >> $html


echo "<tr>" >> $html
echo "<td style='width: 182px; text-align: center;background-color:#c7f2ff;'>rollback count</td>" >> $html
echo "<td style='width: 80.6667px;background-color: $rollbk_rataktp1;text-align: center;'>$rollbk_rataktp11</td>" >> $html
echo "<td style='width: 89.3333px;background-color: $rollbk_rataktp2;text-align: center;'>$rollbk_rataktp21</td>" >> $html
echo "<td style='width: 72px;background-color:      $rollbk_rataktp4;text-align: center;'>$rollbk_rataktp41</td>" >> $html
echo "<td style='width: 74px;background-color:      $rollbk_ratcalp2;text-align: center;'>$rollbk_ratcalp21</td>" >> $html
echo "</tr>" >> $html


echo "<tr>" >> $html
echo "<td style='width: 182px; text-align: center;background-color:#c7f2ff;'>ovbuff count</td>" >> $html
echo "<td style='width: 80.6667px;background-color: $ov_buff_rataktp1;text-align: center;'>$ov_buff_rataktp11</td>" >> $html
echo "<td style='width: 89.3333px;background-color: $ov_buff_rataktp2;text-align: center;'>$ov_buff_rataktp21</td>" >> $html
echo "<td style='width: 72px;background-color:      $ov_buff_rataktp4;text-align: center;'>$ov_buff_rataktp41</td>" >> $html
echo "<td style='width: 74px;background-color:      $ov_buff_ratcalp2;text-align: center;'>$ov_buff_ratcalp21</td>" >> $html
echo "</tr>" >> $html


echo "<tr>" >> $html
echo "<td style='width: 182px; text-align: center;background-color:#c7f2ff;'>onlock count</td>" >> $html
echo "<td style='width: 80.6667px;background-color: $ov_lock_rataktp1;text-align: center;'>$ov_lock_rataktp11</td>" >> $html
echo "<td style='width: 89.3333px;background-color: $ov_lock_rataktp2;text-align: center;'>$ov_lock_rataktp21</td>" >> $html
echo "<td style='width: 72px;background-color:      $ov_lock_rataktp4;text-align: center;'>$ov_lock_rataktp41</td>" >> $html
echo "<td style='width: 74px;background-color:      $ov_lock_ratcalp2;text-align: center;'>$ov_lock_ratcalp21</td>" >> $html
echo "</tr>" >> $html


echo "<tr>" >> $html
echo "<td style='width: 182px; text-align: center;background-color:#c7f2ff;'>DBSpace Utilization (% free)</td>" >> $html
echo "<td style='width: 80.6667px;background-color: $dbspace_percent_rataktp11;text-align: center;'>$dbspace_percent_rataktp1</td>" >> $html
echo "<td style='width: 89.3333px;background-color: $dbspace_percent_rataktp21;text-align: center;'>$dbspace_percent_rataktp2</td>" >> $html
echo "<td style='width: 72px;background-color:      $dbspace_percent_rataktp41;text-align: center;'>$dbspace_percent_rataktp4</td>" >> $html
echo "<td style='width: 74px;background-color:      $dbspace_percent_ratcalp21;text-align: center;'>$dbspace_percent_ratcalp2</td>" >> $html
echo "</tr>" >> $html


echo "<tr>" >> $html
echo "<td style='width: 182px; border-radius: 25px;background-color:#c7f2ff;' colspan='5'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>" >> $html
echo "</tr>" >> $html
echo "</tbody>" >> $html
echo "</table>" >> $html

echo "<br>" >> $html

echo "<table style='height: 46px; width: 333px;border-radius: 15px;' border='1''>" >> $html
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




#cat <<'EOF' - $html | /usr/sbin/sendmail -t
#From:Informix-tramo-vm1@vodafone.com
#To:sagar.linge@Vodafone.com
#To:TISF-ePos-Support-ZV.de@vodafone.com,DL-TSSC-OSLO-ADBA@vodafone.com
#To:DL-TSSC-OSLO-ADBA@vodafone.com
#Subject: Informix Database Status Report.
#Content-Type: text/html



cat <<'EOF' - $html | /usr/sbin/sendmail -f "adetrmdb1.de-monitoring@dc-ratingen.de" -t
To:juergen.grosch@vodafone.com
To:dl-tssc-adba-central-alert@vodafone.com
Subject: ALERT-DE-INFORMIX-Database-Status-Report.
Content-Type: text/html


EOF


}

#Stop_executing_time=2245
#while true
#do


function execute_report()
{

rataktp1_count=`cat $WORKDIR/files/err_cnt/rataktp1_vm/oi_temp_err_cnt`
rataktp2_count=`cat $WORKDIR/files/err_cnt/rataktp2_vm/oi_temp_err_cnt`
rataktp4_count=`cat $WORKDIR/files/err_cnt/rataktp4_vm/oi_temp_err_cnt`
ratcalp2_count=`cat $WORKDIR/files/err_cnt/ratcalp2_vm/oi_temp_err_cnt`

echo "Value of instance status rataktp1_count $rataktp1_count"
echo "Value of instance status rataktp2_count $rataktp2_count"
echo "Value of instance status rataktp4_count $rataktp4_count"
echo "Value of instance status ratcalp2_count $ratcalp2_count"

if [ $rataktp1_count -eq 0 ];then rataktp1_status="#68ff03";rataktp1_status_tex="Up"; else echo rataktp1_status="#f55d5d";rataktp1_status_tex="Down"; fi
if [ $rataktp2_count -eq 0 ];then rataktp2_status="#68ff03";rataktp2_status_tex="Up"; else echo rataktp2_status="#f55d5d";rataktp2_status_tex="Down"; fi
if [ $rataktp4_count -eq 0 ];then rataktp4_status="#68ff03";rataktp4_status_tex="Up"; else echo rataktp4_status="#f55d5d";rataktp4_status_tex="Down"; fi
if [ $ratcalp2_count -eq 0 ];then ratcalp2_status="#68ff03";ratcalp2_status_tex="Up"; else echo ratcalp2_status="#f55d5d";ratcalp2_status_tex="Down"; fi


#act1 act2 act4 cal2
Full_bkp_rataktp1_count=`cat $WORKDIR/files/bar_act1.log.backup | wc -l`
Full_bkp_rataktp2_count=`cat $WORKDIR/files/bar_act2.log.backup | wc -l`
Full_bkp_rataktp4_count=`cat $WORKDIR/files/bar_act4.log.backup | wc -l`
Full_bkp_ratcalp2_count=`cat $WORKDIR/files/bar_cal2.log.backup | wc -l`

if [ $Full_bkp_rataktp1_count -ge 2 ]; then Full_bkp_rataktp1="#68ff03";Full_bkp_rataktp11="Done";  else Full_bkp_rataktp1="#f55d5d";Full_bkp_rataktp11="Not Done";  fi
if [ $Full_bkp_rataktp2_count -ge 2 ]; then Full_bkp_rataktp2="#68ff03";Full_bkp_rataktp21="Done";  else Full_bkp_rataktp2="#f55d5d";Full_bkp_rataktp21="Not Done";  fi
if [ $Full_bkp_rataktp4_count -ge 2 ]; then Full_bkp_rataktp4="#68ff03";Full_bkp_rataktp41="Done";  else Full_bkp_rataktp4="#f55d5d";Full_bkp_rataktp41="Not Done";  fi
if [ $Full_bkp_ratcalp2_count -ge 2 ]; then Full_bkp_ratcalp2="#68ff03";Full_bkp_ratcalp21="Done";  else Full_bkp_ratcalp2="#f55d5d";Full_bkp_ratcalp21="Not Done";  fi



#ol_rataktp1=`cat $WORKDIR/files/rataktp1.logs.2 | cut -d ';' -f 3`
#ol_rataktp2=`cat $WORKDIR/files/rataktp2.logs.2 | cut -d ';' -f 3`
#ol_rataktp4=`cat $WORKDIR/files/rataktp4.logs.2 | cut -d ';' -f 3`
#ol_ratcalp2=`cat $WORKDIR/files/ratcalp2.logs.2 | cut -d ';' -f 3`


for i in rataktp1_vm rataktp2_vm rataktp4_vm ratcalp2_vm
do

        ol_temp=`cat $WORKDIR/files/$i.logs.2 | cut -d ';' -f 3`

  if [ $ol_temp -gt $logical_log_not_backup_critical_threshould ]
  then

    ol_code="#f55d5d"

  elif [ $ol_temp -gt $logical_log_not_backup_medium_threshould ]
  then

    ol_code="orange"

  elif [ $ol_temp -gt $logical_log_not_backup_lower_threshould ]
  then

    ol_code="yellow"

  else

   ol_code="#68ff03"

  fi

if [ $i = "rataktp1_vm" ];
then
ll_code_rataktp1=`echo $ol_code`;

        if [ $ll_code_rataktp1 = "#68ff03" ]; then ll_code_rataktp11="Done"; else ll_code_rataktp11="Not Done"; fi
fi

if [ $i = "rataktp2_vm" ];
then
ll_code_rataktp2=`echo $ol_code`;

        if [ $ll_code_rataktp2 = "#68ff03" ]; then        ll_code_rataktp21="Done";       else ll_code_rataktp21="Not Done";

        fi
fi

if [ $i = "rataktp4_vm" ];
then
ll_code_rataktp4=`echo $ol_code`;

        if [ $ll_code_rataktp4 = "#68ff03" ]; then ll_code_rataktp41="Done"; else ll_code_rataktp41="Not Done"; fi
fi

if [ $i = "ratcalp2_vm" ];
then

ll_code_ratcalp2=`echo $ol_code`;
        if [ $ll_code_ratcalp2 = "#68ff03" ]; then        ll_code_ratcalp21="Done";       else ll_code_ratcalp21="Not Done"; fi

fi


#if [ $i = "rataktp2" ];then ll_code_rataktp2=`echo $ol_code`; fi
#if [ $i = "rataktp4" ];then ll_code_rataktp4=`echo $ol_code`; fi
#if [ $i = "ratcalp2" ];then ll_code_ratcalp2=`echo $ol_code`; fi



done

echo "$i Logical log is $ll_code_rataktp1"
echo "$i online log is $ll_code_rataktp2"
echo "$i online log is $ll_code_rataktp4"
echo "$i online log is $ll_code_ratcalp2"

space_per=`df -h /opt/informix | tail -1 | awk '{print $5}'`
space=`echo "${space_per//%}"`



if [ $space -gt 80 ];
then

        space_code="#f55d5d"

elif [ $space -gt 70 ];
then
        space_code="orange"

elif [ $space -gt 60 ];
then
        space_code="yellow"

else

        space_code="#68ff03"

fi

echo "space is $space_code"


datum=`date +%m/%d/%y`

log_error_cnt_rataktp1=`cat /opt/informix/IDS/14.10/tmp/online.log.rataktp1_vm | grep $datum | grep -i error | wc -l`
log_error_cnt_rataktp2=`cat /opt/informix/IDS/14.10/tmp/online.log.rataktp2_vm | grep $datum | grep -i error | wc -l`

datum_for_ratakp4=`date +%a" "%b" "%d`
sed -n "/${datum_for_ratakp4}/,\$p" /opt/informix/IDS/14.10/tmp/online.log.rataktp4_vm > $WORKDIR/files/tmp_online.log.rataktp4_vm



log_error_cnt_rataktp4=`cat $WORKDIR/files/tmp_online.log.rataktp4_vm | grep -i error | wc -l`

log_error_cnt_ratcalp2=`cat /opt/informix/IDS/14.10/tmp/online.log.ratcalp2_vm | grep $datum | grep -i error | wc -l`



if [ $log_error_cnt_rataktp1 -gt 0 ];then log_code_rataktp1="orange";log_code_rataktp11="Error found"; else log_code_rataktp1="#68ff03";log_code_rataktp11="No Error"; fi
if [ $log_error_cnt_rataktp2 -gt 0 ];then log_code_rataktp2="orange";log_code_rataktp21="Error found"; else log_code_rataktp2="#68ff03";log_code_rataktp21="No Error"; fi
if [ $log_error_cnt_rataktp4 -gt 0 ];then log_code_rataktp4="orange";log_code_rataktp41="Error found"; else log_code_rataktp4="#68ff03";log_code_rataktp41="No Error"; fi
if [ $log_error_cnt_ratcalp2 -gt 0 ];then log_code_ratcalp2="orange";log_code_ratcalp21="Error found"; else log_code_ratcalp2="#68ff03";log_code_ratcalp21="No Error"; fi


echo "Log error log_error_cnt_rataktp1 is  $log_error_cnt_rataktp1"
echo "Log error log_error_cnt_rataktp2 is  $log_error_cnt_rataktp2"
echo "Log error log_error_cnt_rataktp4 is  $log_error_cnt_rataktp4"
echo "Log error log_error_cnt_ratcalp2 is  $log_error_cnt_ratcalp2"



ov_lock_rataktp11=`cat $WORKDIR/files/onstat.p.rataktp1_vm | tail -8 | head -1 | awk '{print $1}'`
ov_lock_rataktp21=`cat $WORKDIR/files/onstat.p.rataktp2_vm | tail -8 | head -1 | awk '{print $1}'`
ov_lock_rataktp41=`cat $WORKDIR/files/onstat.p.rataktp4_vm | tail -8 | head -1 | awk '{print $1}'`
ov_lock_ratcalp21=`cat $WORKDIR/files/onstat.p.ratcalp2_vm | tail -8 | head -1 | awk '{print $1}'`

if [ $ov_lock_rataktp11 -gt 0 ];then ov_lock_rataktp1="yellow"; else ov_lock_rataktp1="#68ff03"; fi
if [ $ov_lock_rataktp21 -gt 0 ];then ov_lock_rataktp2="yellow"; else ov_lock_rataktp2="#68ff03"; fi
if [ $ov_lock_rataktp41 -gt 0 ];then ov_lock_rataktp4="yellow"; else ov_lock_rataktp4="#68ff03"; fi
if [ $ov_lock_ratcalp21 -gt 0 ];then ov_lock_ratcalp2="yellow"; else ov_lock_ratcalp2="#68ff03"; fi



ov_buff_rataktp11=`cat $WORKDIR/files/onstat.p.rataktp1_vm | tail -8 | head -1 | awk '{print $3}'`
ov_buff_rataktp21=`cat $WORKDIR/files/onstat.p.rataktp2_vm | tail -8 | head -1 | awk '{print $3}'`
ov_buff_rataktp41=`cat $WORKDIR/files/onstat.p.rataktp4_vm | tail -8 | head -1 | awk '{print $3}'`
ov_buff_ratcalp21=`cat $WORKDIR/files/onstat.p.ratcalp2_vm | tail -8 | head -1 | awk '{print $3}'`

if [ $ov_buff_rataktp11 -gt 0 ];then ov_buff_rataktp1="yellow"; else ov_buff_rataktp1="#68ff03"; fi
if [ $ov_buff_rataktp21 -gt 0 ];then ov_buff_rataktp2="yellow"; else ov_buff_rataktp2="#68ff03"; fi
if [ $ov_buff_rataktp41 -gt 0 ];then ov_buff_rataktp4="yellow"; else ov_buff_rataktp4="#68ff03"; fi
if [ $ov_buff_ratcalp21 -gt 0 ];then ov_buff_ratcalp2="yellow"; else ov_buff_ratcalp2="#68ff03"; fi


rollbk_rataktp11=`cat $WORKDIR/files/onstat.p.rataktp1_vm | head -10 | tail -1 | awk '{print $9}'`
rollbk_rataktp21=`cat $WORKDIR/files/onstat.p.rataktp2_vm | head -10 | tail -1 | awk '{print $9}'`
rollbk_rataktp41=`cat $WORKDIR/files/onstat.p.rataktp4_vm | head -10 | tail -1 | awk '{print $9}'`
rollbk_ratcalp21=`cat $WORKDIR/files/onstat.p.ratcalp2_vm | head -10 | tail -1 | awk '{print $9}'`

if [ $rollbk_rataktp11 -gt 0 ];then rollbk_rataktp1="yellow"; else rollbk_rataktp1="#68ff03"; fi
if [ $rollbk_rataktp21 -gt 0 ];then rollbk_rataktp2="yellow"; else rollbk_rataktp2="#68ff03"; fi
if [ $rollbk_rataktp41 -gt 0 ];then rollbk_rataktp4="yellow"; else rollbk_rataktp4="#68ff03"; fi
if [ $rollbk_ratcalp21 -gt 0 ];then rollbk_ratcalp2="yellow"; else rollbk_ratcalp2="#68ff03"; fi


dbspace_percent_rataktp1=`cat $WORKDIR/files/onstat.d.rataktp1_vm | tail -10 | egrep 'data|root' | awk '{print $5}' | sort -rn | tail -1 | awk -F"." '{print $1}'`
dbspace_percent_rataktp2=`cat $WORKDIR/files/onstat.d.rataktp2_vm | tail -10 | egrep 'data|root' | awk '{print $5}' | sort -rn | tail -1 | awk -F"." '{print $1}'`
dbspace_percent_rataktp4=`cat $WORKDIR/files/onstat.d.rataktp4_vm | tail -10 | egrep 'data|root' | awk '{print $5}' | sort -rn | tail -1 | awk -F"." '{print $1}'`
dbspace_percent_ratcalp2=`cat $WORKDIR/files/onstat.d.ratcalp2_vm | tail -10 | egrep 'data|root' | awk '{print $5}' | sort -rn | tail -1 | awk -F"." '{print $1}'`


if [ $dbspace_percent_rataktp1 -le 10 ];
then

        dbspace_percent_rataktp11="#f55d5d"

elif [ $dbspace_percent_rataktp1 -le 20 ];
then
        dbspace_percent_rataktp11="orange"

elif [ $dbspace_percent_rataktp1 -le 30 ];
then
        dbspace_percent_rataktp11="yellow"

else

        dbspace_percent_rataktp11="#68ff03"

fi

if [ $dbspace_percent_rataktp2 -le 10 ];
then

        dbspace_percent_rataktp21="#f55d5d"

elif [ $dbspace_percent_rataktp2 -le 20 ];
then
        dbspace_percent_rataktp21="orange"

elif [ $dbspace_percent_rataktp2 -le 30 ];
then
        dbspace_percent_rataktp21="yellow"

else

        dbspace_percent_rataktp21="#68ff03"

fi

if [ $dbspace_percent_rataktp4 -le 10 ];
then

        dbspace_percent_rataktp41="#f55d5d"

elif [ $dbspace_percent_rataktp4 -le 20 ];
then
        dbspace_percent_rataktp41="orange"

elif [ $dbspace_percent_rataktp4 -le 30 ];
then
        dbspace_percent_rataktp41="yellow"

else

        dbspace_percent_rataktp41="#68ff03"

fi

if [ $dbspace_percent_ratcalp2 -le 10 ];
then

        dbspace_percent_ratcalp21="#f55d5d"

elif [ $dbspace_percent_ratcalp2 -le 20 ];
then
        dbspace_percent_ratcalp21="orange"

elif [ $dbspace_percent_ratcalp2 -le 30 ];
then
        dbspace_percent_ratcalp21="yellow"

else

        dbspace_percent_ratcalp21="#68ff03"

fi


generate_html;

}


while true
do
        flag_p=`cat $WORKDIR/files/managment_report_flag`
        if [ $flag_p -eq 1 ]; then execute_report;exit 0; else echo "Parent Script is still executing";sleep 3; fi

done

