<%--
  Created by IntelliJ IDEA.
  User: Hlast
  Date: 2023/3/17
  Time: 10:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript" src="js/handlebars.js"></script>
<div class="m-shopping" id="cart">
    <div class="m-cart">
        <div id="close">
            <img src="images/common/close.png" class="m-img"/>
        </div>
        <span> 我的购物盒</span>
        <a href="#" onclick="removeAll()">清空购物盒</a>
    </div>

<div id="containerCart" >
    <div id="templateCart" style="overflow-y: auto" type="text/x-handlebars-template">
        {{#each this}}
        <div class="border-bot eat" id="cart{{cartId}}">
            <div class=" eat-left fl">
                <img src="upload/{{productPic}}"/>
                <span>{{productName}}</span>
                <br/>
                <span class="login-redcolor">{{productPrice}}元</span>
            </div>
            <div class="fr  eat-right">
                <button class="cursor">
                    <img onclick="changeNum('{{cartId}}','-1')" src="images/common/minus-red.png"/>
                </button>
                <input type="text" id="inNum{{cartId}}" value="{{productNum}}" placeholder="{{productNum}}"/>
                <button class="cursor">
                    <img onclick="changeNum('{{cartId}}','+1')" src="images/common/plus-green.png"/>
                </button>
            </div>
        </div>
        {{/each}}
    </div>
</div>
    <div class="login-bgrcolor eat-bot" id="cart_show">

        <img src="images/menu/box.png" class="e-img"/>
        <span class="e-top login-redcolor" id="num"></span><strong class="e-title1">总计<span
            class="e-bigfont" id="cart_image"></span><a>元</a><span>（含9元外送费）</span>
    </strong>


        <button class="e-btn fr cu" >
            <a href="ServletOrder?m=jumpOrder">选好了 &gt;</a>
        </button>

    </div>
</div>
<script>
    var containerCart;
    //获取我们定义的模板的dom对象。主要是想获取里面的内容
    var templateCart;

    $(document).ready(function () {
        containerCart = $('#containerCart');
        templateCart = $('#templateCart');
        getCart();

    });
    // function jumpOrder() {
    //     $.ajaxSettings.async=false
    //     $.post('ServletOrder?m=jumpOrder')
    //     window.location.href="order_submit.jsp"
    //     $.ajaxSettings.async=true
    // }

    function changeNum(cart,num) {
        let cartnum=$("#inNum"+cart).val()
        if(cartnum==1&&num==-1){
            layer.confirm('确定要清空这件物品吗？', {
                btn: ['确定','取消'] //按钮
            }, function(){
                layer.msg('删除完毕成功');
                $.post("ServletCart?m=delcart",{"cartId":cart},function () {
                })
                $("#cart"+cart).remove()
            });
        }else{
            $.post("ServletCart?m=changeNum",{"cartId":cart,"num":num},function () {
            })
            let val = $("#inNum"+cart).val();
            val=parseInt(val)+parseInt(num)
            $("#inNum"+cart).val(val)
        }
    }
    function removeAll() {
        layer.confirm('确定要清空全部吗？', {
            btn: ['确定','取消'] //按钮
        }, function(){

            layer.msg('清空成功');
            $.post("ServletCart?m=removeAll",function () {
            })
            $("#containerCart").empty()
        });
    }

    //获取购物车数据
    function getCart() {
        $.get("ServletCart?m=getCart", function (data) {
            data = JSON.parse(data);
            let count = 9; //总金额
            let num = 0;  //餐品总数量

            for (let e of data) {
                count += e.productPrice * e.productNum;
                num += e.productNum;
            };


            count = Math.round(count * 100) / 100;

            $("#cart_image").html(count);
            $("#num").html(num);
            //编译模板的里的内容
            var template = Handlebars.compile(templateCart.html());
            //把后台获取到的数据渲染到页面
            containerCart.html(template(data));


        })
    }
</script>
