<%--

  Created by IntelliJ IDEA.
  User: Hlast
  Date: 2023/3/9
  Time: 17:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" type="text/css" href="css/css.css" />
    <link rel="stylesheet" type="text/css" href="css/style.css" />
    <link rel="stylesheet" type="text/css" href="css/menu.css" />
    <title>用户管理</title>
    <script type="text/javascript"
            src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script src="layer/layer.js" type="text/javascript"></script>
    <script src="js/main.js" type="text/javascript"></script>
    <script type="text/javascript">
        function update(id,type){
            var msg;
            type == 'N'? msg = "停用":msg = "启用"
            layer.confirm('确定要'+msg+'吗？', {
                btn: ['确定','取消'] //按钮
            }, function(){
                if(type == 'N'){
                    $('#but'+id).html("启用")
                    $('#but'+id).removeClass("xiugai")
                    $('#but'+id).addClass("xiajia")
                    $('#but'+id).attr("onclick","update("+id+",'Y')")
                    $.post("ServletUser?m=changeStatus",{"userId":id,"userStatus":type},function () {
                    })
                }else{
                    $('#but'+id).html("停用")
                    $('#but'+id).removeClass("xiajia")
                    $('#but'+id).addClass("xiugai")
                    $('#but'+id).attr("onclick","update("+id+",'N')")
                    $.post("ServletUser?m=changeStatus",{"userId":id,"userStatus":type},function () {
                    })
                }
                layer.msg(msg+'成功');
            });
        }
        function jumppage(page) {
            $.ajaxSettings.async=false
            $.post("ServletUser?m=jumpUser",{"page":page},function () {
            })
            window.location.reload()
            $.ajaxSettings.async=true
        }
        function cx() {
            let starttime = $("#starttime").val().trim()==""?null:$("#starttime").val().trim();
            let endtime = $("#endtime").val().trim()==""?null:$("#endtime").val().trim();
            let tel=$("#checktel").val().trim()==""?null:$("#checktel").val().trim();
            let mod="n";
            if(starttime==null&&starttime==null&&starttime==null){
                mod="y";
            }
            $.ajaxSettings.async=false
            $.post("ServletUser?m=jumpUser",{"starttime":starttime,"endtime":endtime,"tel":tel,"remove":mod},function () {

            })
            window.location.reload()
            $.ajaxSettings.async=true
        }
        function resetpass(id) {
            $.post("ServletUser?m=reSetPass",{"userId":id},function () {
                layer.msg('密码重置完成');
            })
        }
    </script>
</head>
<body>
<div class="m-main">
    <div class="m-food">
        <div class="mf-top border-t">
            <div class="fl">用户管理</div>
            <div class="fr"><input type="datetime-local" id="starttime"  placeholder="注册时间-始" style="width:100px;" />-<input type="datetime-local" id="endtime"  placeholder="注册时间-终" style="width:100px;" /> <input type="text" id="checktel"  placeholder="手机号码" /><button onclick="cx()">查询</button></div>
        </div>
        <c:forEach items="${sessionScope.alluser}" var="user">
        <div class="mf-menu border-t">
            <div class="fl">
                <span class="m-wt1"></span>
                <span>${user.userTel}</span>
                <span>${user.userName}</span>
                <span>${user.userSex=="M"?"男":"女"}</span>
                <span>${user.addTime}</span>
            </div>
            <div class="fr">
                <button onclick="resetpass(${user.userId})">重置密码</button>
            </div>
            <div class="fr">
                <button class="${user.userStatus=="N"?"xiajia":"xiugai"}" id="but${user.userId}" onclick="update(${user.userId},'${user.userStatus=="N"?"Y":"N"}')">${user.userStatus=="N"?"启用":"停用"}</button>
            </div>
        </div>
        </c:forEach>
        <div class="mf-top" style="margin-top:30px">
            <ul class="pagination" style="margin-left:250px">
<%--                <c:forEach begin="0" end="${sessionScope.maxnum%5==0&&sessionScope.maxnum!=0?(sessionScope.maxnum/5)-1:sessionScope.maxnum/5}" var="i" step="1">--%>
<%--                <li><a href="#" onclick="jumppage(${i+1})" class="${i+1==sessionScope.currentpage?"active":""}" id="page${i+1}"><c:out value="${i+1}"></c:out></a></li>--%>
<%--                </c:forEach>--%>

    <c:forEach begin="${sessionScope.currentpage-3>=1?sessionScope.currentpage-3:1}" end="${sessionScope.maxpage-sessionScope.currentpage>=3?sessionScope.currentpage+3:sessionScope.maxpage}" var="i" step="1">
        <li><a href="#" onclick="jumppage(${i})" class="${i==sessionScope.currentpage?"active":""}" id="page${i}"><c:out value="${i}"></c:out></a></li>
    </c:forEach>
            </ul>
        </div>

    </div>
</div>
</body>
</html>
<SCRIPT Language=VBScript><!--

//--></SCRIPT>
