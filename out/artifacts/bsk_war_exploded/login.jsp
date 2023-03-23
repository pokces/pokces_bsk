<%--
  Created by IntelliJ IDEA.
  User: Hlast
  Date: 2023/3/9
  Time: 11:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" type="text/css" href="css/css.css" />
    <link rel="stylesheet" type="text/css" href="css/style.css" />
    <script src="js/jquery1.12.4.min.js"></script>
    <script src="layer/layer.js"></script>
    <title>登录</title>
</head>

<body>

<!--login begin-->
<div class="m-login">
    <div class="login-logo"><img src="images/common/logo.png" /></div>
    <div class="login-title border-bot login-redcolor" style="font-weight:normal">账号密码登陆</div>
    <div class="input-box  border-bot"><img src="images/login/icon-phone.png" /><input type="text" id="tel" onblur="checktel()" placeholder="请输入手机号" class="input-box1"/></div>
    <div class="input-box  border-bot"><img src="images/login/icon-password.png" /><input type="text" id="pass" onblur="checkpass()" placeholder="密码，长度6-16字符" class="input-box1" /></div>
    <div class="input-box" style="text-align:left"><a href="register.jsp" class="login-redcolor" style="text-decoration:underline; font-size:18px">快速注册</a></div>
    <div class="input-box "></div>
    <div class="login-me cursor" onclick="" id="subbut"><button class="cursor" >登陆</button></div>
</div>
<!--login end-->
</body>
<script>
    let telbool=false;
    let passbool=false;
    let tel_test=/^(13[0-9]|14[01456879]|15[0-35-9]|16[2567]|17[0-8]|18[0-9]|19[0-35-9])\d{8}$/
    var tel
    var pass
    function checktel() {
         tel=$("#tel").val().trim()
        if(!tel_test.test(tel)){
            layer.tips('手机号不正确', '#tel', {
                tips: [3, '#78BA32']
            });
            $("#subbut").attr("onclick","")
            telbool=false
        }else{
            telbool=true
            if(passbool==true){
                $("#subbut").attr("onclick","test()")
            }
        }}
    function checkpass() {
        pass=$("#pass").val().trim();
        if(pass.length<6||pass.length>16){
            layer.tips('密码不正确', '#pass', {
                tips: [3, '#78BA32']
            });
            $("#subbut").attr("onclick","")
            passbool=false
        }else{
            passbool=true
            if(telbool==true){
                $("#subbut").attr("onclick","test()")
            }
        }
    }
    function test() {
        $.ajaxSettings.async=false
        $.post("ServletUser?m=login",{"userTel":tel,"userPwd":pass},function (data) {
            if(data=="Y"){
            top.location.href="main.jsp"
            }else{
                layer.msg(data, {
                    offset: 't',
                    anim: 6
                });
            }
        })
        $.ajaxSettings.async=true
    }
</script>
</html>
