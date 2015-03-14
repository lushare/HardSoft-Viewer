#!/bin/bash
##########################################################
#  This Script For Get HardSoft Information To MySQL　　＃
##########################################################
LC_ALL=C
HSVDIR=/data/hardfile
TMPDIR=/data/tmp
BAKDIR=/data/hdbak
[ ! -d $TMPDIR ] && mkdir -p $TMPDIR
[ ! -d $BAKDIR ] && mkdir -p $BAKDIR
MYSQLBIN='/usr/bin/mysql'
DBHOST='localhost'
DBUSER='HardSoft'
DBPWD='HardSoft-Viewer'
mysql="$MYSQLBIN -h$DBHOST -u$DBUSER -p$DBPWD -e "
db=HardSoft
for file in `ls $HSVDIR`
do
cp -f $HSVDIR/$file $BAKDIR
lang=`grep "Language:" $HSVDIR/$file|awk -F':' '{print $2}'`
iconv -f $lang -t utf-8 -o $HSVDIR/$file $HSVDIR/$file
#name=$file
name=`grep 'Computer Name' $HSVDIR/$file|awk -F' = ' '{print $2}'|tr -d '\n\r'`
os=`grep "OS       Type" $HSVDIR/$file|grep "Type"|awk -F'=' '{print $2}'|sed 's#(.*)##g'|tr -d '\n\r'`
cpu=`grep "CPU" $HSVDIR/$file|awk -F'=' '{print $2}'|tr -d '\n\r'`
model=`grep "System  Model" $HSVDIR/$file|awk -F'=' '{print $2}'|tr -d '\n\r'`
#get RAM
ram=`grep "RAM      Size" $HSVDIR/$file|awk -F'=' '{print $2}'|sed 's# RAM##g'||tr -d '\n\r'`
#get DisplayCard
display=`grep "Display  Card" $HSVDIR/$file|awk -F'=' '{print $2}'|tr -d '\n\r'`
#get MotherBoard
mf=`grep "Manufacturer" $HSVDIR/$file|awk -F'=' '{print $2}'|tr -d '\n\r'`
mb=`grep "MotherBoard Model" $HSVDIR/$file|awk -F'=' '{print $2}'|tr -d '\n\r'`
#get Hard Information
starthd=`grep -n "Hard Disk:" $HSVDIR/$file|awk -F':' '{print $1}'`
endhd=`grep -n "Network Card:" $HSVDIR/$file|awk -F':' '{print $1}'`
#hdinfo=`awk "NR==$starthd+1,NR==$endhd-1 {print}" $HSVDIR/$file`
#hd=`echo $hdinfo |awk -F'=' '{print $2}'|awk '{print $1}'`
#echo $hdinfo
#hd=`grep "Model" $hdinfo |awk -F'=' '{print $2}'|sed 's/Size//g'|tr -d '\n\r' `
hd=`awk "NR==$starthd+1,NR==$endhd-1 {print}" $HSVDIR/$file|grep "Model"|awk -F'=' '{print $2}'|sed 's#\r\r##g'`
#hd=`echo $hdinfo |sed 's/Size//g' `
size=`awk "NR==$starthd+1,NR==$endhd-1 {print}" $HSVDIR/$file|grep "Size"|awk -F'=' '{print $2}'|sed 's#\r\r##g'`
#size=`grep "Size" $hdinfo |awk -F'=' '{print $2}'|tr -d '\n\r'`
 
#get Network
net=`grep "NetCard Model" $HSVDIR/$file|awk -F'=' '{print $2}'|tr -d '\n\r'`
mac=`grep "MAC Address" $HSVDIR/$file|awk -F'=' '{print $2}'|tr -d '\n\r'`
ip=`grep "IP Address" $HSVDIR/$file|awk -F'=' '{print $2}'|sed 's/(.*)//g'|tr -d '\n\r'`
#ip=`cat $HSVDIR/$file |grep "IP Address"|awk -F'=' '{print $2}'|sed 's/(.*)//g'|sed 's#\n\r##g'`
#echo $ip
#Check Hardware Table
hunum=`$mysql "select count(*) from $db.Hardware where id='$name'"`
hnum=`echo $hunum|awk '{print $2}'`
[ $hnum -ne 0 ] && $mysql "delete from $db.Hardware where id='$name'"
#Insert Hardware Data
$mysql "insert into $db.Hardware(id,ScanTime,OS,CPU,Computer_Type,Ram,Display_Card,MotherBoard_Vendor,MotherBoard_Type,HardDisk_Type,HardDisk_Size,NetCard_Type,Mac_Address,IP_Address) values (trim('$name'),now(),trim('$os'),trim('$cpu'),trim('$model'),trim('$ram'),trim('$display'),trim('$mf'),trim('$mb'),trim('$hd'),trim('$size'),trim('$net'),trim('$mac'),trim('$ip'))"
######################################################################
#get Software
startsw=`grep -n "Software Information:" $HSVDIR/$file|awk -F':' '{print $1}'`
endsw=`grep -n "USB Information:" $HSVDIR/$file|awk -F':' '{print $1}'`
#Check Software Table
sunum=`$mysql "select count(*) from $db.Software where id='$name'"`
snum=`echo $sunum|awk '{print $2}'`
[ $snum -ne 0 ] && $mysql "delete from $db.Software where id='$name'"
#get Software & Insert Software Data
awk "NR==$startsw+1,NR==$endsw-1 {print}" $HSVDIR/$file| sed -e '/^$/d' | sed  "s/'//g" |sed 's#^\s##g'|while read line
do
soft=`echo $line|tr -d '\n\r'`
$mysql "insert into $db.Software(id,ScanTime,SoftName) values('$name',now(),trim('$soft'))"
done
#######################################################################
#get USB
usb=`grep 'USB is Open' $HSVDIR/$file|wc -l`
#get Admins
startad=`grep -n "Admin Users:" $HSVDIR/$file|awk -F':' '{print $1}'`
endad=`grep -n "Power Users:" $HSVDIR/$file|awk -F':' '{print $1}'`
ad=`awk "NR==$startad+1,NR==$endad-1 {print}" $HSVDIR/$file | sed -e '/^$/d'|sed '/Administrator/d'|sed '/Domain Admins/d'`
#get PowerUser
startpw=`grep -n "Power Users:" $HSVDIR/$file|awk -F':' '{print $1}'`
endpw=`grep -n "FileShare Information:" $HSVDIR/$file|awk -F':' '{print $1}'`
pw=`awk "NR==$startpw+1,NR==$endpw-1 {print}" $HSVDIR/$file | sed -e '/^$/d'`
#Check Access Table
aunum=`$mysql "select count(*) from $db.Control where id='$name'"`
anum=`echo $aunum|awk '{print $2}'`
[ $anum -ne 0 ] && $mysql "delete from $db.Control where id='$name'"
#Insert Access Data
$mysql "insert into $db.Control(id,ScanTime,Admin,Poweruser,Usb) values('$name',now(),trim('$ad'),trim('$pw'),trim('$usb'))"
######################################################################
#Check User Table & Insert ID
unum=`$mysql "select count(*) from $db.Computers where Computers.id='$name'"`
num=`echo $unum|awk '{print $2}'`
[ $num -eq 0 ] && $mysql "insert into $db.Computers(id) values('$name')"
######################################################################
mv $HSVDIR/$file $TMPDIR
done

