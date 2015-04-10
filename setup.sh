#!/bin/bash
#檢查是否超級用戶權限
echo "準備安裝HardSoft-Viewer服務端，請按提示進行操作"
if [ $UID != 0 ];then
echo "必須使用超級管理員權限運行此腳本"
exit 1;
fi
[ `cat /etc/redhat-release |grep '6.'|wc -l` -ne 1 ] && {
	echo "請使用CentOS 6以上系統"
	exit 1;
}
#[ `uname -r|grep x86_64|wc -l` -ne 1 ] && {
#	echo "請使用64位操作系統"
#	exit 1;
#}
#关闭SELinux
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux 
setenforce 0 >/dev/null 2>&1
#關閉防火牆
/etc/init.d/iptables stop;chkconfig iptables off
yum -y install ntpdate >/dev/null 2>&1
touch /var/spool/cron/root >/dev/null 2>&1
[ `grep '/sbin/ntpdate' /var/spool/cron/root|wc -l` -eq 0 ] && {
echo "*  */2  *  *  * /sbin/ntpdate time.nist.gov" >> /var/spool/cron/root
}


setup_samba()
{
echo "開始安裝並配置Samba..."
yum -y install samba samba-common samba-client >/dev/null 2>&1
[ $? -ne 0 ] && {
	echo "yum安裝samba失敗，請檢查網絡"
	exit 2
}
cp /etc/samba/smb.conf /etc/samba/smb.conf_default >/dev/null 2>&1
[  -d '/data/hardfile' ] || mkdir -p /data/hardfile
[  -d '/data/hardclient' ] || mkdir -p /data/hardclient
[ `grep 'hardsoft' /etc/group |wc -l` -eq 0 ] && groupadd hardsoft
[ `grep 'asc' /etc/passwd|wc -l` -eq 0 ] && useradd -g hardsoft -s /sbin/nologin -d /data/hardfile asc >/dev/null 2>&1
chmod 755 /data/hardfile
chown asc.hardsoft /data/hardfile
chmod 755 /data/hardclient
chown asc.hardsoft /data/hardclient

(echo asc;echo asc) | smbpasswd -a -s  asc
echo '* soft	nofile	65000'>>/etc/security/limits.conf
echo '* hard    nofile  65000'>>/etc/security/limits.conf
ulimit -SHn 65000
cat << EOF > /etc/samba/smb.conf
[global]
        dos charset = cp950
        unix charset = utf8
        display charset = utf8
        workgroup = YYII_ASC
        server string = HardSoft Viewer
        log file = /var/log/samba/log.%m
        max log size = 50
        load printers = No
        idmap config * : backend = tdb

[HardFile]
        comment = For HardSoft Viewer Result
        path = /data/hardfile
        write list = @hardsoft
        read only = No
        create mask = 0660
        directory mask = 0770
[Client]
        comment = For HardSoft Viewer Result
        path = /data/hardclient
        write list = @hardsoft
        read only = Yes
        create mask = 0660
        directory mask = 0770

EOF
/etc/init.d/nmb start >/dev/null 2>&1
if [ $? -eq 0 ];then
	echo "啟動nmb成功"
else
	echo "啟動nmb失敗"
fi
/etc/init.d/smb start >/dev/null 2>&1
if [ $? -eq 0 ];then
        echo "啟動smb成功"
else
        echo "啟動smb失敗"
fi
chkconfig nmb on
chkconfig smb on
echo "Samba安装并配置成功"
}

setup_ftp()
{
echo "開始安裝並配置vsftpd..."
yum -y install vsftpd >/dev/null 2>&1
[ $? -ne 0 ] && {
        echo "yum安裝vsftpd失敗，請檢查網絡"
        exit 2
}
cp /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf_default
[  -d '/data/hardfile' ] || mkdir -p /data/hardfile
[  -d '/data/hardclient' ] || mkdir -p /data/hardclient
[ `grep 'hardsoft' /etc/group |wc -l` -eq 0 ] && groupadd hardsoft
[ `grep 'asc' /etc/passwd|wc -l` -eq 0 ] && useradd -g hardsoft -s /sbin/nologin -d /data/hardfile asc >/dev/null 2>&1
chmod 755 /data/hardfile
chown asc.hardsoft /data/hardfile
chmod 755 /data/hardclient
chown asc.hardsoft /data/hardclient
echo asc | passwd --stdin asc >/dev/null 2>&1
#echo '* soft    nofile  65000'>>/etc/security/limits.conf
#echo '* hard    nofile  65000'>>/etc/security/limits.conf
ulimit -SHn 65000
sed -i 's#anonymous_enable=YES#anonymous_enable=NO#g' /etc/vsftpd/vsftpd.conf
/etc/init.d/vsftpd start >/dev/null 2>&1
if [ $? -eq 0 ];then
        echo "啟動vsftpd成功"
else
        echo "啟動vsftpd失敗"
fi
chkconfig vsftpd on
echo "vsftpd安装并配置成功"
}




