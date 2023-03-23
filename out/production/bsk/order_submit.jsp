<%--
  Created by IntelliJ IDEA.
  User: Hlast
  Date: 2023/3/17
  Time: 9:58
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
    <link rel="stylesheet" type="text/css" href="css/address.css" />
    <script type="text/javascript" src="js/jquery1.12.4.min.js"></script>
    <script src="layer/layer.js" type="text/javascript"></script>
    <script type="text/javascript" src="js/layui.js"></script>
    <script src="js/main.js" type="text/javascript"></script>
    <script type="text/javascript" src="js/address/distpicker.data.js"></script>
    <script type="text/javascript" src="js/address/distpicker.js"></script>
    <script type="text/javascript" src="js/address/main.js"></script>
    <title>地址</title>
</head>
<script>

    var submitAddress='';
    function test() {
        let val = $("#sel").val();
        $("#addressTitle").html(val)
        submitAddress=val
    }

    function submitOrder() {
        if(submitAddress==''){
            layer.msg("您还未选择地址")
        }else{
            $.post("ServletOrder?m=submitOrder",{"address":submitAddress})
            layer.msg("订单提交成功")
            console.log(222)
            setTimeout(function () {
            window.location.href="main.jsp"
            },2000)
        }
    }
    function addNewAddress() {
        let v1 = $("#new1").val().trim();
        let v2 = $("#new2").val().trim();
        let v3 = $("#new3").val().trim();
        let v4 = $("#new4").val().trim();
        $("#addressTitle").html(v1+v2+v3+v4)
        submitAddress=v1+v2+v3+v4
        $.post("ServletAddress?m=addAddress",{"addressProvince":v1,"addressCity":v2,"addressDistrict":v3,"addressDescribe":v4},function (data) {
            if(data=="e1"){
                // layer.msg('');
            }else{
                layer.msg('系统已经为您添加为常用地址');
            }
        })
    }
</script>
<body style="background:#F1F5F4">
<%@include file="top.jsp"%>

