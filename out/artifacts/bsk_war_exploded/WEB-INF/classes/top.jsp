<%--
  Created by IntelliJ IDEA.
  User: Hlast
  Date: 2023/3/9
  Time: 16:08
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link  rel="shortcut icon"type="text/html" href="#"/>
<link rel="stylesheet" type="text/css" href="css/layui.css" />
    <script>
        layui.use('dropdown', function(){
            var dropdown = layui.dropdown
            dropdown.render({
                elem: '#login-out' //可绑定在任意元素中，此处以上述按钮为例
                ,data: [{
                    title: '用户信息'
                    ,id: 100
                    ,href: 'member.jsp'
                },{
                    title: '退出登录'
                    ,id: 101
                    ,href: 'ServletUser?m=loginout' //开启超链接
                    ,target: '_blank' //新窗口方式打开
                }]

                ,id: 'login-out'
                //菜单被点击的事件
                ,click: function(obj){

                    console.log(obj);
                    layer.msg('回调返回的参数已显示再控制台');
                }
            });
        });
        // function jumpmenu() {
        //     console.log("123")
        //     $.post("ServletProduct?m=menuGetProduct",{"mode":"all"},function () {
        //
        //     })
        // }
    </script>
</head>

<body>
<div class="m-top">
    <div class="box" id="j-top-nav" >
        <a href="main.jsp" ><div class="logo fl"></div> </a>
        <a href="ServletProduct?m=menuGetProduct&mode=all"><div class="menu fl" style="width:100px">
            菜单
        </div> </a>
        <div class="separator fl"></div>
        <a href="member.jsp" <%=request.getSession().getAttribute("loginuser")==null?"hidden":"" %> ><div class="menu fl" style="width:100px">
            会员中心
        </div> </a>
        <input type="hidden" id="j-is-login" value="false" />
        <div class="clien fl"><span id="login-out">${sessionScope.loginuser.userName}<img src="images/common/arrow-down.png" align="center" /></span></div>
        <div class="start fr" id="j-start-order"
             onclick="show('',550,550,'login.jsp')">
            立即点餐
        </div>
        <input type="hidden" id="isMemberLogin" value="" />
        <input type="hidden" id="isNewLogin" value="" />
        <input type="hidden" id="j-is-index" value="true" />
        <input type="hidden" id="j-has-order" value="false" />
        <input type="hidden" id="j-order-type" name="orderType" value="null" />
        <input type="hidden" id="j-defaultClassHtmlName" value="Special.htm" />
        <input type="hidden" id="j-username-afterlogin" value="" />

    </div>
</div>
</body>

