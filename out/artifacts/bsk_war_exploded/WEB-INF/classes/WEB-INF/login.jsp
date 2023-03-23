<%--
  Created by IntelliJ IDEA.
  User: Hlast
  Date: 2023/3/8
  Time: 16:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <link rel="stylesheet" type="text/css" href="../css/css.css" />
  <link rel="stylesheet" type="text/css" href="../css/style.css" />
  <title>登录</title>
</head>

<body>

<!--login begin-->
<div class="m-login">
  <div class="login-logo"><img src="../images/common/logo.png" /></div>
  <div class="login-title border-bot login-redcolor" style="font-weight:normal">账号密码登陆</div>
  <div class="input-box  border-bot"><img src="../images/login/icon-phone.png" /><input type="text" id="tel" onblur="checktel()" placeholder="请输入手机号" class="input-box1"/></div>
  <div class="input-box  border-bot"><img src="../images/login/icon-password.png" /><input type="text" id="pass" onblur="checkpass()" placeholder="密码，长度6-16字符" class="input-box1" /></div>
  <div class="input-box" style="text-align:left"><a href="register.html" class="login-redcolor" style="text-decoration:underline; font-size:18px">快速注册</a><a id="msg"></a></div>
  <div class="input-box "></div>
  <div class="login-me cursor"><button id="subbut" class="cursor" onclick="login()">登陆</button></div>
</div>
<!--login end-->
</body>
<script type="text/javascript" rel=“stylesheet” src="../js/jquery1.12.4.min.js"></script>
<script>
  function checktel() {
    console.log($("#tel").val().length)
    if($("#tel").val().length!=11){
      $("#msg").html("手机号码长度不正确")
      $("#subbut").attr("disabled",true)
    }else{
      $("#msg").html("")
      $("#subbut").attr("disabled",false)
    }}
  function checkpass() {
    console.log($("#pass").val().length)
    if($("#pass").val().length<6||$("#pass").val().length>16){
      $("#msg").html("密码长度不正确")
      $("#subbut").attr("disabled",true)
    }else{
      $("#msg").html("")
      $("#subbut").attr("disabled",false)
    }
  }


</script>
</html>