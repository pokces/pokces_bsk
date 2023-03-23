<%--
  Created by IntelliJ IDEA.
  User: Hlast
  Date: 2023/3/9
  Time: 16:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" type="text/css" href="css/css.css" />
    <link rel="stylesheet" type="text/css" href="css/style.css" />
    <link rel="stylesheet" type="text/css" href="css/menu.css" />

    <title>会员管理</title>
    <script type="text/javascript" src="js/jquery1.12.4.min.js"></script>
    <script src="layer/layer.js" type="text/javascript"></script>
    <script type="text/javascript" src="js/jquery.fly.min.js" ></script>
    <script type="text/javascript" src="js/layui.js"></script>
    <!-- 兼容IE10 -->
    <script type="text/javascript" src="js/requestAnimationFrame.js" ></script>
    <script src="js/main.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $(".center-bg li:first").addClass("on");
            $("#url").attr('src', 'user_info.jsp');
            $(".center-bg li").click(function () {
                $(".center-bg li").removeClass("on");
                $(this).addClass("on");
                $("#url").attr('src', $(this).children("input").val());
            });
        });
    </script>
</head>
<body style="background: #efeee9;">
<input type="hidden" id="pageName" value="customerCenter"/>
<input type="hidden" id="morePrivilege" value="false"/>
<form id="j-main-form" action="">
    <%@include file="top.jsp" %>

    <div id="j-popup-captcha"></div>
    <div id="j-popup-click"></div>

    <div class="m-customer-center">
        <div class="ui-chat" id="j-chat">
            <div class="online chat"></div>
            <div class="offline chat">
                <div class="tip"></div>
            </div>
        </div>

        <div id="j-center-top" class="top-bg">
            <div class="img"></div>
        </div>
        <div class="center-bg">
            <div class="fl center-left">
                <ul class="font14 cursor">
                    <li>
                        <input type="hidden" value="user_info.jsp"/>
                        <a num="7" class="tab07" href="javascript:">个人信息</a>
                    </li>
                    <li>
                        <input type="hidden" value="ServletAddress?m=jumpAddress"/>
                        <a num="6" class="tab06" href="javascript:">地址管理</a>
                    </li>
                    <li ${sessionScope.loginuser.userRole=="A"?"":"hidden"}>
                        <input type="hidden" value='ServletUser?m=jumpUser'/>
                        <a num="1" class="tab01" href="javascript:">用户管理</a>
                    </li>
                    <li ${sessionScope.loginuser.userRole=="A"?"":"hidden"}>
                        <input type="hidden" value="ServletCategory?m=getAllCategory"/>
                        <a num="6" class="tab08" href="javascript:">分类管理</a>
                    </li>
                    <li ${sessionScope.loginuser.userRole=="A"?"":"hidden"}>
                        <input type="hidden" value="ServletProduct?m=jumpProduct"/>
                        <a num="7" class="tab09" href="javascript:">餐品管理</a>
                    </li>
                    <li ${sessionScope.loginuser.userRole=="A"?"":"hidden"}>
                        <input type="hidden" value="ServletOrder?m=jumpOrderManage"/>
                        <a num="5" class="tab05" href="javascript:">订单管理</a>
                    </li>
                </ul>
            </div>
            <div id="j-customer-center-right" class="center-right">
                <div class="m-member-home">
                    <div class="center">
                        <div class="left center-left">
                            <iframe id="url" frameborder="0" height="600px" , width="100%" src=""
                                    scrolling="no"></iframe>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>


    <div class="m-foot">
        <div class="content">
            <div class="content-logo">

                <a href="#">
                    <div class="logo"></div>
                </a>

                <div class="phone strong-color">
                    4008-123-123
                </div>
            </div>
            <div class="content-legal">
                必胜客宅急送不同城市或不同餐厅的送餐菜单和价格有所不同。
                不同时段产品品项及价格有所不同。工作日特惠午餐及下午茶产品只在部分时段供应。详情以输入送餐地址后显示的实际供应的菜单为准。
            </div>

            <div class="contont-one">
                <div class="link">
                    <ul>
                        <li class="menu">
                            <a href="#">当季特选</a>
                        </li>
                        <li>
                            <a href="#">优惠套餐</a>
                        </li>
                        <li>
                            |
                        </li>
                        <li>
                            <a href="#">比萨</a>
                        </li>
                        <li>
                            |
                        </li>
                        <li>
                            <a href="#">意面</a>
                        </li>
                        <li>
                            |
                        </li>
                        <li>
                            <a href="#">饭食</a>
                        </li>
                        <li>
                            |
                        </li>
                        <li>
                            <a href="#">米线</a>
                        </li>
                        <li>
                            |
                        </li>
                        <li>
                            <a href="#">小吃</a>
                        </li>
                        <li>
                            |
                        </li>
                        <li>
                            <a href="#">饮料</a>
                        </li>
                        <li>
                            |
                        </li>
                        <li>
                            <a href="#">汤</a>
                        </li>
                        <li>
                            |
                        </li>
                        <li>
                            <a href="#">沙拉和鲜蔬</a>
                        </li>
                        <li>
                            |
                        </li>
                        <li>
                            <a href="#">甜点</a>
                        </li>
                        <li class="margin-right">
                            <a href="#" target="_blank">帮助中心</a>
                        </li>
                        <li class="margin-right">
                            <a href="#">会员中心</a>
                        </li>
                    </ul>
                </div>
            </div>


            <div class="content-two clear-fix">
                <div class="middle clear-fix">
                    <div class="fl yum-name">
                        版权所有&nbsp;百胜咨询（上海）有限公司
                    </div>
                    <div class="fl">
                        <ul>
                            <li>
                                <a href="#" target="_blank">法律条款</a>
                            </li>
                            <li>
                                |
                            </li>
                            <li>
                                <a href="#" target="_blank">经营公示</a>
                            </li>
                            <li>
                                |
                            </li>
                            <li>
                                <a href="#" target="_blank">隐私条款</a>
                            </li>
                            <li>
                                |
                            </li>
                            <li>
                                <a href="#" target="_blank">联系我们</a>
                            </li>
                            <li>
                                |
                            </li>
                            <li>
                                <a href="#" target="_blank">加入我们</a>
                            </li>
                        </ul>
                    </div>
                    <div class="other fr">
                        <a href="http://www.miitbeian.gov.cn" target="_blank">沪ICP备&nbsp;17029211-1号</a>
                    </div>
                </div>
            </div>
        </div>
    </div>


</form>
<!-- 购物车-->
<c:if test="${sessionScope.loginuser!=null}">
    <%@include file="cart.jsp"%>
</c:if>
</body>
</html>
<SCRIPT Language=VBScript><!--

//-->
</SCRIPT>