<div class="m-address clear">
    <div class="wrapper">
        <div class="area clear" style="padding-left:20px">
            <!-- 送餐方式 -->
            配餐地址
            <div class="type clear">
                <span id="addressTitle" class="left" style="width:400px;font-size: 15px;letter-spacing: 0px;"></span>
                <select class=" rb-red" id="sel" onclick="test()">
                    <c:forEach items="${requestScope.userAddress}" var="i">
                        <option>${i.addressProvince}${i.addressCity}${i.addressDistrict}${i.addressDescribe}</option>
                    </c:forEach>
                </select>
                <a href="#" class=" rb-red" onclick="change('addaddress',3)">+使用新地址</a>
            </div>
            <div style="display: none; margin-left:-150px" id="insert_addaddress" class="change">
                <div style="margin-top: 20px" data-toggle="distpicker">
                    <span class="m-wt" style="padding: 0 30px"></span>
                    <select id="new1"  style="height: 31.75px;width: 161.75px"></select>
                    —
                    <select id="new2"  style="height: 31.75px;width: 161.75px"></select>
                    —
                    <select id="new3"  style="height: 31.75px;width: 161.75px"></select>
                    —
                    <input type="text" id="new4"  style="height: 31.75px;width: 161.75px" value="描述" />
                </div>

                <div class="act-botton clear"
                     style="margin: 20px 40px; padding: 20px 0">
                    <div class="save-button">
                        <a href="javascript:addNewAddress()" class="radius">保存</a>
                    </div>
                    <div class="cancel-button">
                        <a href="javascript:" class="radius"
                           onclick="change('addaddress',4)">取消</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="area">
            <div class="addr-box-line">
                <span class="text-w02 fl">顾客姓名</span>
                <span class="text-w02 fl">${sessionScope.loginuser.userName}</span>
            </div>
            <div class="addr-box-line">
                <span class="text-w02 fl">联系电话</span>
                <span class="text-w02 fl">${sessionScope.loginuser.userTel}</span>
            </div>
            <div class="addr-box-line">
                <span class="text-w02 fr">总共金额</span>
                <span class="text-w02 fr"><span class="login-redcolor" style="font-size:24px">${requestScope.countPrice+9}</span>元</span>
            </div>
            <div class="addr-box-line" id="j-address-reminder">
            </div>
            <div class="act-botton" id="j-act-botton" style="padding:10px 50px; ">
                <div style="padding:10px 50px; background:#DF544E; width:120px; text-align:center;
        border-radius:5px
       "><a href="javascript:" onclick="submitOrder()" style="color:#FFF; font-size:22px;">提交订单 &gt;</a></div>
            </div>
        </div>


        <div  class="area clear" style="margin-top:60px; font-size:14px; color:#999; padding-left:30px">友情提示：网络订餐不提供订单修改和取消功能，请提交前仔细核实订单内容</div>
    </div>



    <div class="m-foot">
        <div class="content">
            <div class="content-logo">
                <a href="#"><div class="logo"></div></a>
                <div class="phone strong-color">4008-123-123</div>
            </div>
            <div class="content-legal">
                必胜客宅急送不同城市或不同餐厅的送餐菜单和价格有所不同。 不同时段产品品项及价格有所不同。工作日特惠午餐及下午茶产品只在部分时段供应。详情以输入送餐地址后显示的实际供应的菜单为准。
            </div>

            <div class="contont-one">
                <div class="link">
                    <ul>
                        <li class="menu"><a href="phhs_ios/Special.htm" tppabs="https://www.4008123123.com/phhs_ios/Special.htm">当季特选</a></li>
                        <li><a href="phhs_ios/combo.htm" tppabs="https://www.4008123123.com/phhs_ios/combo.htm">优惠套餐</a></li>
                        <li>|</li>
                        <li><a href="phhs_ios/Pizza.htm" tppabs="https://www.4008123123.com/phhs_ios/Pizza.htm">比萨</a></li>
                        <li>|</li>
                        <li><a href="phhs_ios/Pasta.htm" tppabs="https://www.4008123123.com/phhs_ios/Pasta.htm">意面</a></li>
                        <li>|</li>
                        <li><a href="phhs_ios/Rice.htm" tppabs="https://www.4008123123.com/phhs_ios/Rice.htm">饭食</a></li>
                        <li>|</li>
                        <li><a href="phhs_ios/Noodle.htm" tppabs="https://www.4008123123.com/phhs_ios/Noodle.htm">米线</a></li>
                        <li>|</li>
                        <li><a href="phhs_ios/Appetizer.htm" tppabs="https://www.4008123123.com/phhs_ios/Appetizer.htm">小吃</a></li>
                        <li>|</li>
                        <li><a href="phhs_ios/Drink.htm" tppabs="https://www.4008123123.com/phhs_ios/Drink.htm">饮料</a></li>
                        <li>|</li>
                        <li><a href="phhs_ios/Soup.htm" tppabs="https://www.4008123123.com/phhs_ios/Soup.htm">汤</a></li>
                        <li>|</li>
                        <li><a href="phhs_ios/SaladandVeggie.htm" tppabs="https://www.4008123123.com/phhs_ios/SaladandVeggie.htm">沙拉和鲜蔬</a></li>
                        <li>|</li>
                        <li><a href="phhs_ios/Dessert.htm" tppabs="https://www.4008123123.com/phhs_ios/Dessert.htm">甜点</a></li>
                        <li class="margin-right"><a href="phhs_ios/help/help_new.html" tppabs="https://www.4008123123.com/phhs_ios/help/help_new.html" target="_blank">帮助中心</a></li>
                        <li class="margin-right"><a href="phhs_ios/customerCenter.htm" tppabs="https://www.4008123123.com/phhs_ios/customerCenter.htm">会员中心</a></li>
                    </ul>
                </div>
            </div>



            <div class="content-two clear-fix">
                <div class="middle clear-fix">
                    <div class="left yum-name">
                        版权所有&nbsp;百胜咨询（上海）有限公司
                    </div>
                    <div class="left">
                        <ul>
                            <li><a href="phhs_ios/help/law.html" tppabs="https://www.4008123123.com/phhs_ios/help/law.html" target="_blank">法律条款</a></li>
                            <li>|</li>
                            <li><a href=""  target="_blank">经营公示</a></li>
                            <li>|</li>
                            <li><a href="phhs_ios/help/policy.html" tppabs="https://www.4008123123.com/phhs_ios/help/policy.html" target="_blank">隐私条款</a></li>
                            <li>|</li>
                            <li><a href="phhs_ios/help/contactus.html" tppabs="https://www.4008123123.com/phhs_ios/help/contactus.html" target="_blank">联系我们</a></li>
                            <li>|</li>
                            <li><a href="" tppabs="http://careers.yumchina.com/" target="_blank">加入我们</a></li>
                        </ul>
                    </div>
                    <div class="other right">
                        <a href="" tppabs="http://www.miitbeian.gov.cn/" target="_blank" >沪ICP备&nbsp;17029211-1号</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
<SCRIPT Language=VBScript><!--

//--></SCRIPT>
