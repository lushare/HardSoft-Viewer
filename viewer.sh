#!/bin/bash
##########################################################
#  This Script For Get HardSoft Information To MySQL　　＃
##########################################################
#[ `ps aux|grep $0 |grep -v grep|wc -l` -gt 2 ] && echo "Running...." && exit 0
LOCK=/var/lock/subsys/viewer.lock
[ -f $LOCK ] && {
	echo "$(date +'%Y-%m-%d %H:%M:%S') Running..."
	echo "1">>$LOCK
	[ `awk 'END{print NR}' $LOCK` -gt 20 ] && rm -f $LOCK 
	exit 0
}
touch $LOCK
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
db='HardSoft'
mysql="$MYSQLBIN -h$DBHOST -u$DBUSER -p$DBPWD -e "
$mysql "USE $db" >/dev/null 2>&1
[ $? -ne 0 ] && echo "MySQL Error or Not Exist Database" && rm -f $LOCK && exit 1
for file in `ls $HSVDIR`
do
if [ `grep "Scan Over" $HSVDIR/$file|wc -l` -eq 1 ];then
cp -f $HSVDIR/$file $BAKDIR

[ `file $HSVDIR/$file|grep 'UTF-8'|wc -l` -ne 0 ] || {
lang=`grep "Language:" $HSVDIR/$file|awk -F':' '{print $2}'`
iconv -f $lang -t utf-8 -o $HSVDIR/$file $HSVDIR/$file
}

#name=$file
name=`grep 'Computer Name' $HSVDIR/$file|awk -F' = ' '{print $2}'|tr -d '\n\r'|awk '{gsub(/ /,"")}1'`
os=`grep "OS       Type" $HSVDIR/$file|grep "Type"|awk -F'=' '{print $2}'|sed 's#(.*)##g'|tr -d '\n\r'`
cpu=`grep "CPU" $HSVDIR/$file|awk -F'=' '{print $2}'|tr -d '\n\r'`
model=`grep "System  Model" $HSVDIR/$file|awk -F'=' '{print $2}'|tr -d '\n\r'`
#get DisplayCard
startdisplay=`grep -n "DisplayCard:" $HSVDIR/$file|awk -F':' '{print $1}'`
enddisplay=`grep -n "Mother Board:" $HSVDIR/$file|awk -F':' '{print $1}'`
display=`awk "NR==$startdisplay+1,NR==$enddisplay-1 {print}" $HSVDIR/$file|grep "Caption="|awk -F'=' '{print $2}'|tr -d '\n\r'`
#display=`grep "Display  Card" $HSVDIR/$file|awk -F'=' '{print $2}'|tr -d '\n\r'`
#get Ram
startram=`grep -n "RAM:" $HSVDIR/$file|awk -F':' '{print $1}'`
endram=`grep -n "System Information:" $HSVDIR/$file|awk -F':' '{print $1}'`
ramsize=`awk "NR==$startram+1,NR==$endram-1 {print}" $HSVDIR/$file|grep -i -e 'EndingAddress' -e 'TotalPhysicalMemory'|awk -F'=' '{print $2}'|sort -r|head -1`
ramsum=`awk 'BEGIN{printf "%.0f\n",'$ramsize'/1024/256}'`
ram=`awk 'BEGIN{printf "%.0f\n",'$ramsum'*256}'|sed 's/.*/&MB/'`
#for((i=1;i<=$ramsum;i++))
#do
#ramarray[$i]=`grep -i -e 'Capacity' -e 'TotalPhysicalMemory' $HSVDIR/$file|sed -n "${i}p"|awk -F'=' '{print $2}'|tr -d '\n\r'`
#done
#rsum=0
#for i in "${ramarray[@]}"
#do
#        let "rsum=$i+$rsum"
#done
#if [ `grep  'Capacity'  $HSVDIR/$file|wc -l` -ne 0 ];then
#ram=`awk 'BEGIN{printf "%.0f\n",'$rsum'/1024/1024}'`
#elif [ `grep   'TotalPhysicalMemory'  $HSVDIR/$file|wc -l` -ne 0 ];then
#ram=`awk 'BEGIN{printf "%.0f\n",'$rsum'/1024}'`
#else
#ram='error'
#fi
####################################################################
#get MotherBoard
mf=`grep "Manufacturer" $HSVDIR/$file|awk -F'=' '{print $2}'|tr -d '\n\r'`
mb=`grep "Product=" $HSVDIR/$file|awk -F'=' '{print $2}'|tr -d '\n\r'`
####################################################################
#get Hard Information
starthd=`grep -n "Hard Disk:" $HSVDIR/$file|awk -F':' '{print $1}'`
endhd=`grep -n "Network Card:" $HSVDIR/$file|awk -F':' '{print $1}'`

