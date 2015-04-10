<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?php
class mysql {
private $DBHOST='localhost';
private $DBUSER='HardSoft';
private $DBPASS='HardSoft-Viewer';
private $DBNAME='HardSoft';
private $CONN;

public function __construct(){
		try{
			$conn=@mysql_connect($this->DBHOST,$this->DBUSER,$this->DBPASS);
		}catch(Exception $e){
			echo $e;
		}
		try{
			mysql_select_db($this->DBNAME,$conn);
		}catch(Exception $e){
			echo $e;
		}
		$this->CONN=$conn;
		mysql_query("SET NAMES UTF8");
	}
public function select($sql=""){
	if(empty($sql)) return false;
	if(empty($this->CONN)) return false;
	try{
			$result=mysql_query($sql,$this->CONN);
		}catch(Exception $e){
			echo $e;
		}
	if((!$result) or (empty($result))){
		@mysql_free_result($result);
		return false;
	}
	$count=0;
	$data=array();
	while($row=@mysql_fetch_array($result)){
		$data[$count]=$row;
		$count++;
	}
	@mysql_free_result($result);
	return $data;
}
public function insert($sql=""){
	if(empty($sql)) return false;
	if(empty($this->CONN)) return false;
	try{
			$result=mysql_query($sql,$this->CONN);
		}catch(Exception $e){
			echo $e;
		}
	if(!$result){
		return 0;
	}else{
		return @mysql_insert_id($this->CONN);
	}
}
public function update($sql=""){
	if(empty($sql)) return false;
	if(empty($this->CONN)) return false;
	try{
			$result=mysql_query($sql,$this->CONN);
		}catch(Exception $e){
			echo $e;
		}
	return $result;
}
public function delete($sql=""){
	if(empty($sql)) return false;
	if(empty($this->CONN)) return false;
	try{
			$result=mysql_query($sql,$this->CONN);
		}catch(Exception $e){
			echo $e;
		}
	return $result;
}
}
?>
 
<html xmlns="http://www.w3.org/1999/xhtml" lang="zh-CN">
 <head>
 <meta http-equiv="Content-Type" content="text/html; charset=utf8" />
 <title>HardSoft-Viewer</title>
 <style type="text/css">
 <!--
body {
 font-family:SimSun,Arial, Helvetica, sans-serif;
 font-size:14px;
 color:#666666;
 background:#fff;
 text-align:center;
 }
 * {
 margin:0;
 padding:0;
 }


 a {
 color:#1E7ACE;
 text-decoration:none; 
 }
 a:hover {
 color:#000;
 text-decoration:underline;
 }
 h3 {
 font-size:14px;
 font-weight:bold;
 }


 pre,p {
 color:#1E7ACE;
 margin:4px;
 }
 input, select,textarea {
 padding:2px;
 margin:3px;
 font-size:12px;
 }
 .buttom{
 padding:1px 10px;
 font-size:12px;
 border:1px #1E7ACE solid;
 background:#D0F0FF;
 }
 #formwrapper {
 width:700px;
 margin:15px auto;
 padding:20px;
 text-align:left;
 border:1px solid #A4CDF2;
 }
 fieldset {
 padding:10px;
 margin-top:5px;
 border:1px solid #A4CDF2;
 background:#fff;
 }
 fieldset legend {
 color:#1E7ACE;
 font-weight:bold;
 padding:3px 20px 3px 20px;
 border:1px solid #A4CDF2; 
 background:#fff;
 }
 fieldset label {
 float:left;
 width:650px;
 text-align:left;
 padding:3px;
 margin:1px;
 }
#edit {
 float:left;
 width:50px;
 text-align:left;
 padding:3px;
 margin:1px;
 }

 fieldset div {
 clear:left;
 margin-bottom:2px;
 }
 .enter{ text-align:center;}
 .clear {
 clear:both;
 }
 -->
 </style>
 </head>
 <body>
