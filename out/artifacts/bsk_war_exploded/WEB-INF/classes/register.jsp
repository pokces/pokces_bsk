<%--
  Created by IntelliJ IDEA.
  User: Hlast
  Date: 2023/3/9
  Time: 13:24
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
    <script>
        let telbool=false
        let passbool=false
        let namebool=false
        let tel_test=/^(13[0-9]|14[01456879]|15[0-35-9]|16[2567]|17[0-8]|18[0-9]|19[0-35-9])\d{8}$/
        var tel
        var pass
        var name
        var sex="M"
        function checktel() {
            tel=$("#tel").val().trim()+''
            if(!tel_test.test(tel)){
                layer.tips('手机号不正确', '#tel', {tips: [3, '#78BA32']});
                $("#subbut").attr("onclick","")
                telbool=false
            }else {
                telbool=true
                    if(passbool==true&&namebool==true){
                        $("#subbut").attr("onclick","reg()")
                    }
                }
            }
        function checkpass() {
            pass = $("#pass").val().trim();
            if (pass.length < 6 || pass.length > 16) {
                layer.tips('密码不正确', '#pass', {
                    tips: [3, '#78BA32']
                });
                $("#subbut").attr("onclick", "")
                passbool = false
            } else {
                passbool = true
                if (telbool == true && namebool == true) {
                    $("#subbut").attr("onclick", "reg()")
                }
            }}

        function checkname() {
            name = $("#name").val().trim();
            if (name.length > 5) {
                layer.tips('名称不正确', '#name', {
                    tips: [3, '#78BA32']
                });
                $("#subbut").attr("onclick", "")
                namebool = false
            } else {
                namebool = true
                if (telbool == true && passbool == true) {
                    $("#subbut").attr("onclick", "reg()")
                }
            }
        }
            function changes(t,S) {
                console.log(1)
                $("#sexman").attr("class", "")
                $("#sexwoman").attr("class", "")
                if(S=="M"){
                    $("#sexman").attr("class", "login-redcolor")
                    sex="M"
                }else{
                    $("#sexwoman").attr("class", "login-redcolor")
                    sex="F"
                }
            }

            function reg() {
                $.ajaxSettings.async = false
                console.log(sex)
                $.post("ServletUser?m=regist", {
                    "userTel": tel,
                    "userPwd": pass,
                    "userName": name,
                    "userSex": sex
                }, function (data) {
                    if (data == "Y") {
                        top.location.href="main.jsp"
                    } else {
                        layer.msg(data, {
                            offset: 't',
                            anim: 6
                        });
                        setTimeout(function () {
                            window.location.reload()
                        },1000)


                    }
                })
                Location.href = "login.jsp"
                $.ajaxSettings.async = true
            }

    </script>

    <title>注册</title>
</head>

<body>

<!--register begin-->
<div class="m-login">
    <div class="login-logo"><img src="images/common/logo.png" /></div>
    <div class="login-title border-bot">欢迎注册加入会员中心</div>
    <div class="input-box  border-bot"><img src="images/login/icon-phone.png" /><input type="text" id="tel" onblur="checktel()" placeholder="请输入手机号" class="input-box1"/></div>
    <div class="input-box  border-bot"><img src="images/login/icon-password.png" /><input type="text" id="pass" onblur="checkpass()" placeholder="密码，长度6-16字符" class="input-box1" /></div>
    <div class="input-box  border-bot"><img src="images/login/icon-name.png" /><input type="text" id="name" onblur="checkname()" placeholder="姓名，最多5个字" />
        <span><a href="#" id="sexman" class="login-redcolor" onclick="changes(this,'M')">先生</a> | <a href="#" id="sexwoman" onclick="changes(this,'F')" style="margin:0">女士</a></span></div>
    <div class="input-box "></div>
    <div class="login-me cursor" id="subbut" onclick=""><button class="cursor" >立即注册</button></div>
</div>
<!--register end-->
</body>

</html>