hdsum=`awk "NR==$starthd+1,NR==$endhd-1 {print}" $HSVDIR/$file|grep "Model"|wc -l`
if [[ $hdsum -eq 1 ]];then
hd=`awk "NR==$starthd+1,NR==$endhd-1 {print}" $HSVDIR/$file|grep "Model"|awk -F'=' '{print $2}'|tr -d '\n\r'`
hdsize=`awk "NR==$starthd+1,NR==$endhd-1 {print}" $HSVDIR/$file|grep "Size"|awk -F'=' '{print $2}'|tr -d '\n\r'`
size=`awk 'BEGIN{printf "%.0f\n",'$hdsize'/1000/1000/1000}'|sed 's/.*/&GB/'`
elif [[ $hdsum -gt 1 ]];then
for((i=1;i<=$hdsum;i++))
do
harddisk[$i]=`awk "NR==$starthd+1,NR==$endhd-1 {print}" $HSVDIR/$file|grep "Model"|sed -n "${i}p"|awk -F'=' '{print $2}'|sed 's#\r\r##g'`
hardsize_one[$i]=`awk "NR==$starthd+1,NR==$endhd-1 {print}" $HSVDIR/$file|grep "Size"|sed -n "${i}p"|awk -F'=' '{print $2}'|sed 's#\r\r##g'`
hardsize[$i]=`awk 'BEGIN{printf "%.0f\n",'${hardsize_one[$i]}'/1000/1000/1000}'|sed 's/.*/&GB/'`
done
hd=`echo ${harddisk[*]}`
size=`echo ${hardsize[*]}|sed 's# #/#g'`
else
hd='NULL'
size=0
fi
#################################################################3
# Work For LENOVO Machine
if [[ `echo $mb|grep -i -e 'O.E.M.' -e 'LENOVO' -e 'LEGEND' |wc -l` -eq 1 ]] && [[ `echo $display|grep -i -e 'Intel'|wc -l` -eq 1 ]];then
	motherb=`echo $display|awk '{print $1,$2}'`
elif [[ `echo $model|grep -i -e 'QiTianM71' -e 'ThinkCentre M6'|wc -l` -eq 1 ]];then
	motherb='Intel(R) G41'
else
	motherb=$mb
fi

