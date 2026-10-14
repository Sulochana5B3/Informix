cat /opt/informix/ifxmonitor/scripts/ifxmonitor.sh
#!/bin/bash
#===================================================================================
#
# FILE        : ifxmonitor.sh
# USAGE       : sh ifxmonitor.sh
# DESCRIPTION : This script is used Monitoring for Informix Instances on Tramo-pr1.
# OPTIONS     :  ---
# REQUIREMENTS:  ---
# NOTES       : Rollback and Error handling is not required
# AUTHOR      : Sagar Linge
# COMPANY     : Vodafone Shared Services India
# VERSION     : IFXMONITOR V0.99 last updated : 12/10/2018
# CREATED     : 12/10/18    Initial Version
# REVISION    :
#
#====================================================================================

NOCtime=""
function ClearVar  {

  let "wl_rataktp1 = 0"
  let "ol_rataktp1 = 0"
  let "cl_rataktp1 = 0"
  let "wl_rataktp2 = 0"
  let "ol_rataktp2 = 0"
  let "cl_rataktp2 = 0"
  let "wl_rataktp4 = 0"
  let "ol_rataktp4 = 0"
  let "cl_rataktp4 = 0"
  let "wl_ratcalp2 = 0"
  let "ol_ratcalp2 = 0"
  let "cl_ratcalp2 = 0"
  let "oi_rataktp1 = 0"
  let "oi_rataktp2 = 0"
  let "oi_rataktp4 = 0"
  let "oi_ratcalp2 = 0"



DayMon=""

st_sec=""
st_min=""
st_hr=""
st_dt=""
st_mnth_numeric=""
st_year_cut=""

end_sec=""
end_min=""
end_hr=""
end_dt=""
end_mnth_numeric=""
end_year_cut=""

exact_time=""

exact_diff_act1=""
exact_diff_act2=""
exact_diff_act4=""
exact_diff_cal2=""

count_err_act1=""
count_err_act2=""
count_err_act4=""
count_err_cal2=""


Begin_line_act1=""
End_line_act1=""
Begin_line_act2=""
End_line_act2=""
Begin_line_act4=""
End_line_act4=""
Begin_line_cal2=""
End_line_cal2=""

Begin_line_temp=""
End_line_temp=""
count_temp=""
count_err_temp=""

oi_temp=""
wl_temp=""
ol_temp=""
cl_temp=""

}

