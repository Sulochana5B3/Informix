#!/bin/bash
# Management report for rataktp1_vm only
WORKDIR=/opt/informix/ifxmonitor
logical_log_not_backup_critical_threshould=60
logical_log_not_backup_medium_threshould=35
logical_log_not_backup_lower_threshould=10
INSTANCE=rataktp1_vm

# This script is a reduced version of original monitoring script
# Reports only rataktp1_vm.

execute_report(){
rataktp1_count=$(cat $WORKDIR/files/err_cnt/${INSTANCE}/oi_temp_err_cnt 2>/dev/null)
[ -z "$rataktp1_count" ] && rataktp1_count=1

if [ $rataktp1_count -eq 0 ]; then
  rataktp1_status=UP
else
  rataktp1_status=DOWN
fi

Full_bkp_rataktp1_count=$(cat $WORKDIR/files/bar_act1.log.backup 2>/dev/null | wc -l)
if [ $Full_bkp_rataktp1_count -ge 2 ]; then
  FullBackup=DONE
else
  FullBackup=NOT_DONE
fi

ol_temp=$(cut -d ';' -f3 $WORKDIR/files/${INSTANCE}.logs.2 2>/dev/null)
[ -z "$ol_temp" ] && ol_temp=0

if [ $ol_temp -gt $logical_log_not_backup_critical_threshould ]; then
   LogicalLog=CRITICAL
elif [ $ol_temp -gt $logical_log_not_backup_medium_threshould ]; then
   LogicalLog=MAJOR
elif [ $ol_temp -gt $logical_log_not_backup_lower_threshould ]; then
   LogicalLog=MINOR
else
   LogicalLog=OK
fi

space_per=$(df -h /opt/informix | tail -1 | awk '{print $5}')

log_error_cnt=$(grep $(date +%m/%d/%y) /opt/informix/IDS/14.10.12/tmp/online.log.${INSTANCE} 2>/dev/null | grep -i error | wc -l)

ov_lock=$(cat $WORKDIR/files/onstat.p.${INSTANCE} 2>/dev/null | tail -8 | head -1 | awk '{print $1}')
ov_buff=$(cat $WORKDIR/files/onstat.p.${INSTANCE} 2>/dev/null | tail -8 | head -1 | awk '{print $3}')
rollback=$(cat $WORKDIR/files/onstat.p.${INSTANCE} 2>/dev/null | head -10 | tail -1 | awk '{print $9}')
dbspace_free=$(cat $WORKDIR/files/onstat.d.${INSTANCE} 2>/dev/null | tail -10 | egrep 'data|root' | awk '{print $5}' | sort -rn | tail -1 | awk -F. '{print $1}')

cat <<EOF
=========================================
 Informix Monitoring Report
 Instance : ${INSTANCE}
=========================================
Status            : $rataktp1_status
Full Backup       : $FullBackup
Logical Log       : $LogicalLog
Filesystem Usage  : $space_per
Online Log Errors : $log_error_cnt
Overflow Locks    : $ov_lock
Overflow Buffers  : $ov_buff
Rollback Count    : $rollback
DBSpace Free %    : $dbspace_free
=========================================
EOF
}

execute_report
