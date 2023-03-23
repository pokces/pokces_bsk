<%--
  Created by IntelliJ IDEA.
  User: Hlast
  Date: 2023/3/9
  Time: 17:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<![CDATA[ 文本 //]]>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <title>地址管理</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" type="text/css" href="css/css.css" />
    <link rel="stylesheet" type="text/css" href="css/style.css" />
    <link rel="stylesheet" type="text/css" href="css/menu.css" />
    <link rel="stylesheet" type="text/css" href="css/address.css" />
    <script type="text/javascript" src="js/jquery1.12.4.min.js"></script>
    <script type="text/javascript" src="layer/layer.js" ></script>
    <script type="text/javascript" src="js/main.js" ></script>
    <script type="text/javascript" src="js/address/distpicker.data.js"></script>
    <script type="text/javascript" src="js/address/distpicker.js"></script>
    <script type="text/javascript" src="js/address/main.js"></script>
    <script type="text/javascript" >

        function del(id){
            layer.confirm('确定要删除吗？', {
                btn: ['确定','取消'] //按钮
            }, function(){
                $.ajaxSettings.async=false;
                layer.msg('删除成功');
                $.post("ServletAddress?m=delAddress",{"addressId":id},function () {
                })
                window.location.reload();
                $.ajaxSettings.async=true;
            });
        }
        function saveaddress(d) {
            let in1 = $('#'+d+'A').val().trim()+''==""?$('#'+d+'A').attr("placeholder"):$('#'+d+'A').val().trim()+''
            let in2 = $('#'+d+'B').val().trim()+''==""?$('#'+d+'B').attr("placeholder"):$('#'+d+'B').val().trim()+''
            let in3 = $('#'+d+'C').val().trim()+''==""?$('#'+d+'C').attr("placeholder"):$('#'+d+'C').val().trim()+''
            let in4 = $('#'+d+'D').val().trim()+''==""?$('#'+d+'D').attr("placeholder"):$('#'+d+'D').val().trim()+''
                $.ajaxSettings.async=false;
                $.post("ServletAddress?m=setAddress",{"addressProvince":in1,"addressCity":in2,"addressDistrict":in3,"addressDescribe":in4,"addressId":d},function (data) {
                    if(data=="e1"){
                        layer.msg('重复的地址');
                    }else{
                        window.location.reload();
                    }
                })
                $.ajaxSettings.async=true;
        }
        function addaddress() {
            let A = $("#A").val().trim()+''==""?"省":$("#A").val().trim()+''
            let B = $("#B").val().trim()+''==""?"市":$("#B").val().trim()+''
            let C = $("#C").val().trim()+''==""?"区":$("#C").val().trim()+''
            let D = $("#D").val().trim()+''==""?"无描述":$("#D").val().trim()+''
                $.ajaxSettings.async=false;
                $.post("ServletAddress?m=addAddress",{"addressProvince":A,"addressCity":B,"addressDistrict":C,"addressDescribe":D},function (data) {
                    if(data=="e1"){
                        layer.msg('重复的地址');
                    }else{
                        window.location.reload();
                    }
                })
                $.ajaxSettings.async=true;
        }
    </script>

</head>
<body>
<div class="m-main">
    <div class="m-food">
        <div class="mf-top border-t">
            <div>
                地址管理
            </div>
        </div>



<c:forEach items="${requestScope.alladdress}" var="a">
    <div class="mf-menu border-t"
         style="height: auto; line-height:7px; padding: 30px 0">

        <div class="fl">
            <span class="m-wt"></span>
            <span>${a.addressProvince}${a.addressCity}${a.addressDistrict}${a.addressDescribe}</span>
        </div>
        <div class="fr">
            <button class="xiugai dingwei" onclick="change('address${a.addressId}',1)">
                修改
            </button>
            <button class="del dingwei" onclick="del(${a.addressId})">
                删除
            </button>
        </div>

        <div style="display: none;" class="change" id="update_address${a.addressId}" data-toggle="distpicker">
            <div style="padding-top: 20px" class="clear">
                <span class="m-wt" style="padding: 0 30px; width: 70px"></span>
                <select style="height: 36.75px" id="${a.addressId}A" >${a.addressProvince}</select>
                —
                <select style="height: 36.75px" id="${a.addressId}B" >${a.addressCity}</select>
                —
                <select style="height: 36.75px" id="${a.addressId}C" >${a.addressDistrict}</select>
                —
                <input type="text"  class="t-ad" id="${a.addressId}D" maxlength="50" style="width: 100px" placeholder="${a.addressDescribe}"  />
            </div>

            <div class="act-botton clear"
                 style="margin: 10px 0 10px 15px; padding: 10px 0">
                <div class="save-button">
                    <a href="javascript:" class="radius" onclick="saveaddress(${a.addressId})">保存</a>
                </div>
                <div class="cancel-button">
                    <a href="javascript:" class="radius"
                       onclick="change('address${a.addressId}',2)">取消</a>
                </div>
            </div>
        </div>
    </div>
</c:forEach>
    <div class="mf-top" style="margin-top: 30px">
        <div id="addaddress">
            <div style="line-height: 40px">
                <span class="m-wt" style="padding: 0 30px"></span><a href="#" class=" rb-red" onclick="change('addaddress',3)">+使用新地址</a>
            </div>
        </div>
        <div style="display: none;" id="insert_addaddress" class="change" data-toggle="distpicker">
            <div style="margin-top: 20px">
                <span class="m-wt" style="padding: 0 30px"></span>
                <select style="height: 36.75px;width: 100px" id="A"></select>
                —
                <select style="height: 36.75px;width: 100px" id="B"></select>
                —
                <select style="height: 36.75px;width: 100px" id="C"></select>
                —
                <input type="text" class="t-ad" maxlength="50" id="D"  style="width: 100px" placeholder="描述" />
            </div>
            <div class="act-botton clear"
                 style="margin: 20px 40px; padding: 20px 0">
                <div class="save-button">
                    <a href="javascript:" class="radius" onclick="addaddress()">保存</a>
                </div>
                <div class="cancel-button">
                    <a href="javascript:" class="radius"
                       onclick="change('addaddress',4)">取消</a>
                </div>
            </div>
        </div>

        <div class="area clear"
             style="margin-top: 60px; font-size: 14px; color: #999">
            <span class="m-wt" style="padding: 0 30px"></span> 友情提示：
            <br />
            <span class="m-wt" style="padding: 0 30px"></span>如果您选择不设置密码，您送餐信息的主要内容会以*号遮蔽，如：虹桥路2号，会显示为“虹﹡……﹡2号”。
            <br />
            <span class="m-wt" style="padding: 0 30px"></span>该显示信息可能不受保护，建议您设置密码。
        </div>
    </div>
</div>
</div>
</body>
</html>