function write_html  {
echo "<html>" >> $HTMLFILE
echo "<head>" >> $HTMLFILE
echo "<title class=\header\'>Tramomonitor</title>" >> $HTMLFILE
echo "<meta http-equiv='refresh' content='1066'>" >> $HTMLFILE
echo "<meta http-equiv='pragma' content='no-cache'>" >> $HTMLFILE
echo "<link rel='stylesheet' type='text/css' href='logmonitor.css'>" >> $HTMLFILE
echo "</head>" >> $HTMLFILE
echo "<body class='backgrd'>" >> $HTMLFILE
echo "<table width='100%' border=0 bgcolor='red' cellspacing=0 cellpadding=0>" >> $HTMLFILE
echo "<tr>" >> $HTMLFILE
echo "<td width='20%' height='56' align='center' valign='center'><img src='vodafone.gif' align='center'></td>" >> $HTMLFILE
echo "<td width='60%' align='center' valign='center' class='header'>Informix Instances @ Tramo Environment</td>" >> $HTMLFILE
echo "<td width='20%' align='center' valign='center'><img src='vodafone.gif' align='center' ></td>" >> $HTMLFILE
echo "</tr>" >> $HTMLFILE
echo "</table>" >> $HTMLFILE
echo "<!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->" >> $HTMLFILE
echo "<table width=100% border=3 class=backgrd align=center cellspacing=0 cellpadding=2>" >> $HTMLFILE
echo "<tr align='left'>" >> $HTMLFILE
echo "<td width=40%><b>Running since: $RUNNING_SINCE_DATE </b></td>" >> $HTMLFILE
echo "<td width=20%><></td>" >> $HTMLFILE
echo "<td width=40%><b>Last update: $DATUM_LAUF </b></td>" >> $HTMLFILE
echo "</tr>" >> $HTMLFILE
echo "</table>" >> $HTMLFILE
echo "<div>" >> $HTMLFILE
echo "<table style='float:left;width=40%;border_width:3px; border-color:#FFFFFF; border-style:outset; padding:2px; background-color:#AAAAAA'>" >> $HTMLFILE
echo "<tr align='center' valign='top'>" >> $HTMLFILE
echo "<th class='app_header' style='width: 140px; height: 38.13px;'>DB Instance</th>" >> $HTMLFILE
echo "<th class='app_header' style='width: 324px; height: 38.13px;'>Full Backup ($DayMon)</th>" >> $HTMLFILE
echo "<th class='app_header' style='width: 112px; height: 38.13px;'>Full backup duration</th>" >> $HTMLFILE
echo "<th class='app_header' style='width: 144.5px; height: 38.13px;'>Error's during backup</th>" >> $HTMLFILE
echo "</tr>" >> $HTMLFILE
echo "<tr style='height: 18px;' align='left' valign='top'>" >> $HTMLFILE
echo "<td class='app_header' style='width: 140px; height: 18px;'><strong>rataktp1</strong></td>" >> $HTMLFILE
echo "<td class='eposBright' style='width: 324px; height: 18px;' nowrap='nowrap'>$Begin_line_act1</td>" >> $HTMLFILE
echo "<td class='eposBright' style='width: 112px; height: 36px; text-align: center;' rowspan='2' nowrap='nowrap'>$exact_diff_act1</td>" >> $HTMLFILE




if [ $count_err_act1 -gt 0 ]
then

        echo "<td class='eposBright' style='width: 144.5px; height: 36px; text-align: center;' rowspan='2' nowrap='nowrap'><span style="background-color: \#ff0000\;">$count_err_act1</td>" >> $HTMLFILE

else

        echo "<td class='eposBright' style='width: 144.5px; height: 36px; text-align: center;' rowspan='2' nowrap='nowrap'>$count_err_act1</td>" >> $HTMLFILE

fi




echo "</tr>" >> $HTMLFILE
echo "<tr style='height: 18px;' align='center' valign='top'>" >> $HTMLFILE
echo "<td class='app_header' style='width: 140px; height: 18px;' align='left'><strong>rataktp1</strong></td>" >> $HTMLFILE
echo "<td class='eposBright' style='width: 324px; height: 18px;' align='left' nowrap='nowrap'>$End_line_act1</td>" >> $HTMLFILE
echo "</tr>" >> $HTMLFILE
echo "<tr style='height: 19px;' align='left' valign='top'>" >> $HTMLFILE
echo "<td class='app_header' style='width: 140px; height: 19px;'><strong>rataktp2</strong></td>" >> $HTMLFILE
echo "<td class='eposBright' style='width: 324px; height: 19px;' nowrap='nowrap'>$Begin_line_act2</td>" >> $HTMLFILE
echo "<td class='eposBright' style='width: 112px; height: 37px; text-align: center;' rowspan='2' nowrap='nowrap'>$exact_diff_act2</td>" >> $HTMLFILE





if [ $count_err_act2 -gt 0 ]
then

        echo "<td class='eposBright' style='width: 144.5px; height: 37px; text-align: center;' rowspan='2' nowrap='nowrap'><span style="background-color: \#ff0000\;">$count_err_act2</td>" >> $HTMLFILE

else

        echo "<td class='eposBright' style='width: 144.5px; height: 37px; text-align: center;' rowspan='2' nowrap='nowrap'>$count_err_act2</td>" >> $HTMLFILE

fi


echo "</tr>" >> $HTMLFILE
echo "<tr style='height: 18px;' align='center' valign='top'>" >> $HTMLFILE
echo "<td class='app_header' style='width: 140px; height: 18px;' align='left'><strong>rataktp2</strong></td>" >> $HTMLFILE
echo "<td class='eposBright' style='width: 324px; height: 18px;' align='left' nowrap='nowrap'>$End_line_act2</td>" >> $HTMLFILE
echo "</tr>" >> $HTMLFILE
echo "<tr style='height: 18px;' align='left' valign='top'>" >> $HTMLFILE
echo "<td class='app_header' style='width: 140px; height: 18px;'><strong>rataktp4</strong></td>" >> $HTMLFILE
echo "<td class='eposBright' style='width: 324px; height: 18px;' nowrap='nowrap'>$Begin_line_act4</td>" >> $HTMLFILE
echo "<td class='eposBright' style='width: 112px; height: 36px; text-align: center;' rowspan='2' nowrap='nowrap'>$exact_diff_act4</td>" >> $HTMLFILE

if [ $count_err_act4 -gt 0 ]
then

        echo "<td class='eposBright' style='width: 144.5px; height: 36px; text-align: center;' rowspan='2' nowrap='nowrap'><span style="background-color: \#ff0000\;">$count_err_act4</td>" >> $HTMLFILE

else

        echo "<td class='eposBright' style='width: 144.5px; height: 36px; text-align: center;' rowspan='2' nowrap='nowrap'>$count_err_act4</td>" >> $HTMLFILE

fi




echo "</tr>" >> $HTMLFILE
echo "<tr style='height: 18px;' align='center' valign='top'>" >> $HTMLFILE
echo "<td class='app_header' style='width: 140px; height: 18px;' align='left'><strong>rataktp4</strong></td>" >> $HTMLFILE
echo "<td class='eposBright' style='width: 324px; height: 18px;' align='left' nowrap='nowrap'>$End_line_act4</td>" >> $HTMLFILE
echo "</tr>" >> $HTMLFILE
echo "<tr style='height: 18px;' align='left' valign='top'>" >> $HTMLFILE
echo "<td class='app_header' style='width: 140px; height: 18px;'><strong>ratcalp2</strong></td>" >> $HTMLFILE
echo "<td class='eposBright' style='width: 324px; height: 18px;' nowrap='nowrap'>$Begin_line_cal2</td>" >> $HTMLFILE
echo "<td class='eposBright' style='width: 112px; height: 36px; text-align: center;' rowspan='2' nowrap='nowrap'>$exact_diff_cal2</td>" >> $HTMLFILE


if [ $count_err_cal2 -gt 0 ]
then

        echo "<td class='eposBright' style='width: 144.5px; height: 36px; text-align: center;' rowspan='2' nowrap='nowrap'><span style="background-color: \#ff0000\;">$count_err_cal2</td>" >> $HTMLFILE

else

        echo "<td class='eposBright' style='width: 144.5px; height: 36px; text-align: center;' rowspan='2' nowrap='nowrap'>$count_err_cal2</td>" >> $HTMLFILE

fi




echo "</tr>" >> $HTMLFILE
echo "<tr style='height: 18px;' align='center' valign='top'>" >> $HTMLFILE
echo "<td class='app_header' style='width: 140px; height: 18px;' align='left'><strong>ratcalp2</strong></td>" >> $HTMLFILE
echo "<td class='eposBright' style='width: 324px; height: 18px;' align='left' nowrap='nowrap'>$End_line_cal2</td>" >> $HTMLFILE
echo "</tr>" >> $HTMLFILE
echo "</table>" >> $HTMLFILE
echo "</div>" >> $HTMLFILE
echo "<div>" >> $HTMLFILE
echo "<table style='float:left;width=40%;border_width:3px; border-color:#FFFFFF; border-style:outset; padding:2px; background-color:#AAAAAA'>" >> $HTMLFILE
echo "<tr align='center' valign='top'>" >> $HTMLFILE
echo "<th class='app_header' style='width:30px' >DB Instance</th>" >> $HTMLFILE
echo "<th class='app_header' style='width:30px' >Num.Log.Logs written today</th>" >> $HTMLFILE
echo "<th class='app_header' style='width:30px' >not saved Logs</th>" >> $HTMLFILE
echo "<th class='app_header' style='width:30px' >Num.Log.Logs of Instance</th>" >> $HTMLFILE
echo "<th class='app_header' style='width:30px' >Num of Oninit Processes</th>" >> $HTMLFILE
echo "</tr>" >> $HTMLFILE
echo "<tr align='left' valign='top'>" >> $HTMLFILE
echo "<td class='app_header'><b>rataktp1</b></td>" >> $HTMLFILE
echo "<td class='epos' align='center' valign='middle'>$wl_rataktp1</td>" >> $HTMLFILE

if [ $ol_rataktp1 -ge 10 -a $ol_rataktp1 -le 15 ]
then
#yellow
        echo "<td class='eposBright' align='center' valign='middle'><span style="background-color: \#ffff00\;">$ol_rataktp1</td>" >> $HTMLFILE

elif [ $ol_rataktp1 -gt 15 ]
then

#Red
        echo "<td class='eposBright' align='center' valign='middle'><span style="background-color: \#ff0000\;">$ol_rataktp1</td>" >> $HTMLFILE

else

        echo "<td class='eposBright' align='center' valign='middle'>$ol_rataktp1</td>" >> $HTMLFILE

fi




echo "<td class='epos' align='center' valign='middle'>$cl_rataktp1</td>" >> $HTMLFILE



if [ $oi_rataktp1 -lt 15 ]
then

        echo "<td class='epos' align='center' valign='middle'><span style="background-color: \#ff0000\;">$oi_rataktp1</td>" >> $HTMLFILE

else

        echo "<td class='epos' align='center' valign='middle'>$oi_rataktp1</td>" >> $HTMLFILE

fi




echo "</tr>" >> $HTMLFILE
echo "<tr align='left' valign='top'>" >> $HTMLFILE
echo "<td class='app_header'><b>rataktp2</b></td>" >> $HTMLFILE
echo "<td class='epos' align='center' valign='middle'>$wl_rataktp2</td>" >> $HTMLFILE

if [ $ol_rataktp2 -ge 10 -a $ol_rataktp2 -le 15 ]
then
#yellow
        echo "<td class='eposBright' align='center' valign='middle'><span style="background-color: \#ffff00\;">$ol_rataktp2</td>" >> $HTMLFILE

elif [ $ol_rataktp2 -gt 15 ]
then

#Red
        echo "<td class='eposBright' align='center' valign='middle'><span style="background-color: \#ff0000\;">$ol_rataktp2</td>" >> $HTMLFILE

else

        echo "<td class='eposBright' align='center' valign='middle'>$ol_rataktp2</td>" >> $HTMLFILE

fi




echo "<td class='epos' align='center' valign='middle'>$cl_rataktp2</td>" >> $HTMLFILE


#echo "<td class='epos' align='center' valign='middle'>$oi_rataktp2</td>" >> $HTMLFILE

if [ $oi_rataktp2 -lt 15 ]
then

        echo "<td class='epos' align='center' valign='middle'><span style="background-color: \#ff0000\;">$oi_rataktp2</td>" >> $HTMLFILE

else

        echo "<td class='epos' align='center' valign='middle'>$oi_rataktp2</td>" >> $HTMLFILE

fi



echo "</tr>" >> $HTMLFILE
echo "<tr align='left' valign='top'>" >> $HTMLFILE
echo "<td class='app_header'><b>rataktp4</b></td>" >> $HTMLFILE
echo "<td class='epos' align='center' valign='middle'>$wl_rataktp4</td>" >> $HTMLFILE


#echo "<td class='eposBright' align='center' valign='middle'>$ol_rataktp4</td>" >> $HTMLFILE

if [ $ol_rataktp4 -ge 10 -a $ol_rataktp4 -le 15 ]
then
#yellow
        echo "<td class='eposBright' align='center' valign='middle'><span style="background-color: \#ffff00\;">$ol_rataktp4</td>" >> $HTMLFILE

elif [ $ol_rataktp4 -gt 15 ]
then

#Red
        echo "<td class='eposBright' align='center' valign='middle'><span style="background-color: \#ff0000\;">$ol_rataktp4</td>" >> $HTMLFILE

else

        echo "<td class='eposBright' align='center' valign='middle'>$ol_rataktp4</td>" >> $HTMLFILE

fi


echo "<td class='epos' align='center' valign='middle'>$cl_rataktp4</td>" >> $HTMLFILE


#echo "<td class='epos' align='center' valign='middle'>$oi_rataktp4</td>" >> $HTMLFILE

if [ $oi_rataktp4 -lt 15 ]
then

        echo "<td class='epos' align='center' valign='middle'><span style="background-color: \#ff0000\;">$oi_rataktp4</td>" >> $HTMLFILE

else

        echo "<td class='epos' align='center' valign='middle'>$oi_rataktp4</td>" >> $HTMLFILE

fi


echo "</tr>" >> $HTMLFILE
echo "<tr align='left' valign='top'>" >> $HTMLFILE
echo "<td class='app_header'><b>ratcalp2</b></td>" >> $HTMLFILE
echo "<td class='epos' align='center' valign='middle'>$wl_ratcalp2</td>" >> $HTMLFILE


#echo "<td class='eposBright' align='center' valign='middle'>$ol_ratcalp2</td>" >> $HTMLFILE

if [ $ol_ratcalp2 -ge 10 -a $ol_ratcalp2 -le 15 ]
then
#yellow
        echo "<td class='eposBright' align='center' valign='middle'><span style="background-color: \#ffff00\;">$ol_ratcalp2</td>" >> $HTMLFILE

elif [ $ol_ratcalp2 -gt 15 ]
then

#Red
        echo "<td class='eposBright' align='center' valign='middle'><span style="background-color: \#ff0000\;">$ol_ratcalp2</td>" >> $HTMLFILE

else

        echo "<td class='eposBright' align='center' valign='middle'>$ol_ratcalp2</td>" >> $HTMLFILE

fi



echo "<td class='epos' align='center' valign='middle'>$cl_ratcalp2</td>" >> $HTMLFILE


#echo "<td class='epos' align='center' valign='middle'>$oi_ratcalp2</td>" >> $HTMLFILE

if [ $oi_ratcalp2 -lt 15 ]
then

        echo "<td class='epos' align='center' valign='middle'><span style="background-color: \#ff0000\;">$oi_ratcalp2</td>" >> $HTMLFILE

else

        echo "<td class='epos' align='center' valign='middle'>$oi_ratcalp2</td>" >> $HTMLFILE

fi



echo "</tr>" >> $HTMLFILE
echo "</table>" >> $HTMLFILE
echo "</div>" >> $HTMLFILE
echo "<div>" >> $HTMLFILE
echo "<table style='width: 100%; border_width:2px; border-color:#FFFFFF; border-style:outset; background-color:#AAAAAA'>" >> $HTMLFILE
echo "<thead>" >> $HTMLFILE
echo "<tr>" >> $HTMLFILE
echo "<th class='app_header' style='width: 300px'><a href='rataktp1.html'><b><font size=4>rataktp1</font></b></th>" >> $HTMLFILE
echo "<th class='app_header_bright' style='width: 300px'><a href='rataktp2.html'><b><font size=4>rataktp2</font></b></th>" >> $HTMLFILE
echo "<th class='app_header' style='width: 300px'><a href='ratcalp2.html'><b><font size=4>ratcalp2</font></b></th>" >> $HTMLFILE
echo "<th class='app_header_bright' style='width: 300px'><a href='rataktp4.html'><b><font size=4>rataktp4</font></b></th>" >> $HTMLFILE
echo "</tr>" >> $HTMLFILE
echo "</thead>" >> $HTMLFILE
echo "<tbody>" >> $HTMLFILE
echo "<tr>" >> $HTMLFILE
echo "<td class='epos'>" >> $HTMLFILE
echo "<textarea style='background-color: white; font-weight: bold; width:100%; height:700' wrap='off' disabled>" >> $HTMLFILE
cat $WORKDIR/files/log-prot.rataktp1_vm >> $HTMLFILE
echo "</textarea>" >> $HTMLFILE
echo "</td>" >> $HTMLFILE
echo "<td class='epos'>" >> $HTMLFILE
echo "<textarea style='background-color: white; font-weight: bold; width:100%; height:700' wrap='off' disabled>" >> $HTMLFILE
cat $WORKDIR/files/log-prot.rataktp2_vm >> $HTMLFILE
echo "</textarea>" >> $HTMLFILE
echo "</td>" >> $HTMLFILE
echo "<td class='epos'>" >> $HTMLFILE
echo "<textarea style='background-color: white; font-weight: bold; width:100%; height:700' wrap='off' disabled>" >> $HTMLFILE
cat $WORKDIR/files/log-prot.rataktp4_vm >> $HTMLFILE
echo "</textarea>" >> $HTMLFILE
echo "</td>" >> $HTMLFILE
echo "<td class='epos'>" >> $HTMLFILE
echo "<textarea style='background-color: white; font-weight: bold; width:100%; height:700' wrap='off' disabled>" >> $HTMLFILE
cat $WORKDIR/files/log-prot.ratcalp2_vm >> $HTMLFILE
echo "</textarea>" >> $HTMLFILE
echo "</td>" >> $HTMLFILE
echo "</tr>" >> $HTMLFILE
echo "</table>" >> $HTMLFILE
echo "</div>" >> $HTMLFILE
echo "</body>" >> $HTMLFILE
echo "</html>" >> $HTMLFILE
}

