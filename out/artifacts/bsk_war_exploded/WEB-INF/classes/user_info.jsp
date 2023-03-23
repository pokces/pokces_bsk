<%--
  Created by IntelliJ IDEA.
  User: Hlast
  Date: 2023/3/9
  Time: 17:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<![CDATA[ 文本 //]]>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link rel="stylesheet" type="text/css" href="css/css.css"/>
    <link rel="stylesheet" type="text/css" href="css/style.css"/>
    <link rel="stylesheet" type="text/css" href="css/address.css"/>
    <title>个人信息</title>
    <script type="text/javascript"
            src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script src="layer/layer.js" type="text/javascript"></script>
    <script src="js/main.js" type="text/javascript"></script>
    <script src="layer/layer.js"></script>
    <script type="text/javascript"></script>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <script >
        function save() {
            let newname=$("#newname").val().trim()+""
            let newsex=$("#newsex").val().trim()+""

            if(newsex=="先生" || newsex=="女士"){
                if (newname.length<=6){
                    $.ajaxSettings.async=false
                    if(newsex=="先生"){
                        newsex="M"
                    }else{
                        newsex="F"
                    }
                    $.post("ServletUser?m=setUser",{"userId":${sessionScope.loginuser.userId},"userName":newname,"userSex":newsex},function (data) {
                    })
                    top.location.reload()
                    $.ajaxSettings.async=true
                }else{
                    layer.msg("姓名过长", {
                        offset: 't',
                        anim: 6
                    });
                }
            }else{
                layer.msg("请输入正确的性别", {
                    offset: 't',
                    anim: 6
                });
            }
        }
        function savepass() {
            var inputpass=$("#inputpass").val().trim()+""
            var newpass=$("#newpass").val().trim()+""
            let imgcode=$("#imgcode").val().trim()+""
            if(imgcode.length!=4){
                layer.msg("错误的验证码长度", {
                    offset: 't',
                    anim: 6
                })
            }else if(newpass.length<6||newpass.length>=16){
                layer.msg("错误的密码长度", {
                    offset: 't',
                    anim: 6
                })
            }else{
                    $.ajaxSettings.async=false
                    $.post("ServletUser?m=updatePass",{"userPwd":newpass,"userId":${sessionScope.loginuser.userId},"imgcode":imgcode,"oldPass":inputpass},function (data) {
                        if(data=="e1"){
                            layer.msg("错误的验证码", {
                                offset: 't',
                                anim: 6
                            })
                            $("#codeimg").attr("src","ServletUser?m=CodeImg&c="+Math.random())
                        }else if(data=="e2"){
                            layer.msg("不是正确的原密码", {
                                offset: 't',
                                anim: 6
                            });
                        }else if(data=="e3"){
                            layer.msg("重复的密码", {
                                offset: 't',
                                anim: 6
                            })
                        }else{
                            top.location.href="main.jsp"
                        }
                    })
                    $.ajaxSettings.async=true
                }
            }

        function changeImg() {
            $("#codeimg").attr("src","ServletUser?m=CodeImg&c="+Math.random())
        }
    </script>
</head>

<body>
<div class="m-address">
    <div class="wrapper">
        <div class="area" style="bottom:110px;">
            <div class="type border-bottom">
                <span class="left">个人信息</span>
            </div>
            <div class="title1 a-user">
                <div class="fl">
							<span><img src="images/member/desc-icon-name.png"/>
								姓名/性别</span>
                    <c:if test="${sessionScope.loginuser.userSex=='M'}">
                        <span class="pad">${sessionScope.loginuser.userName} 先生</span>
                    </c:if>
                    <c:if test="${sessionScope.loginuser.userSex=='F'}">
                        <span class="pad">${sessionScope.loginuser.userName} 女士</span>
                    </c:if>

                </div>
                <div class="fr">
                    <a href="#" class="login-redcolor" onclick="change('name_sex',1)">修改</a>
                </div>
            </div>
            <div style="display: none;" class="title1 a-user a-setuser change"
                 id="update_name_sex">
                <div class="fl userleft">
							<span><img src="images/member/desc-icon-name.png"/>
								姓名/性别</span>
                </div>
                <div class="text-input07" style="width: 155px">
                    <input id="newname" type="text"
                           onfocus="if (value ==='${sessionScope.loginuser.userName}'){value =''}"
                           onblur="if (value ===''){value='${sessionScope.loginuser.userName}'}"
                           value="${sessionScope.loginuser.userName}"/>
                </div>
                <select class="text-input07" id="newsex" style="width: 155px">
                    <option>先生</option>
                    <option ${sessionScope.loginuser.userSex=='M'?'':'selected'}>女士</option>
                </select>
                <div class="act-botton clear">
                    <div class="save-button">
                        <a href="javascript:" onclick="save()" class="radius">保存</a>
                    </div>
                    <div class="cancel-button">
                        <a href="javascript:" class="radius"
                           onclick="change('name_sex',2)">取消</a>
                    </div>
                </div>
            </div>
            <div class="border-bottom"></div>
            <div class="title1 a-user">
                <div class="fl">
							<span><img src="images/member/desc-icon-phone.png"/>
								手机号码</span>
                    <span class="pad">${sessionScope.loginuser.userTel}</span>
                </div>
            </div>
            <div class="border-bottom"></div>
            <div class="title1 a-user">
                <div class="fl">
                    <span><img src="images/login/icon-name.png"/> 登陆密码</span>
                    <input type="password" disabled value="${sessionScope.loginuser.userPwd}" style="border: none"
                           class="pad"/>
                    <span class="add-icon cursor"></span>
                </div>
                <div class="fr">
                    <a href="#" class="login-redcolor" onclick="change('pwd',1)" >修改</a>
                </div>
            </div>
            <div style="display: none;" class="title1 a-user change" id="update_pwd">
                <div class="fl">
                    <span><img src="images/login/icon-name.png"/> 登陆密码</span>
                </div>
                <div class="fl">
                    <div class="text-input07">
                        <input type="text" id="inputpass" placeholder="请输入旧密码"/>
                    </div>
                    <div class="fr">
                        <p style="line-height: 20px; margin-left: 10px">
                            请输入6-16位密码，可使用阿拉伯数字
                            <br/>
                            英文字母或两者结合
                        </p>
                    </div>
                    <br/>
                    <div class="text-input07">
                        <input type="text" id="newpass"  placeholder="请输入新密码"/>
                    </div>
                    <br/>
                    <div class="text-input07">
                        <input type="text"  id="imgcode" placeholder="请输入验证码"/>
                    </div>
                    <div class="fl">
                        <p style="line-height: 30px; margin-left: 10px">
                            <img id="codeimg" src="ServletUser?m=CodeImg" >
                            看不清？
                            <a href="#" class="login-redcolor" onclick="changeImg()">换一张</a>
                        </p>
                    </div>
                </div>
                <div class="act-botton clear"
                     style="margin: 20px 0; padding: 20px 0">
                    <div class="save-button">
                        <a href="javascript:" onclick="savepass()" class="radius">保存</a>
                    </div>
                    <div class="cancel-button">
                        <a href="javascript:" class="radius" onclick="change('pwd',2)" >取消</a>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
</div>
</body>
</html>
<SCRIPT Language=VBScript><!--

//-->









</SCRIPT>
