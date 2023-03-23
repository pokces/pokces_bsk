<%--
  Created by IntelliJ IDEA.
  User: Hlast
  Date: 2023/3/9
  Time: 16:17
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

    <title>点餐菜单</title>
    <script type="text/javascript" src="js/jquery1.12.4.min.js"></script>
    <script src="layer/layer.js" type="text/javascript"></script>
    <script type="text/javascript" src="js/jquery.fly.min.js" ></script>
    <script type="text/javascript" src="js/layui.js"></script>
    <!-- 兼容IE10 -->
    <script type="text/javascript" src="js/requestAnimationFrame.js" ></script>
    <script src="js/main.js" type="text/javascript"></script>
    <script type="text/javascript">
        function addCart(productid,userid,fly) {
            if(userid==''){
                show('', 550, 550, 'login.jsp');
            }else{
                $.post("ServletCart?m=addCart",{"productId":productid,"userId":userid},function (data) {
                    if(data=="Y"){
                        flyImg(fly)
                        getCart();
                        layer.msg("添加成功")
                    }else{
                        layer.msg("添加失败？")
                    }
                })
            }
        }
        function flyImg(fly) {
            var cartLeft = $('#cart_image').offset().left - $(document).scrollTop(); // 获取a标签距离屏幕顶端的距离(因为fly插件的start开始位置是根据屏幕可视区域x，y来计算的，而不是根据整个文档的x，y来计算的)
            var cartTop = $('#cart_image').offset().top; // 获取a标签的y坐标

            var btnLeft = $(fly).parent().find('img').offset().left - $(document).scrollTop()+20;
            var btnTop = $(fly).parent().find('img').offset().top+20;

            var img = $(fly).parent().find('img').attr('src');
            var flyer = $('<img class="u-flyer" src="'+img+'">');
            flyer.fly({
                start: {
                    left: btnLeft,
                    top: btnTop
                },
                end: {
                    left: cartLeft, //结束位置（必填）
                    top: cartTop, //结束位置（必填）
                    width: 0, //结束时宽度
                    height: 0 //结束时高度
                },
                onEnd: function(){ //结束回调
                    console.log('加入成功！');
                    this.destory(); //移除dom
                }
            });
        }
    </script>

</head>
<body style="background: #efeee9;">
<input type="hidden" id="pageName" value="customerCenter" />
<input type="hidden" id="morePrivilege" value="false" />
<form id="j-main-form" action="">
    <%@include file="top.jsp"%>
    <div class="m-main">
        <div class="m-menu fl">
            <ul id="typeul">
                <!-- 菜单 -->
                <li class=${requestScope.ultype==0?"on":""} >
                    <a href="ServletProduct?m=menuGetProduct&mode=all" > 当季特选</a>
                </li>
                <c:forEach items="${requestScope.allCategory}" var="i">
                    <li  class=${requestScope.ultype==i.categoryId?'on':''} id="extId${i.categoryId}" cn="${i.categoryName}" en="" >
                        <a href="ServletProduct?m=menuGetProduct&mode=${i.categoryId}"> ${i.categoryName}</a>
                    </li>
                </c:forEach>
            </ul>
        </div>
        <div class="m-menu-content fr" style="position: relative; top: 70px">
            <!-- 产品列表 -->
            <div style="height: 450px; display: none;"></div>
            <div class="m-product-list">
                <c:forEach items="${requestScope.allProduct}" var="i">
                    <div class="product" condid="0" style="background: #FFF">
                        <div class="img cursor">
                            <img src="${pageContext.request.contextPath}/upload/${i.productPic}" />
                        </div>
                        <div class="title">
                            ${i.productName}
                        </div>
                        <div class="desc grey">
                        </div>
                        <div style="user-select: none" class="order j-menu-order" onclick="addCart('${i.productId}','${sessionScope.loginuser.userId}',this)">
                            <div class="start ui-bgbtn-green">
                                +
                            </div>
                        </div>
                    </div>
                </c:forEach>
            <!-- /产品列表 -->
        </div>
    </div>
    </div>
    </div>

    <div class="m-foot">
        <div class="content">
            <div class="content-logo">

                <a href="#"><div class="logo"></div> </a>

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



            <div class="content-two clear">

                <div class="middle clear">
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
<script>
    $(document).ready(function () {
        $(".order").click(function(){


        })
    })
</script>