<?php
if (($_GET['action']!="getsoftlist") and ($_GET['action']!="editinfo"))
{
?>
	<br><center>
	<form name='search' action="" method="post">
	<select name='type' id ='type'>
        <option value='id'>按財編</option>
        <option value='ip'>按IP</option>
	</select>
	<input type='hidden' name='action' value='select'></input>
	<input name='class' type='text' id='class' size=30 />
	<input name="select" type="button" class="buttom" value="搜 尋" />
	</form>
	</center> 
<?php
}
?>
<?php
$conn=new mysql();
$ip=$_SERVER['REMOTE_ADDR'];
if ($_SERVER['REQUEST_METHOD']=='POST')
{
	if ($_POST['action']=='select')
	{
	switch ($_POST['type'])
	{
	case 'id' :
		$sql="SELECT * FROM Get_Scan_Info where id='".trim($_POST['class'])."'";
		break;
	case 'ip' :
        	$sql="SELECT * FROM Get_Scan_Info where IP_Address LIKE '%".trim($_POST['class'])."%' ORDER BY IP_Address ASC LIMIT 1";
		break;
       	default:
		echo "Input Error!";
		exit();
	}
	$data=$conn->select($sql);
	if($data){
		foreach($data as $key=>$value)
		{
 ?>
 <div id="formwrapper">
	<div align='center'><h3>ASC硬件管理系統</h3></div>
    <fieldset>
     <legend>用戶信息</legend>
     <div><label for="Name">廠 別:<?php echo $value['Factory'];?></label><br/></div>
	 <div><label for="Name">部 門:<?php echo $value['Depart'];?></label><br/></div>
	 <div><label for="Name">財 編:<?php echo $value['id'];?></label><br/></div>
	 <div><label for="Name">工 號:<?php echo $value['Account'];?></label><br/></div>
	 <div><label for="Name">用 戶:<?php echo $value['Owner'];?></label><br/></div>
	 <div><label for="Name">位 置:<?php echo $value['Locate'];?></label><br/></div>
	 <div><label for="Name">標 記:<?php echo $value['Mark'];?></label><br/></div>
	 <div><label for="Name">備 註:<?php echo $value['Note'];?></label><br/></div>
	 <input name="edit" type="button" class="buttom" value="編 輯" onclick="location.href='?id=<?php echo $value['id']; ?>&action=editinfo'"/>
     </fieldset>
   <br/>

     <fieldset>
     <legend>配置信息</legend>
	 <div><label for="Name">系 統:<?php echo $value['OS'];?></label><br/></div>
	 <div><label for="Name">CPU&nbsp :<?php echo $value['CPU'];?></label><br/></div>
	 <div><label for="Name">內 存:<?php echo $value['STAND_Ram'];?></label><br/></div>
	 <div><label for="Name">顯 卡:<?php echo $value['Display_Card'];?></label><br/></div>
	 <div><label for="Name">主 板:<?php echo $value['MotherBoard_Type'];?></label><br/></div>
	 <div><label for="Name">硬 盤:<?php echo $value['HardDisk_Type'];?></label><br/></div>
	 <div><label for="Name">大 小:<?php echo $value['STAND_HD_Size'];?></label><br/></div>
	 <div><label for="Name">網 卡:<?php echo $value['NetCard_Type'];?></label><br/></div>
     <div><label for="Name">MAC&nbsp :<?php echo $value['MAC_Address'];?></label><br/></div>
	 <div><label for="Name">IP &nbsp :<?php echo $value['IP_Address'];?></label><br/></div>
	 <div><label for="Name">掃描時間:<?php echo $value['ScanTime'];?></label><br/></div>
     </fieldset>
	 <br/>
	 <fieldset>
	<legend>權限信息</legend>
	<div><label for="Name">管 理 員 組:<?php echo $value['Admin'];?></label><br/></div>
	<div><label for="Name">PowerUser組:<?php echo $value['Poweruser'];?></label><br/></div>
	<div><label for="Name">USB 存 儲:<?php echo $value['USB'];?></label><br/></div>
	</fieldset>
	<br/>
	<fieldset>
	<legend>版權軟件</legend>
	<?php
	$softsql="SELECT * FROM Get_Soft WHERE id='".$value['id']."'";
	$soft=$conn->select($softsql);
	if ($soft){
		foreach($soft as $k=>$v){
	?>
	<div><label for="Name"><?php echo ($k+1).'、'.$v['SoftName']; ?></label><br/></div>
	<?php
		}
	}	
	?>
	<input name="select" type="button" class="buttom" value="所有軟件" onclick="location.href='?id=<?php echo $value['id']; ?>&action=getsoftlist'" />
	</fieldset><br/>
        <fieldset>
        <legend>共享信息</legend>
        <?php
        $sharesql="SELECT * FROM Share WHERE id='".$value['id']."'";
        $share=$conn->select($sharesql);
        if ($share){
                foreach($share as $k=>$v){
        ?>
        <div><label for="Name"><?php echo ($k+1).'、'.$v['Share']; ?></label><br/></div>
        <?php
                }
        }
        ?>
        </fieldset>

 </div>
<?php
	}
	}else{
		echo '<br/>未搜尋到相關信息! ';
	}
	exit();
	}
	elseif ($_POST['action']=='edit'){
		$id=mysql_real_escape_string($_POST['id']);
		$Factory=mysql_real_escape_string($_POST['Factory']);
		$Depart=mysql_real_escape_string($_POST['Depart']);
		$Owner=mysql_real_escape_string($_POST['Owner']);
		$Account=mysql_real_escape_string($_POST['Account']);
		$Locate=mysql_real_escape_string($_POST['Locate']);
		$Mark=mysql_real_escape_string($_POST['Mark']);
		$Note=mysql_real_escape_string($_POST['Note']);
		if (empty($id)) {
				echo "<script language='javascript'>";
				echo "alert('財產編號不能為空，請檢查！');";
				echo "history.back()";
				echo "</script>";
				exit();
		}
		if (empty($Factory)) {
				echo "<script language='javascript'>";
				echo "alert('廠別不能為空，請檢查！');";
				echo "history.back()";
				echo "</script>";
				exit();
		}
		if (empty($Depart)) {
				echo "<script language='javascript'>";
				echo "alert('部門不能為空，請檢查！');";
				echo "history.back()";
				echo "</script>";
				exit();
		}
		if (empty($Locate)) {
				echo "<script language='javascript'>";
				echo "alert('存放位置不能為空，請檢查！');";
				echo "history.back()";
				echo "</script>";
				exit();
		}
		//查詢是否存在傳遞過來財產編號
		$sql="SELECT id from Computers where id = '".$id."'";
		$result=mysql_query($sql);
		if(empty($result)){
			echo "<script language='javascript'>";
			echo "alert('無法查找到".$_POST['id']."這個財產編號，請檢查確認！');";
			echo "history.back()";
			echo "</script>";
			exit();
		}
		//對用戶使用信息進行更改
		$sql="UPDATE Computers SET Factory='".$Factory."',Depart='".$Depart."',Owner='".$Owner."',Account='".$Account."',Locate='".$Locate."',Mark='".$Mark."',Note='".$Note."' WHERE id='".$id."'";
		$result=$conn->update($sql);
		switch(mysql_affected_rows()){
		case 1 :
			echo "<script language='javascript'>";
			echo "alert('".$_POST['id']."修改成功');";
			//echo "history.back()";
			echo "location.href='?id=".$_POST['id']."'";
			echo "</script>";
			break;
		case 0 :
			echo "<script language='javascript'>";
			echo "alert('未修改".$_POST['id']."財產的信息');";
			echo "history.back(-1)";
			echo "</script>";
			break;
		case -1 :
			echo "<script language='javascript'>";
			echo "alert('修改".$_POST['id']."失敗，請檢查確認！');";
			echo "history.back()";
			echo "</script>";
			break;
		default:
			echo "<script language='javascript'>";
			echo "alert('未知錯誤');";
			echo "history.back()";
			echo "</script>";
		}
		exit();
	}
}
?>
<?php
//根據動作名稱為getsoftlist查詢$id的软件列表
if (isset($_GET['id']) && $_GET['action']=='getsoftlist'){
$sql="SELECT * FROM Software where id = '".trim($_GET['id'])."'";
$softlist=$conn->select($sql);
if($softlist){
	echo '<br/><input name="back" type="button" class="buttom" value="返 回"  onclick="location.href=\'javascript:history.go(-1);\'"></input>';
	echo "<div id='formwrapper'><fieldset><legend>".$_GET['id'].'主機軟件列表</legend>';
	foreach($softlist as $key=>$value){
		echo "<div><label for='Name'>".($key+1).'、'.$value['SoftName'].'</label><br/></div>';
	}
	echo '<input name="back" type="button" class="buttom" value="返 回"  onclick="location.href=\'javascript:history.go(-1);\'"></input>';
	echo '</fieldset></div>';
}else{
	echo '無財產編號為'.$_GET['id'].'的軟件安裝列表！';
	}
exit();
}
if (isset($_GET['id']) && $_GET['action']=='editinfo'){
	$sql="SELECT * FROM Computers WHERE id = '".trim($_GET['id'])."'";
	$info=$conn->select($sql);
	if($info){
		echo "<div id='formwrapper'><fieldset><legend>".$_GET['id'].'主機用戶信息編輯</legend>';
		foreach($info as $key=>$value){
?>
			<form action='' method='post'>
			<input type='hidden' name='action' value='edit'></input>
			<br/><div><div id="edit">財 編:</div><input type="text" name="id" size="20" readonly="readonly" value='<?php echo $value['id']; ?>' /><br/></div>
			<div><div id="edit">廠 別:</div><input type="text" name="Factory" size="20" value='<?php echo $value['Factory'];?>' /><br/></div>
			<div><div id="edit">部 門:</div><input type="text" name="Depart" size="20" value='<?php echo $value['Depart'];?>' /><br/></div>
			<div><div id="edit">用 戶:</div><input type="text" name="Owner" size="20" value='<?php echo $value['Owner'];?>' /><br/></div>
			<div><div id="edit">賬 號:</div><input type="text" name="Account" size="20" value='<?php echo $value['Account'];?>' /><br/></div>
			<div><div id="edit">位 置:</div><input type="text" name="Locate" size="20" value='<?php echo $value['Locate'];?>' /><br/></div>
			<div><div id="edit">標 記:</div><input type="text" name="Mark" size="20" value='<?php echo $value['Mark'];?>' /><br/></div>
			<div><div id="edit">備 註:</div><textarea row=3 cols=20 name='Note'><?php echo $value['Note'];?></textarea><br/></div>
<?php
		}
?>
		<input type="submit" class="buttom"  value="確 定"></input>&nbsp
		<input type="button" class="buttom" value="返  回" onclick="location.href='javascript:history.go(-1);'"></input>
		</form></fieldset></div>
<?php
	}
exit();
}	
//默認動作，根據IP查詢主機相關信息
if(isset($_GET['id'])){
	$sql="SELECT * FROM Get_Scan_Info WHERE id='".trim($_GET['id'])."'";
}else{
$sql="SELECT * FROM Get_Scan_Info WHERE IP_Address LIKE '%".$ip."%' ORDER BY IP_Address ASC LIMIT 1";
}
$data=$conn->select($sql);	
if($data){
	foreach($data as $key=>$value)
	{
?>
 <div id="formwrapper">
	<div align='center'><h3>ASC硬件管理系統</h3></div>
    <fieldset>
     <legend>用戶信息</legend>
         <div><label for="Name">廠 別:<?php echo $value['Factory'];?></label><br/></div>
	 <div><label for="Name">部 門:<?php echo $value['Depart'];?></label><br/></div>
	 <div><label for="Name">財 編:<?php echo $value['id'];?></label><br/></div>
	 <div><label for="Name">用 戶:<?php echo $value['Owner'];?></label><br/></div>
	 <div><label for="Name">工 號:<?php echo $value['Account'];?></label><br/></div>
	 <div><label for="Name">位 置:<?php echo $value['Locate'];?></label><br/></div>
	 <div><label for="Name">標 記:<?php echo $value['Mark'];?></label><br/></div>
	 <div><label for="Name">備 註:<?php echo $value['Note'];?></label><br/></div>
	 <input name="edit" type="button" class="buttom" value="編 輯"  onclick="location.href='?id=<?php echo $value['id']; ?>&action=editinfo'" />
     </fieldset>
   <br/>

     <fieldset>
     <legend>配置信息</legend>
	 <div><label for="Name">系 統:<?php echo $value['OS'];?></label><br/></div>
	 <div><label for="Name">CPU&nbsp :<?php echo $value['CPU'];?></label><br/></div>
	 <div><label for="Name">內 存:<?php echo $value['STAND_Ram'];?></label><br/></div>
	 <div><label for="Name">顯 卡:<?php echo $value['Display_Card'];?></label><br/></div>
	 <div><label for="Name">主 板:<?php echo $value['MotherBoard_Type'];?></label><br/></div>
	 <div><label for="Name">硬 盤:<?php echo $value['HardDisk_Type'];?></label><br/></div>
	 <div><label for="Name">大 小:<?php echo $value['STAND_HD_Size'];?></label><br/></div>
	 <div><label for="Name">網 卡:<?php echo $value['NetCard_Type'];?></label><br/></div>
     <div><label for="Name">MAC&nbsp :<?php echo $value['MAC_Address'];?></label><br/></div>
	 <div><label for="Name">IP &nbsp :<?php echo $value['IP_Address'];?></label><br/></div>
	 <div><label for="Name">掃描時間:<?php echo $value['ScanTime'];?></label><br/></div>
     </fieldset>
	 <br/>
	 <fieldset>
	<legend>權限信息</legend>
	<div><label for="Name">管 理 員 組:<?php echo $value['Admin'];?></label><br/></div>
	<div><label for="Name">PowerUser組:<?php echo $value['Poweruser'];?></label><br/></div>
	<div><label for="Name">USB 存 儲:<?php echo $value['USB'];?></label><br/></div>
	</fieldset>
	<br/>
	<fieldset>
	<legend>版權軟件</legend>
	<?php
	$softsql="SELECT * FROM Get_Soft WHERE id='".$value['id']."'";
	$soft=$conn->select($softsql);
	if ($soft){
		foreach($soft as $k=>$v){
	?>
	<div><label for="Name"><?php echo ($k+1).'、'.$v['SoftName']; ?></label><br/></div>
	<?php
		}
	}
	?>
	<input name="select" type="button" class="buttom" value="所有軟件" onclick="location.href='?id=<?php echo $value['id']; ?>&action=getsoftlist'" />
	</fieldset><br />
	<fieldset>
        <legend>共享信息</legend>
        <?php
        $sharesql="SELECT * FROM Share WHERE id='".$value['id']."'";
        $share=$conn->select($sharesql);
        if ($share){
                foreach($share as $k=>$v){
        ?>
        <div><label for="Name"><?php echo ($k+1).'、'.$v['Share']; ?></label><br/></div>
        <?php
                }
        }
        ?>
        </fieldset>

 </div>
 <?php
		}
	}else{
		echo "無此主機相關信息";
	}
 ?>
 </body>
 </html>


