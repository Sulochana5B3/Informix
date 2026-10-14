 cat /opt/informix/ifxmonitor/scripts/table_data_growth_report.sh
#!/bin/bash

WORKDIR=/opt/informix/ifxmonitor

/opt/informix/ifxmonitor/scripts/data_report.sh > $WORKDIR/files/tmp.txt
cat $WORKDIR/files/tmp.txt | tr -d ' ' | sed 's/(expression)//' | grep -v '^ *$' > $WORKDIR/files/weekly_table_growth_dump.txt

#append the data to one single file
cat $WORKDIR/files/weekly_table_growth_dump.txt >> $WORKDIR/files/Complete_table_growth_dump.txt

#(uuencode $WORKDIR/files/weekly_table_growth_dump.txt weekly_table_growth_dump.txt;uuencode $WORKDIR/files/Complete_table_growth_dump.txt Complete_table_growth_dump.txt) | mailx -s "Informix Table growth dump." DL-TSSC-OSLO-ADBA@vodafone.com



mailfrom="adetrmdb1.de-monitoring@dc-ratingen.de"
mailid="dl-tssc-adba-central-alert@vodafone.com"
mailid1="juergen.grosch@vodafone.com"
(uuencode $WORKDIR/files/weekly_table_growth_dump.txt weekly_table_growth_dump.txt;
uuencode $WORKDIR/files/Complete_table_growth_dump.txt Complete_table_growth_dump.txt) | mailx -r $mailfrom -s "ALERT-DE-INFORMIX-Table-Growth-Report." $mailid $mailid1
