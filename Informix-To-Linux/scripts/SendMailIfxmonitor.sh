cat /opt/informix/ifxmonitor/scripts/SendMailIfxmonitor.sh
#!/bin/ksh
#===================================================================================
#
# FILE        : SendMailIfxmonitor.sh
# USAGE       : sh SendMailIfxmonitor.sh
# DESCRIPTION : This script is used to send Informix report on mail.
# OPTIONS     :  ---
# REQUIREMENTS:  ---
# NOTES       : Rollback and Error handling is not required
# AUTHOR      : Sagar Linge
# COMPANY     : Vodafone Shared Services India
# VERSION     : 05/11/2018
# CREATED     : 05/11/2018    Initial Version
# REVISION    :
#
#====================================================================================

basedir=/opt/informix/ifxmonitor/
webdir=/opt/informix/ifxmonitor/files
#webdir=/opt/informix/ifxmonitor/scripts
cd $webdir

mailfrom="adetrmdb1.de-monitoring@dc-ratingen.de"
mailid="dl-tssc-adba-central-alert@vodafone.com"
mailid1="juergen.grosch@vodafone.com"

ifxReport_size=""
rataktp1_size=""
rataktp2_size=""
rataktp4_size=""


function checkfilesize
{

        ifxReport_size=$(wc -c <"$webdir/ifxReport.html")
        rataktp1_size=$(wc -c <"$webdir/rataktp1_vm.html")
        rataktp2_size=$(wc -c <"$webdir/rataktp2_vm.html")
        rataktp4_size=$(wc -c <"$webdir/rataktp4_vm.html")
        ratcalp2_size=$(wc -c <"$webdir/ratcalp2_vm.html")

        if [ $ifxReport_size -gt 7000 -a $rataktp1_size -gt 7000 -a $rataktp2_size -gt 7000 -a  $rataktp4_size -gt 7000 -a  $ratcalp2_size -gt 7000  ]; then

                                cat $webdir/ifxReport.html | grep "?"
                                if [ $? -ne 0 ];then



(uuencode ifxReport.html ifxReport.html; uuencode rataktp1_vm.html rataktp1_vm.html ; uuencode rataktp2_vm.html rataktp2_vm.html ; uuencode rataktp4_vm.html rataktp4_vm.html ; uuencode ratcalp2_vm.html ratcalp2_vm.html) | mailx -r $mailfrom -s "ALERT-DE-INFORMIX-Monitoring-Report" Juergen.Grosch@vodafone.com ,dl-tssc-adba-central-alert@vodafone.com

#(uuencode ifxReport.html ifxReport.html; uuencode rataktp1_vm.html rataktp1_vm.html ; uuencode rataktp2_vm.html rataktp2_vm.html ; uuencode rataktp4_vm.html rataktp4_vm.html ; uuencode ratcalp2_vm.html ratcalp2_vm.html)  | mailx -r $mailfrom -s "ALERT-DE-INFORMIX-Monitoring-Report." $mailid $mailid1


                                         echo "Mail has been sent successfully "
                                        exit 0;
                                else

                                       echo "? found in file ifxReport.html"

                                fi


        else

                break;
                echo "file size is less than 7KB"


        fi


}

while true; do

        checkfilesize
        sleep 20

done