function Calculate_time_difference {

seconds2time ()
{
   T=$1
   D=$((T/60/60/24))
   H=$((T/60/60%24))
   M=$((T/60%60))
   S=$((T%60))

   if [[ ${D} != 0 ]]
   then
      VAL=`printf '%d days %02d hours %02d minutes %02d seconds' $D $H $M $S`;
        echo $VAL;
   else
      VAL=`printf '%02d hours %02d minutes %02d seconds' $H $M $S`;
        echo $VAL;
   fi
}
epoch1=`/opt/informix/ifxmonitor/scripts/epoch_timer.pl $st_sec $st_min $st_hr $st_dt $st_mnth_numeric $st_year_cut`;
epoch2=`/opt/informix/ifxmonitor/scripts/epoch_timer.pl $end_sec $end_min $end_hr $end_dt $end_mnth_numeric $end_year_cut`;


TOTAL_TIME=`expr "$epoch2" - "$epoch1"`;
exact_diff=`seconds2time $TOTAL_TIME`
#act1 act2 act4 cal2
#echo $exact_diff

set_values $1 Calculate_time_difference


}

function get_noc_timestamp {

NOCtime=`/opt/informix/ifxmonitor/scripts/get_NOC_timestamp.pl`;

}

function checkFullBackups  {
  # Suggestion :
  # Check begins at 6:00am whether Full backup has begun: if not create ticket
  #              at 6:30am whether Full Backup has finished successfully: if not create ticket
  # Relevant Files : bar_act1.log.backup bar_act2.log.backup bar_act4.log.backup bar_cal2.log.backup
  # File structure : YYYY-MM-DD hh:mm:ss : Begin FullBackup
  #                  YYYY-MM-DD hh:mm:ss : End   FullBackup

  for i in act1 act2 act4 cal2
   do


                #act1 act2 act4 calp2
                INFORMIXSERVER=""
                if [ $i = "act1" ]; then  INFORMIXSERVER="rataktp1_vm"; fi
                if [ $i = "act2" ]; then  INFORMIXSERVER="rataktp2_vm"; fi
                if [ $i = "act4" ]; then  INFORMIXSERVER="rataktp4_vm"; fi
                if [ $i = "cal2" ]; then  INFORMIXSERVER="ratcalp2_vm"; fi

                DayMon=`date|awk '{ print substr($0,1,10) }'`

                CHECK_WHAT_FLAG full_backup_flag $INFORMIXSERVER

                Begin_line_temp=`head -1 $WORKDIR/files/bar_$i.log.backup`
                End_line_temp=`tail -1 $WORKDIR/files/bar_$i.log.backup`

                #count_act1,count_act1,count_act1,count_act1
                count_temp=`cat $WORKDIR/files/bar_$i.log.backup | wc -l`
                #count_err_temp=`cat $INFORMIXDIR/tmp/bar_$i.log | grep -i 'failed\|error\|warning' | wc -l`
                                #added comment on 07022019
                                datum=`date +%Y-%m-%d`
                                count_err_temp=`cat $INFORMIXDIR/tmp/bar_$i.log | grep $datum | egrep -i 'failed|error|warning' | wc -l`

        if [ $count_temp -eq 2 ]
                        then
                        # calculate backup duration

                        st_sec=`cat $WORKDIR/files/bar_$i.log.backup | sed -e "s/ /#/g" | sed -e "s/:/#/g" | sed -e "s/-/#/g" | sed -e "s/###/#/g" | grep "Begin" | awk -F"#" '{print $6}'`
                        st_min=`cat $WORKDIR/files/bar_$i.log.backup | sed -e "s/ /#/g" | sed -e "s/:/#/g" | sed -e "s/-/#/g" | sed -e "s/###/#/g" | grep "Begin" | awk -F"#" '{print $5}'`
                        st_hr=`cat $WORKDIR/files/bar_$i.log.backup | sed -e "s/ /#/g" | sed -e "s/:/#/g" | sed -e "s/-/#/g" | sed -e "s/###/#/g" | grep "Begin" | awk -F"#" '{print $4}'`
                        st_dt=`cat $WORKDIR/files/bar_$i.log.backup | sed -e "s/ /#/g" | sed -e "s/:/#/g" | sed -e "s/-/#/g" | sed -e "s/###/#/g" | grep "Begin" | awk -F"#" '{print $3}'`
                        st_mnth_numeric=`cat $WORKDIR/files/bar_$i.log.backup | sed -e "s/ /#/g" | sed -e "s/:/#/g" | sed -e "s/-/#/g" | sed -e "s/###/#/g" | grep "Begin" | awk -F"#" '{print $2}'`
                        st_year_cut=`cat $WORKDIR/files/bar_$i.log.backup | sed -e "s/ /#/g" | sed -e "s/:/#/g" | sed -e "s/-/#/g" | sed -e "s/###/#/g" | grep "Begin" | awk -F"#" '{print $1}'`

                        end_sec=`cat $WORKDIR/files/bar_$i.log.backup | sed -e "s/ /#/g" | sed -e "s/:/#/g" | sed -e "s/-/#/g" | sed -e "s/###/#/g" | grep "End" | awk -F"#" '{print $6}'`
                        end_min=`cat $WORKDIR/files/bar_$i.log.backup | sed -e "s/ /#/g" | sed -e "s/:/#/g" | sed -e "s/-/#/g" | sed -e "s/###/#/g" | grep "End" | awk -F"#" '{print $5}'`
                        end_hr=`cat $WORKDIR/files/bar_$i.log.backup | sed -e "s/ /#/g" | sed -e "s/:/#/g" | sed -e "s/-/#/g" | sed -e "s/###/#/g" | grep "End" | awk -F"#" '{print $4}'`
                        end_dt=`cat $WORKDIR/files/bar_$i.log.backup | sed -e "s/ /#/g" | sed -e "s/:/#/g" | sed -e "s/-/#/g" | sed -e "s/###/#/g" | grep "End" | awk -F"#" '{print $3}'`
                        end_mnth_numeric=`cat $WORKDIR/files/bar_$i.log.backup | sed -e "s/ /#/g" | sed -e "s/:/#/g" | sed -e "s/-/#/g" | sed -e "s/###/#/g" | grep "End" | awk -F"#" '{print $2}'`
                        end_year_cut=`cat $WORKDIR/files/bar_$i.log.backup | sed -e "s/ /#/g" | sed -e "s/:/#/g" | sed -e "s/-/#/g" | sed -e "s/###/#/g" | grep "End" | awk -F"#" '{print $1}'`


                        let "full_backup_mailsent_flag = 0"
                        echo "$full_backup_mailsent_flag" >$WORKDIR/files/err_cnt/$INFORMIXSERVER/full_backup_mailsent_flag

                        if [ "$FLAG_STATUS" != "CLEARED" ]; then

                                reset_flag_date
                                echo "$flag_date#full_backup_flag#$INFORMIXSERVER#CLEARED" >> $WORKDIR/files/flags.txt

                                                                #Added on 07/02/2019
                                                                ERR_MSG="CLEARED Full Backup not done for $INFORMIXSERVER."
                                                                                                                                echo $ERR_MSG
                                echo $ERR_MSG | /usr/bin/mailx -s 'CLEARED Full backup not done for Informix Instance.' -r $mailid

                        fi

                        Calculate_time_difference $i

        elif [ $count_temp -eq 1 ]
                                then
                        # check if begin of Full backup is okay and missing End also okay, because it is earlier than 6:30am
                        # It's later than 6:30am ?
                        # Yes ? ==> check if TTWOS is active
                        # Yes ==> write a row to the $NOCFILE with the following structure
                        #   YYYYMMDDhhmmss;Major;<Instance>;Full Backup failed
                        #echo "Current time is between 06:00 am to 06:30 am during which the backup runs."

                                abbrechen=`date +%H%M`
                                if [ $abbrechen -ge $full_bkp_low_time -a $abbrechen -le $full_bkp_high_time ]
                                        then
                                                date
                                                echo "Current time is between 00:00 am to 06:00 am during which the backup runs."
                                                #set all values to "?"
                                                set_values IFLOOP checkFullBackups

                                else


                                        full_backup_mailsent_flag=`cat $WORKDIR/files/err_cnt/$INFORMIXSERVER/full_backup_mailsent_flag`
                                        let "full_backup_mailsent_flag = full_backup_mailsent_flag + 1"
                                        echo "$full_backup_mailsent_flag" >$WORKDIR/files/err_cnt/$INFORMIXSERVER/full_backup_mailsent_flag


                                        YYYYMMDDhhmmss=`date '+%Y%m%d%H%M%S'`



                                                if [ "$FLAG_STATUS" = "CLEARED" -a $full_backup_mailsent_flag = "1"   ]; then


                                                        reset_flag_date
                                                        echo "$flag_date#full_backup_flag#$INFORMIXSERVER#FIRSTMAILSENT" >> $WORKDIR/files/flags.txt

                                                        ERR_MSG="Full Backup not done for $INFORMIXSERVER."
                                                                                                                echo $ERR_MSG
                                                        echo $ERR_MSG | /usr/bin/mailx -s 'Full backup not done for Informix Instance.'-r $mailid

                                                                                                                if [ $TTWOS_AKTIV = "1" ]; then

                                                                                                                        #TITLE="Full backup not done for Informix."
                                                                                                                        #MSG="Full Backup not done for $INFORMIXSERVER."

                                                                                                                        #ssh adbm@adeoas01s "echo "NEW:$SEVERITY_full_backup:$TITLE:$MSG" >> /home/adbm/prod/Informix/ticket.catlog" 2>/dev/null

                                                                                                                        get_noc_timestamp
                                                                                                                        MSG="Full Backup failed."
                                                                                                                                                                                                                                                echo $MSG
                                                                                                                        ssh adbm@adeoas01s "echo '$NOCtime;Major;$INFORMIXSERVER;$MSG' >> /home/adbm/prod/Informix/NOC_DATA/tramo_monitor.log" 2>/dev/null


                                                                                                                fi

                                                else

                                                        echo "First mail is sent for the full backup not done for $INFORMIXSERVER"

                                                fi

                                fi

        else
                                abbrechen=`date +%H%M`
                                if [ $abbrechen -ge $full_bkp_low_time -a $abbrechen -le $full_bkp_high_time ]
                                then

                                                date
                                                echo "Current time is between 00:00 am to 06:00 am during which the backup runs."
                                                set_values IFLOOP checkFullBackups

                                else


                                        full_backup_mailsent_flag=`cat $WORKDIR/files/err_cnt/$INFORMIXSERVER/full_backup_mailsent_flag`
                                        let "full_backup_mailsent_flag = full_backup_mailsent_flag + 1"
                                        echo "$full_backup_mailsent_flag" >$WORKDIR/files/err_cnt/$INFORMIXSERVER/full_backup_mailsent_flag


                                        YYYYMMDDhhmmss=`date '+%Y%m%d%H%M%S'`



                                                if [ "$FLAG_STATUS" = "CLEARED" -a $full_backup_mailsent_flag = "1"   ]; then

                                                        echo "$YYYYMMDDhhmmss;Major;$INFORMIXSERVER>;Full Backup failed" >> $NOCFILE

                                                        reset_flag_date
                                                        echo "$flag_date#full_backup_flag#$INFORMIXSERVER#FIRSTMAILSENT" >> $WORKDIR/files/flags.txt

                                                        ERR_MSG="Full Backup not done for $INFORMIXSERVER."
                                                                                                                echo $ERR_MSG
                                                        echo $ERR_MSG | /usr/bin/mailx -s 'Full backup not done for Informix Instance.' -r $mailid

                                                                                                                if [ $TTWOS_AKTIV = "1" ]; then

                                                                                                                        #TITLE="Full backup not done for Informix."
                                                                                                                        #MSG="Full Backup not done for $INFORMIXSERVER."

                                                                                                                        #ssh -o ConnectTimeout=25 adbm@adeoas01s "/home/adbm/prod/Informix/create_ttwos_ticket.sh $SEVERITY_full_backup $TITLE $MSG" 2>/dev/null
                                                                                                                        #ssh adbm@adeoas01s "echo "NEW:$SEVERITY_full_backup:$TITLE:$MSG" >> /home/adbm/prod/Informix/ticket.catlog" 2>/dev/null

                                                                                                                        get_noc_timestamp
                                                                                                                        MSG="Full Backup failed."
                                                                                                                                                                                                                                                echo $MSG
                                                                                                                        ssh adbm@adeoas01s "echo '$NOCtime;Major;$INFORMIXSERVER;$MSG' >> /home/adbm/prod/Informix/NOC_DATA/tramo_monitor.log" 2>/dev/null

                                                                                                                fi

                                                else

                                                        echo "First mail is sent for the full backup not done for $INFORMIXSERVER"

                                                fi


                                fi


        fi

  set_values $i checkFullBackups

  done


}

