<%--
  Created by IntelliJ IDEA.
  User: Hlast
  Date: 2023/3/9
  Time: 17:19
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
    <title>订单管理</title>
    <script type="text/javascript"
            src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script src="layer/layer.js" type="text/javascript"></script>
    <script src="js/main.js" type="text/javascript"></script>
    <script type="text/javascript">
        function changetype(id,type) {
            let val = $("#modiftselect"+id).val();
            val=val=="已下单"?0:val=="配送中"?1:2;
            if(val!=type){

                $.post("ServletOrder?m=changeType",{"orderId":id,"type":val},function () {
                })
            }
        }
        function delList(id) {
            layer.confirm('确定要删除订单吗？', {
                btn: ['确定','取消'] //按钮
            }, function(){
                layer.msg('删除完毕');
                $("#list"+id).remove()
                $.post("ServletOrder?m=delOrder",{"orderid":id},function () {
                })
            });

        }
    </script>
</head>
<body>
<div class="m-main">
    <div class="m-food">
        <div class="mf-top border-t">
            <div class="fl">
                订单管理
            </div>
            <form action="ServletOrder?m=jumpOrderManage" method="post">
            <div class="fr">
                <input type="datetime-local" name="startTime" placeholder="下单时间" style="width: 100px;" />
                -
                <input type="datetime-local" name="endtime" placeholder="下单时间" style="width: 100px;" />
                -
                <select name="type" class="select" style="color: whitesmoke;width: 50px">
                    <option value="">全部的</option>
                    <option value="0">已下单</option>
                    <option value="1">配送中</option>
                    <option value="2">已完成</option>
                </select>
                -
                <input name="orderid"  placeholder="订单号" />
                <button type="submit">
                    查询
                </button>
            </div>
            </form>
        </div>
<div style="overflow-y: auto;height: 500px">
<c:forEach items="${requestScope.allOrderDto}" var="i">
        <div id="list${i.orderId}" class="mf-menu border-t"
             style="height: auto; line-height: normal; padding: 30px 0">
            <div class="fl">
                <span class="m-wt1" style="width: 10px"></span>
                <span>${i.orderId}</span>
                <span>${i.userName}</span>
                <span>${i.addTime}</span>
                <span>${i.updateTime}</span>
            </div>
            <div class="fr weiyi">
                <select onclick="changetype(${i.orderId},${i.orderType})" id="modiftselect${i.orderId}" style="color: whitesmoke;width: 50px" class="select">
                    <option  ${i.orderType==0?"selected":""} val="0" >已下单</option>
                    <option  ${i.orderType==1?"selected":""} val="1" >配送中</option>
                    <option  ${i.orderType==2?"selected":""} val="2" >已完成</option>
                </select>
                <button class="xiugai" style="padding: 10px" onclick="change('order${i.orderId}',1)">
                    详情
                </button>
                <button class="xiajia" style="padding: 10px" onclick="delList('${i.orderId}')">
                    删除
                </button>
            </div>
            <div id="update_order${i.orderId}" style="display: none;" class="change">
                <c:forEach items="${i.orderDetail}" var="d">
                <div class=" clear" style="padding: 20px 0">
                    <span class="m-wt1" style="width: 28px"></span>
                    <span></span>
                    <span class="sp sp-1">${d.productName}</span>
                    <span class="sp sp-2">${d.productNum}</span>
                    <span class="sp sp-3">${d.productMoney}</span>
                </div>
                </c:forEach>
            </div>
        </div>
</c:forEach>
</div>
    </div>
</div>
</body>
</html>
<SCRIPT Language=VBScript><!--

//--></SCRIPT>