######################################################################
#get Network
#net=`grep "NetCard Model" $HSVDIR/$file|awk -F'=' '{print $2}'|tr -d '\n\r'`
#mac=`grep "MAC Address" $HSVDIR/$file|awk -F'=' '{print $2}'|tr -d '\n\r'`
#ip=`grep "IP Address" $HSVDIR/$file|awk -F'=' '{print $2}'|sed 's/(.*)//g'|tr -d '\n\r'`
startnet=`grep -n "Network Card:" $HSVDIR/$file|awk -F':' '{print $1}'`
endnet=`grep -n "Software Information:" $HSVDIR/$file|awk -F':' '{print $1}'`
nettype=`awk "NR==$startnet+1,NR==$endnet-1 {print}" $HSVDIR/$file|grep 'NetCard Model \|MAC Address \|IP Address'|wc -l`
if [ $nettype -gt 0  ];then
net=`grep "NetCard Model" $HSVDIR/$file|awk -F'=' '{print $2}'|awk 'NF>0'|tr -d '\n\r'`
mac=`grep "MAC Address" $HSVDIR/$file|awk -F'=' '{print $2}'|awk 'NF>0'|tr -d '\n\r'|sed 's/^\s*//g'|sed 's# #/#g'`
ip=`grep "IP Address" $HSVDIR/$file|awk -F'=' '{print $2}'|sed 's/(.*)//g'|awk 'NF>0'|tr -d '\n\r'`
else
net=`awk "NR==$startnet+1,NR==$endnet-1 {print}" $HSVDIR/$file|grep '\]'|sed -r 's/\[[^]]\] | ([0-9A-F]{2}[:]?){6}//'|awk -F']' '{print $2}'`
macsum=`awk "NR==$startnet+1,NR==$endnet-1 {print}" $HSVDIR/$file|grep '\]'|wc -l`
for((i=1;i<=$macsum;i++))
do
#awk "NR==$startnet+1,NR==$endnet-1 {print}" $HSVDIR/$file|grep '\]'|sed -n "${i}p"|tr -d '\r'|awk '{print $NF}'
macarray[$i]=`awk "NR==$startnet+1,NR==$endnet-1 {print}" $HSVDIR/$file|grep '\]'|sed -n "${i}p"|tr -d '\r'|awk '{print $NF}'|awk -F':' '{if(NF==6)print}'`
done
mac=`echo ${macarray[*]}|sed 's# #/#g'`
ip=`awk "NR==$startnet+1,NR==$endnet-1 {print}" $HSVDIR/$file|grep '{'|awk -F\" '{for(i=0;i++<NF;){$i!~/^[0-9.]+$/?$i="":1}}1'`
fi
######################################################################
#Check Hardware Table
#hunum=`$mysql "select count(*) from $db.Hardware where id='$name'"`
#hnum=`echo $hunum|awk '{print $2}'`
#[ $hnum -ne 0 ] && $mysql "delete from $db.Hardware where id='$name'"
$mysql "delete from $db.Hardware where id='$name'"
#Insert Hardware Data
$mysql "insert into $db.Hardware(id,ScanTime,OS,CPU,Computer_Type,Ram,Display_Card,MotherBoard_Vendor,MotherBoard_Type,HardDisk_Sum,HardDisk_Type,HardDisk_Size,NetCard_Type,Mac_Address,IP_Address) values ('$name',now(),trim('$os'),trim('$cpu'),trim('$model'),trim('$ram'),trim('$display'),trim('$mf'),trim('$motherb'),'$hdsum',trim('$hd'),trim('$size'),trim('$net'),trim('$mac'),trim('$ip'))"
######################################################################
#get Software
startsw=`grep -n "Software Information:" $HSVDIR/$file|awk -F':' '{print $1}'`
endsw=`grep -n "USB Information:" $HSVDIR/$file|awk -F':' '{print $1}'`
#Check Software Table
#sunum=`$mysql "select count(*) from $db.Software where id='$name'"`
#snum=`echo $sunum|awk '{print $2}'`
#[ $snum -ne 0 ] && $mysql "delete from $db.Software where id='$name'"
$mysql "delete from $db.Software where id='$name'"
#get Software & Insert Software Data
awk "NR==$startsw+1,NR==$endsw-1 {print}" $HSVDIR/$file| sed  "s/'//g" |sed 's#^\s##g'|awk 'NF>0'|while read line
do
soft=`echo $line|sed '/^$/d'|tr -d '\n\r'`
$mysql "insert into $db.Software(id,ScanTime,SoftName) values('$name',now(),trim('$soft'))"
done
#######################################################################
#get USB
usb=`grep 'USB is Open' $HSVDIR/$file|wc -l`
#######################################################################
#get Admins
startad=`grep -n "Admin Users:" $HSVDIR/$file|awk -F':' '{print $1}'`
endad=`grep -n "Power Users:" $HSVDIR/$file|awk -F':' '{print $1}'`
ad=`awk "NR==$startad+1,NR==$endad-1 {print}" $HSVDIR/$file|sed '/Administrator/d'|sed '/Domain Admins/d'|awk 'NF>0'|tr -d '\n\r'`
#######################################################################
#get PowerUser
startpw=`grep -n "Power Users:" $HSVDIR/$file|awk -F':' '{print $1}'`
endpw=`grep -n "Scan Over" $HSVDIR/$file|awk -F':' '{print $1}'`
pw=`awk "NR==$startpw+1,NR==$endpw-1 {print}" $HSVDIR/$file |awk 'NF>0'|tr -d '\n\r'`
#Check Access Table
#aunum=`$mysql "select count(*) from $db.Control where id='$name'"`
#anum=`echo $aunum|awk '{print $2}'`
#[ $anum -ne 0 ] && $mysql "delete from $db.Control where id='$name'"
$mysql "delete from $db.Control where id='$name'"
#Insert Access Data
$mysql "insert into $db.Control(id,ScanTime,Admin,Poweruser,Usb) values('$name',now(),trim('$ad'),trim('$pw'),trim('$usb'))"
######################################################################
#getShare
startsh=`grep -n "FileShare Information:" $HSVDIR/$file|awk -F':' '{print $1}'`
endsh=`grep -n "RAM:" $HSVDIR/$file|awk -F':' '{print $1}'`
#shnum=`$mysql "select count(*) from $db.Share where id ='$name'"`
#snum=`echo $shnum|awk '{print $2}'`
#[ $snum -ne 0 ] && $mysql "delete from $db.Share where id ='$name'"
$mysql "delete from $db.Share where id ='$name'"
awk "NR==$startsh+1,NR==$endsh-1 {print}" $HSVDIR/$file|tr -d '\r'|grep -v 'IPC\$'|awk 'NF>0'|while read -r line
do
share=`echo $line|tr -d '\n\r'|sed 's/\\\\/\\\\\\\\/g'`
$mysql "insert into $db.Share(id,Share) values('$name',trim('$share'))"
done
######################################################################
#Check User Table & Insert ID
unum=`$mysql "select count(*) from $db.Computers where Computers.id='$name'"`
num=`echo $unum|awk '{print $2}'`
[ $num -eq 0 ] && $mysql "insert into $db.Computers(id) values('$name')"
######################################################################
mv $HSVDIR/$file $TMPDIR
#rm -f $HSVDIR/$file
fi
done

rm -f $LOCK
exit 0