function checkLogBackups {
  # Looking for current situation regarding logical Logs of Informix instances
  # Two Thresholds should be defined for not saved Logs (Warning and Alert)
  # Information is delivered by the script db_logs2.sh, running on tramo-pr1
  # Relevant Files : <Instance>.logs.2
  # File structure : YYYY-MM-DD hh:mm:ss;<written today>;<not saved>;<configured logs>

for i in rataktp1_vm rataktp2_vm rataktp4_vm ratcalp2_vm
do

  INFORMIXSERVER=$i
  #CHECK_WHAT_FLAG ol_temp_flag $INFORMIXSERVER

  CHECK_DATE=`cat $WORKDIR/files/$i.logs.2 | cut -d ';' -f 1`
  compare_timestamp "$DATUM_LAUF" "$CHECK_DATE"
  RC=$?
  if [ $RC -eq 0 ]
  then
    wl_temp=`cat $WORKDIR/files/$i.logs.2 | cut -d ';' -f 2`
    ol_temp=`cat $WORKDIR/files/$i.logs.2 | cut -d ';' -f 3`
    cl_temp=`cat $WORKDIR/files/$i.logs.2 | cut -d ';' -f 4`

    ol_temp_err_cnt_critical=`cat $WORKDIR/files/err_cnt/$i/ol_temp_err_cnt_critical`
        ol_temp_err_cnt_medium=`cat $WORKDIR/files/err_cnt/$i/ol_temp_err_cnt_medium`
        ol_temp_err_cnt=`cat $WORKDIR/files/err_cnt/$i/ol_temp_err_cnt`


                        if [ $ol_temp -gt $logical_log_not_backup_critical_threshould ]
                        then
                        #  how many times these has happened after another
                        #  three times ?
                        #  check if TTWOS is active
                        #  Yes ? ==> write a row to the $NOCFILE with the following structure
                        #    YYYYMMDDhhmmss;<Priority>;<Ifx-Instance>;Logical Logs are not saved
                        #20130710112410;Major;rataktp1;Logical Logs are not saved
                        #20140903195123;Critical;rataktp1;Logical Logs are not saved



                                        let "ol_temp_err_cnt_critical = ol_temp_err_cnt_critical + 1"
                                        echo "$ol_temp_err_cnt_critical" >$WORKDIR/files/err_cnt/$i/ol_temp_err_cnt_critical

                                        CHECK_WHAT_FLAG ol_temp_flag_critical $INFORMIXSERVER


                                        if [ "$FLAG_STATUS" = "CLEARED" -a $ol_temp_err_cnt_critical -eq $Monitor_attempt_ol_temp_first  ]; then


                                                reset_flag_date
                                                echo "$flag_date#ol_temp_flag_critical#$INFORMIXSERVER#FIRSTMAILSENT" >> $WORKDIR/files/flags.txt

                                                ERR_MSG="Check the output of 'onstat -l' for $i instance , The logical logs are not getting backup."
                                                echo $ERR_MSG | /usr/bin/mailx -s 'onstat -l Logical logs not backed up : Critical threshould breached !!' -r $mailid

                                                                                                                if [ $TTWOS_AKTIV = "1" ]; then

                                                                                                                        #TITLE="The logical logs are not getting backup for Informix."
                                                                                                                        #MSG="Logical logs not backed up for $INFORMIXSERVER.Critical threshold breached."

                                                                                                                        #ssh -o ConnectTimeout=25 adbm@adeoas01s "/home/adbm/prod/Informix/create_ttwos_ticket.sh $SEVERITY_logical_log_critical $TITLE $MSG" 2>/dev/null

                                                                                                                        #ssh adbm@adeoas01s "echo "NEW:$SEVERITY_logical_log_critical:$TITLE:$MSG" >> /home/adbm/prod/Informix/ticket.catlog" 2>/dev/null
                                                                                                                        get_noc_timestamp
                                                                                                                        MSG="Logical Logs are not saved."
                                                                                                                        ssh adbm@adeoas01s "echo '$NOCtime;Major;$INFORMIXSERVER;$MSG' >> /home/adbm/prod/Informix/NOC_DATA/tramo_monitor.log" 2>/dev/null

                                                                                                                fi

                                        else


                                                echo "First mail already sent. Critical threshold breached "


                                        fi

                        elif [ $ol_temp -gt $logical_log_not_backup_medium_threshould ]
                        then


                                        let "ol_temp_err_cnt_medium = ol_temp_err_cnt_medium + 1"
                                        echo "$ol_temp_err_cnt_medium" >$WORKDIR/files/err_cnt/$i/ol_temp_err_cnt_medium

                                        CHECK_WHAT_FLAG ol_temp_flag_medium $INFORMIXSERVER

                                        if [ "$FLAG_STATUS" = "CLEARED" -a $ol_temp_err_cnt_medium -eq $Monitor_attempt_ol_temp_first  ]; then

                                                reset_flag_date
                                                echo "$flag_date#ol_temp_flag_medium#$INFORMIXSERVER#FIRSTMAILSENT" >> $WORKDIR/files/flags.txt

                                                ERR_MSG="Logical logs are not getting saved for $i Instance . Medium threshold breached !!"
                                                echo $ERR_MSG | /usr/bin/mailx -s 'Logical logs not getting backedup.' -r $mailid


                                                                                                                if [ $TTWOS_AKTIV = "1" ]; then

                                                                                                                        #TITLE="The logical logs are not getting backup for Informix."
                                                                                                                        #MSG="Logical logs not backed up for $INFORMIXSERVER.Medium threshold breached."

                                                                                                                        #ssh -o ConnectTimeout=25 adbm@adeoas01s "/home/adbm/prod/Informix/create_ttwos_ticket.sh $SEVERITY_logical_log_medium $TITLE $MSG" 2>/dev/null
                                                                                                                        #ssh adbm@adeoas01s "echo "NEW:$SEVERITY_logical_log_medium:$TITLE:$MSG" >> /home/adbm/prod/Informix/ticket.catlog" 2>/dev/null

                                                                                                                        get_noc_timestamp
                                                                                                                        MSG="Logical Logs are not saved."
                                                                                                                        ssh adbm@adeoas01s "echo '$NOCtime;Major;$INFORMIXSERVER;$MSG' >> /home/adbm/prod/Informix/NOC_DATA/tramo_monitor.log" 2>/dev/null

                                                                                                                fi


                                        else


                                                echo "First mail already sent. Medium threshold breached "


                                        fi


                        elif [ $ol_temp -gt $logical_log_not_backup_lower_threshould ]
                        then



                                        let "ol_temp_err_cnt = ol_temp_err_cnt + 1"
                                        echo "$ol_temp_err_cnt" >$WORKDIR/files/err_cnt/$INFORMIXSERVER/ol_temp_err_cnt

                                        CHECK_WHAT_FLAG ol_temp_flag $INFORMIXSERVER


                                        if [ "$FLAG_STATUS" = "CLEARED" -a $ol_temp_err_cnt -eq $Monitor_attempt_ol_temp_third  ]; then

                                                        reset_flag_date
                                                        echo "$flag_date#ol_temp_flag#$INFORMIXSERVER#FIRSTMAILSENT" >> $WORKDIR/files/flags.txt

                                                        ERR_MSG="Check the output of 'onstat -l' for $i instance , The logical logs are not getting backup."
                                                        echo $ERR_MSG | /usr/bin/mailx -s 'onstat -l Logical logs not backed up : Minor threshould breached !!' -r $mailid

                                                                                                                if [ $TTWOS_AKTIV = "1" ]; then

                                                                                                                        #TITLE="The logical logs are not getting backup for Informix."
                                                                                                                        #MSG="Logical logs not backed up for $INFORMIXSERVER.Minor threshold breached."

                                                                                                                        #ssh -o ConnectTimeout=25 adbm@adeoas01s "/home/adbm/prod/Informix/create_ttwos_ticket.sh $SEVERITY_logical_log_low $TITLE $MSG" 2>/dev/null
                                                                                                                        #ssh adbm@adeoas01s "echo "NEW:$SEVERITY_logical_log_low:$TITLE:$MSG" >> /home/adbm/prod/Informix/ticket.catlog" 2>/dev/null

                                                                                                                        get_noc_timestamp
                                                                                                                        MSG="Logical Logs are not saved."
                                                                                                                        ssh adbm@adeoas01s "echo '$NOCtime;Minor;$INFORMIXSERVER;$MSG' >> /home/adbm/prod/Informix/NOC_DATA/tramo_monitor.log" 2>/dev/null

                                                                                                                fi


                                        else


                                                echo "First mail already sent. Minor threshold breached"


                                        fi
                        else

                                        echo "Logs not saved are  below 10 currently. "

                                        CHECK_WHAT_FLAG ol_temp_flag_critical $INFORMIXSERVER

                                        if [ "$FLAG_STATUS" != "CLEARED" ]; then

                                                reset_flag_date
                                                echo "Logical logs getting backed up : Set ol_temp_flag_critical to clear "
                                                echo "$flag_date#ol_temp_flag_critical#$INFORMIXSERVER#CLEARED" >> $WORKDIR/files/flags.txt

                                                ERR_MSG="CLEARED Check the output of onstat -l for $i instance , The logical logs getting backup now."
                                                echo $ERR_MSG | /usr/bin/mailx -s 'CLEARED Check the output of onstat -l for Informix instance , normal now.' -r $mailid



                                        fi

                                                if [ "$ol_temp_err_cnt_critical" -gt 0 ]; then

                                                                                                        let "ol_temp_err_cnt_critical = 0"
                                                                                                        echo "$ol_temp_err_cnt_critical" >$WORKDIR/files/err_cnt/$i/ol_temp_err_cnt_critical

                                                fi


                                        CHECK_WHAT_FLAG ol_temp_flag_medium $INFORMIXSERVER

                                        if [ "$FLAG_STATUS" != "CLEARED" ]; then



                                                reset_flag_date
                                                echo "Logical logs getting backed up : Set ol_temp_flag_medium to clear "
                                                echo "$flag_date#ol_temp_flag_medium#$INFORMIXSERVER#CLEARED" >> $WORKDIR/files/flags.txt

                                                ERR_MSG="CLEARED Check the output of onstat -l for $i instance , The logical logs getting backup now."
                                                echo $ERR_MSG | /usr/bin/mailx -s 'CLEARED Check the output of onstat -l for Informix instance , normal now.' -r $mailid

                                        fi

                                                                                if [ "$ol_temp_err_cnt_medium" -gt 0 ]; then

                                                let "ol_temp_err_cnt_medium = 0"
                                                echo "$ol_temp_err_cnt_medium" >$WORKDIR/files/err_cnt/$i/ol_temp_err_cnt_medium

                                                                                fi


                                        CHECK_WHAT_FLAG ol_temp_flag $INFORMIXSERVER
                                        if [ "$FLAG_STATUS" != "CLEARED" ]; then



                                                reset_flag_date
                                                echo "Logical logs getting backed up : Set ol_temp_flag to clear "
                                                echo "$flag_date#ol_temp_flag#$INFORMIXSERVER#CLEARED" >> $WORKDIR/files/flags.txt

                                                ERR_MSG="CLEARED Check the output of onstat -l for $i instance , The logical logs getting backup now."
                                                echo $ERR_MSG | /usr/bin/mailx -s 'CLEARED Check the output of onstat -l for Informix instance , normal now.' -r $mailid


                                        fi

                                                                                if [ "$ol_temp_err_cnt" -gt 0 ]; then

                                                let "ol_temp_err_cnt = 0"
                                                echo "$ol_temp_err_cnt" >$WORKDIR/files/err_cnt/$i/ol_temp_err_cnt

                                                                                fi



                        fi
  else
        echo "Time difference is more than 2 min."
    wl_temp="?"
    ol_temp="?"
    cl_temp="?"
  fi

  set_values $i checkLogBackups


done

}