setup_lamp()
{
echo "開始安裝MySQL資料庫軟體..."
yum -y install mysql-server mysql mysql-devel mysql-common>/dev/null 2>&1
[ $? -ne 0 ] && {
        echo "安裝MySQL失败，請檢查是否連接到Internet"
	exit 3;
}
echo "成功安裝資料庫，下面啟動資料庫";
sed -i -e '/user=mysql/a\character_set_server=utf8\ndefault-character-set=utf8' /etc/my.cnf
echo "[mysql]" >>/etc/my.cnf
echo "default-character-set=utf8" >>/etc/my.cnf
/etc/init.d/mysqld start >/dev/null 2>&1
[ $? -ne 0 ] && {
	echo "啟動MySQL失败，請查看錯誤日誌"
	exit 3;
}
echo "啟動資料庫成功"
chkconfig mysqld on
read -p "請輸入MySQL root用户密码：" DBPASS
mysqladmin -uroot password $DBPASS
mysql -uroot -p$DBPASS -e "delete from mysql.user where password=''"
echo "下面開始導入HardSoft资料库"
if [  -f 'hardsoft.sql' ];then
	mysql -uroot -p$DBPASS < hardsoft.sql
else
	echo "未找到數據庫表結構文件hardsoft.sql，請自行導入數據庫表結構";
fi
mysql -uroot -p$DBPASS -e "grant all on HardSoft.* to 'HardSoft'@'localhost' identified by 'HardSoft-Viewer'"

echo "開始安裝Apache/PHP..."
if [ -f 'mysql_backup.sh' ];then
        cp -rf mysql_backup.sh /usr/sbin/ >/dev/null 2>&1
else
        echo "複製mysql_backup.sh失敗，請自行處理複製到/usr/sbin/"
fi
if [ `grep '/usr/sbin/mysql_backup.sh' /etc/crontab|wc -l` -eq 0 ];then
        echo "0 2 * * * root bash /usr/sbin/mysql_backup.sh">>/etc/crontab
fi

yum -y install httpd httpd-devel php gd php-gd php-mysql gd-devel php-xml php-common php-mbstring php-pear php-xmlrpc >/dev/null 2>&1
[ $? -ne 0 ] && {
	echo "Yum安裝httpd/php失敗！請檢查網絡"
	exit 2
}
echo "127.0.0.1 $HOSTNAME">>/etc/hosts
echo "ServerName $HOSTNAME">>/etc/httpd/conf/httpd.conf
sed -i 's#ServerTokens OS#ServerTokens ProductOnly#g' /etc/httpd/conf/httpd.conf
sed -i 's#Options Indexes FollowSymLinks#Options FollowSymLinks#g' /etc/httpd/conf/httpd.conf
sed -i 's#expose_php = On#expose_php = Off#g' /etc/php.ini
/etc/init.d/httpd start >/dev/null 2>&1
if [ $? -ne 0 ];then
	echo "啟動httpd服務失敗，請檢查啟動錯誤日誌"
else
	echo "啟動Httpd服務成功"	
fi
chkconfig httpd on
}

setup_web()
{
if [ ! -f 'index.php' ];then
	echo "未找到客戶端index.php檔案，請檢查是否刪除，或者重新下載安裝檔案"
else
	cp -rf index.php /var/www/html/
fi
if [ ! -d 'phpadmin' ];then
	echo "未找到phpadmin資料夾，請自行下載phpMyAdmin,並解壓到/var/www/html/"
else
	sed -i 's#50500#50100#g' phpadmin/libraries/common.inc.php
	cp -rf phpadmin /var/www/html/
	sed -i 's#50500#50100#g' /var/www/html/phpadmin/libraries/common.inc.php

fi
}

setup_viewer()
{
echo "開始生成結果處理腳本/usr/sbin/viewer.sh並配置每分鐘執行一次"
yum -y install perl-Text-Iconv >/dev/null 2>&1
[ $? -ne 0 ] && {
	echo "安裝編碼轉換工具iconv失敗"
	exit 2;
}
if [ -f 'viewer.sh' ];then
	cp -rf viewer.sh /usr/sbin/ >/dev/null 2>&1
else
	echo "複製文本處理文件viewer.sh失敗，請自行處理複製到/usr/sbin/"
fi
if [ `grep '/usr/sbin/viewer.sh' /etc/crontab|wc -l` -eq 0 ];then
	echo "* * * * * root bash /usr/sbin/viewer.sh >>/var/log/viewer.log">>/etc/crontab
fi
/etc/init.d/crond restart >/dev/null 2>&1
}

setup_client()
{
#檢查存在網卡數量
NETCARDSUM=`ls /etc/sysconfig/network-scripts |grep 'ifcfg-eth'|awk -F'-' '{print $2}'|wc -l`
if [[ $NETCARDSUM -gt 1 ]];then
#echo "存在多個網卡:"
CARD=`ls /etc/sysconfig/network-scripts |grep 'ifcfg-eth'|awk -F'-' '{print $2}'`
#判斷選擇的網卡是否存在
input_card()
{
        NETCARD=""
        while [ ! -f "/etc/sysconfig/network-scripts/ifcfg-$NETCARD" ];do
                read -p "存在多個網卡,請選擇掃描機器工作網卡(`echo $CARD`):" NETCARD
        done
}
input_card
fi
#檢查是否有網卡變量，如果不存在網卡變量就以變量來獲得網卡
if [ ! -n "$NETCARD" ];then
NETCARD=`ls /etc/sysconfig/network-scripts/|grep 'ifcfg-eth'|awk -F'-' '{print $2}'`
fi
IP=`ifconfig $NETCARD|grep 'inet addr'|awk -F':' '{print $2}'|awk '{print $1}'`
if [ -f 'hardsoft-viewer.bat' ];then
	cp -f hardsoft-viewer.bat /data/hardclient/
	cp -f share.reg /data/hardclient/
	sed -i "s#172.17.44.248#$IP#g" /data/hardclient/hardsoft-viewer.bat
	chmod 644 /data/hardclient/hardsoft-viewer.bat
else
	echo "生成掃描客戶端失敗，請找到hardsoft-viewer.bat修改共享地址"
fi
echo "生成的掃描客戶端放在共享\\\\$IP\client中,用戶名:asc 密碼:asc"
}
setup_samba
setup_ftp
setup_lamp
setup_web
setup_viewer
setup_client
echo "基本資料訪問http://$IP"
echo "高級網頁客戶端訪問http://$IP/phpadmin/"
echo "高級網頁客戶端用戶名:root 密碼:$DBPASS"