function set_values
{

if [ "$1" = "rataktp1_vm" -a "$2" = "checkLogBackups"  ]; then

        wl_rataktp1=$wl_temp;
        ol_rataktp1=$ol_temp;
        cl_rataktp1=$cl_temp;

fi

if [ "$1" = "rataktp2_vm" -a "$2" = "checkLogBackups" ]; then

        wl_rataktp2=$wl_temp;
        ol_rataktp2=$ol_temp;
        cl_rataktp2=$cl_temp;

fi

if [ "$1" = "rataktp4_vm" -a "$2" = "checkLogBackups" ]; then

        wl_rataktp4=$wl_temp;
        ol_rataktp4=$ol_temp;
        cl_rataktp4=$cl_temp;

fi

if [ "$1" = "ratcalp2_vm" -a "$2" = "checkLogBackups" ]; then

        wl_ratcalp2=$wl_temp;
        ol_ratcalp2=$ol_temp;
        cl_ratcalp2=$cl_temp;

fi





#for oninit process

if [ "$1" = "rataktp1_vm" -a "$2" = "check_oninit_procs"  ]; then

        oi_rataktp1=$oi_temp;

fi

if [ "$1" = "rataktp2_vm" -a "$2" = "check_oninit_procs" ]; then

        oi_rataktp2=$oi_temp;

fi

if [ "$1" = "rataktp4_vm" -a "$2" = "check_oninit_procs" ]; then

        oi_rataktp4=$oi_temp;


fi

if [ "$1" = "ratcalp2_vm" -a "$2" = "check_oninit_procs" ]; then

        oi_ratcalp2=$oi_temp;


fi

#this if for function checkFullBackups

if [ "$1" = "act1" -a "$2" = "checkFullBackups" ]; then

        Begin_line_act1=$Begin_line_temp;
        End_line_act1=$End_line_temp;
        count_act1=$count_temp;
        count_err_act1=$count_err_temp;

fi

if [ "$1" = "act2" -a "$2" = "checkFullBackups" ]; then

        Begin_line_act2=$Begin_line_temp;
        End_line_act2=$End_line_temp;
        count_act2=$count_temp;
        count_err_act2=$count_err_temp;

fi

if [ "$1" = "act4" -a "$2" = "checkFullBackups" ]; then

        Begin_line_act4=$Begin_line_temp;
        End_line_act4=$End_line_temp;
        count_act4=$count_temp;
        count_err_act4=$count_err_temp;

fi

if [ "$1" = "cal2" -a "$2" = "checkFullBackups" ]; then

        Begin_line_cal2=$Begin_line_temp;
        End_line_cal2=$End_line_temp;
        count_cal2=$count_temp;
        count_err_cal2=$count_err_temp;

fi


if [ "$1" = "IFLOOP" -a "$2" = "checkLogBackups" ]; then

        Begin_line_act1=?;
        End_line_act1=?;
        count_act1=?;
        count_err_act1=?;

        Begin_line_act2=?;
        End_line_act2=?;
        count_act2=?;
        count_err_act2=?;

        Begin_line_act4=?;
        End_line_act4=?;
        count_act4=?;
        count_err_act4=?;

        Begin_line_cal2=?;
        End_line_cal2=?;
        count_cal2=?;
        count_err_cal2=?;

fi

#act1 act2 act4 cal2
#for function Calculate_time_difference

if [ "$1" = "act1" -a "$2" = "Calculate_time_difference" ]; then

exact_diff_act1=$exact_diff;

fi

if [ "$1" = "act2" -a "$2" = "Calculate_time_difference" ]; then

exact_diff_act2=$exact_diff;

fi

if [ "$1" = "act4" -a "$2" = "Calculate_time_difference" ]; then

exact_diff_act4=$exact_diff;

fi

if [ "$1" = "cal2" -a "$2" = "Calculate_time_difference" ]; then

exact_diff_cal2=$exact_diff;

fi



}

function CHECK_WHAT_FLAG
{

INFORMIXSERVER=$2
FLAG_STATUS=`cat $WORKDIR/files/flags.txt | grep "$1" | grep "$INFORMIXSERVER" | tail -1 | awk -F"#" '{print $5}'`


}

function reset_flag_date
{

flag_date=`date +"%Y-%m-%d#%H:%M:%S"`

}

function check_oninit_procs  {
  # Counting the Number of Virtual Procesors running on Informix Instances
  # Should always be 15 (may be a flexible configuration of these value is better)
  # Information is delivered by the script db_oninits.sh, running on tramo-pr1
  # Relevant Files : <Instance>.procs
  # File structure : YYYY-MM-DD hh:mm:ss;<number of running VP>

for i in rataktp1_vm rataktp2_vm rataktp4_vm ratcalp2_vm
do
  INFORMIXSERVER=$i
  CHECK_DATE=`cat $WORKDIR/files/$i.procs | cut -d ';' -f 1`
  compare_timestamp "$DATUM_LAUF" "$CHECK_DATE"
  RC=$?
  if [ $RC -eq 0 ]
  then
    oi_temp=`cat $WORKDIR/files/$i.procs | cut -d ';' -f 2`

        CHECK_WHAT_FLAG oi_temp_flag $INFORMIXSERVER
                oi_temp_err_cnt=`cat $WORKDIR/files/err_cnt/$i/oi_temp_err_cnt`

                if [ ${oi_temp} -lt 13 ]
                then
                #  how many times these has happened after another
                #  three times ?
                #  check if TTWOS is active
                #  Yes ? ==> write a row to the $NOCFILE with the following structure
                #    YYYYMMDDhhmmss;<Priority>;<Ifx-Instance>;<Error text>
                #echo "how many times these has happened after another in function check_oninit_procs"


                                        let "oi_temp_err_cnt = oi_temp_err_cnt + 1"
                                        echo "$oi_temp_err_cnt" >$WORKDIR/files/err_cnt/$INFORMIXSERVER/oi_temp_err_cnt

                                        if [ "$FLAG_STATUS" = "CLEARED" -a $oi_temp_err_cnt -eq $Monitor_attempt_oi_temp  ]; then

                                                reset_flag_date
                                                echo "$flag_date#oi_temp_flag#$INFORMIXSERVER#FIRSTMAILSENT" >> $WORKDIR/files/flags.txt
                                                ERR_MSG="Check the output of onstat -g glo for $i instance , the oninit process count is gone below 15."
                                                echo $ERR_MSG | /usr/bin/mailx -s 'Oninit proc below 15 : Critical threshold breached.' -r $mailid

                                                                                                if [ $TTWOS_AKTIV = "1" ]; then


                                                                                                        #TITLE="Oninit process count is gone below 15."
                                                                                                        #MSG="Oninit proc below 15 for $INFORMIXSERVER : Critical threshold breached . Raise priority to P1 if required."
                                                                                                        #ssh -o ConnectTimeout=25 adbm@adeoas01s "/home/adbm/prod/Informix/create_ttwos_ticket.sh $SEVERITY_oninit_proc $TITLE $MSG" 2>/dev/null

                                                                                                        get_noc_timestamp
                                                                                                        MSG="DB-Server is down."
                                                                                                        ssh adbm@adeoas01s "echo '$NOCtime;Major;$INFORMIXSERVER;$MSG' >> /home/adbm/prod/Informix/NOC_DATA/tramo_monitor.log" 2>/dev/null

                                                                                                fi

                                        else

                                                echo "Did not found FLAG_STATUS as CLEARED. Mail is already sent for oninit proc count , in function check_oninit_procs."

                                        fi


                else

                                        if [ "$FLAG_STATUS" != "CLEARED" ]; then


                                                        reset_flag_date
                                                        echo "oi_temp is within threshold : Set oi_temp_flag to clear "
                                                        echo "$flag_date#oi_temp_flag#$INFORMIXSERVER#CLEARED" >> $WORKDIR/files/flags.txt

                                                        ERR_MSG="CLEARED Check the output of onstat -g glo for $i instance , the oninit process count is normal now."
                                                        echo $ERR_MSG | /usr/bin/mailx -s 'CLEARED Oninit proc count normal now.' -r $mailid



                                        fi

                                                                                if [ "$oi_temp_err_cnt" -gt 0 ]; then

                                                        let "oi_temp_err_cnt = 0"
                                                        echo "$oi_temp_err_cnt" >$WORKDIR/files/err_cnt/$i/oi_temp_err_cnt

                                                                                fi

                fi


  else

        echo "Time difference is more than 2 min."
    oi_temp="?"
  fi

                set_values $i check_oninit_procs

done

}

function compare_timestamp {
  month1=`echo $1 | cut -d '-' -f 2`
  month2=`echo $2 | cut -d '-' -f 2`
  day1=`echo $1 | cut -d '-' -f 3 | cut -d ' ' -f1`
  day2=`echo $2 | cut -d '-' -f 3 | cut -d ' ' -f1`
  hour1=`echo $1 | cut -d ' ' -f 2 | cut -d ':' -f1`
  hour2=`echo $2 | cut -d ' ' -f 2 | cut -d ':' -f1`
  min1=`echo $1 | cut -d ' ' -f 2 | cut -d ':' -f2`
  min2=`echo $2 | cut -d ' ' -f 2 | cut -d ':' -f2`

  #hour=${hour#0}

month1=${month1#0}
month2=${month2#0}
day1=${day1#0}
day2=${day2#0}
hour1=${hour1#0}
hour2=${hour2#0}
min1=${min1#0}
min2=${min2#0}

#echo "${month1#0} is month1"
#echo "${month2#0}  is month2"
#echo "${day1#0}    is day1"
#echo "${day2#0}    is day2"
#echo "${hour1#0}   is hour1"
#echo "${hour2#0}   is hour2"
#echo "${min1#0}    is min1"
#echo "${min2#0}    is min2"

        if [ ${min2#0} -eq ${min1#0} ]
        then
                        min1=`expr $min2 + 1`
                fi
diff=$(( min1 - min2 ))
#echo "$diff is diff"
#echo "${diff#0} is another diff"

declare i two=2
  #if [[ ${vara#0} -lt ${varb#0} ]]

  if [ ${month1#0} -eq ${month2#0} ]
  then
    if [ ${day1#0} -eq ${day2#} ]
    then
      if [ ${hour1#} -eq ${hour2#} ]
      then
                let diff=$(( min1 - min2 ))
        if [ ${diff#0} -le ${two} ]
        then
          let "retval = 0"
        else
          let "retval = 1"
        fi
      else
        let "retval = 2"
      fi
    else
      let "retval = 3"
    fi
  else
    let "retval = 4"
  fi
  return $retval
}


RUNNING_SINCE_DATE==`date +"%d.%m.%y  %H:%M:%S"`

while true
do




WORKDIR=/opt/informix/ifxmonitor
echo "0" > $WORKDIR/files/managment_report_flag

  ClearVar
  cd $WORKDIR/scripts/



#Generate process files in below scripts.

  $WORKDIR/scripts/db_fullbackup.sh
  $WORKDIR/scripts/db_logs_logical_backup.sh
  $WORKDIR/scripts/db_oninits_new.sh
  $WORKDIR/scripts/db_logs_info.sh


#Processing of all files generated.

echo "===Script generate_html_per_instance.sh Started ....==="
date
echo "======"
echo "======"
  $WORKDIR/scripts/generate_html_per_instance.sh
date
echo "======"
echo "======"
echo "===Script generate_html_per_instance.sh End....==="


. /opt/informix/ifxmonitor/scripts/config_ifxmonitor.sh

  if [ $DO_YOU_WANT_TO_EXIT = "Y" ]; then
     echo "You Opted to exit the script execution."
         exit 0
  fi

  DATUM_LAUF=`date +"%Y-%m-%d  %H:%M:%S"`
  startsec=`$WORKDIR/scripts/getsec.perl`
  if [ $DEBUG = Y ]
  then
    echo "Starting !" > $DEBUGLOG
    date >> $DEBUGLOG
  fi

  checkLogBackups
  if [ $DEBUG = Y ]
  then
    echo "checkLogBackups finished" >> $DEBUGLOG
    date >> $DEBUGLOG
  fi
  checkFullBackups
  if [ $DEBUG = Y ]
  then
    echo "checkFullBackups finished" >> $DEBUGLOG
    date >> $DEBUGLOG
  fi
  check_oninit_procs
  if [ $DEBUG = Y ]
  then
    echo "check_oninit_procs finished" >> $DEBUGLOG
    date >> $DEBUGLOG
  fi
  write_html
  if [ $DEBUG = Y ]
  then
    echo "Write_html finished !" >> $DEBUGLOG
    date >> $DEBUGLOG
  fi
  endsec=`$WORKDIR/scripts/getsec.perl`

  #send the file to sylt3

  scp $WORKDIR/files/ifxReport.html adbm@adeoas01s:/home/adbm/prod/webdata/htdocs/informix/webportal

   abbrechen=`date +%H%M`
 ## Nach 23:50 Uhr werden die Prozesse des Logmonitors beendet
 if [ $abbrechen -gt $Stop_executing_time ]
 then
   date
   echo "Time to say goodby..."
   exit 0
 fi

echo "1" > $WORKDIR/files/managment_report_flag

  let "LOOPTIME = 120 - ( endsec - startsec )"
  sleep $LOOPTIME


done



