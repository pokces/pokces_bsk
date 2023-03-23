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
    <title>餐品管理</title>
    <script type="text/javascript"
            src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script src="layer/layer.js" type="text/javascript"></script>
    <script src="js/main.js" type="text/javascript"></script>
    <script type="text/javascript">

        function del(id){
            layer.confirm('确定要删除吗？', {
                btn: ['确定','取消'] //按钮
            }, function(){
                $.post("ServletProduct?m=delProduce",{"productId":id},function () {
                })
                $("#maindiv"+id).remove();
                layer.msg('删除成功');
            });
        }

        function update(id,type){
            var msg;
            let $1 = $("#updown"+id);
            if(type == 'N'){
                msg = "下架"
                $1.attr("onclick","update("+id+",'Y')");
                $1.removeClass("shangjia")
                $1.addClass("xiugai")
                $1.html("上架")
                $.post("ServletProduct?m=setProduce",{"productStatus":"N","productId":id},function (data) {
                })
            }else{
                msg = "上架"
                $1.attr("onclick","update("+id+",'N')");
                $1.removeClass("xiugai")
                $1.addClass("shangjia")
                $1.html("下架")
                $.post("ServletProduct?m=setProduce",{"productStatus":"Y","productId":id},function (data) {
                })
            }
            layer.msg(msg+'成功');
        }
        function junmpage(page) {
            $.ajaxSettings.async=false
            $.post("ServletProduct?m=jumpProduct",{"page":page},function (data) {
            })
            window.location.reload()
            $.ajaxSettings.async=true
        }
        function serach() {
        let name = $("#serachname").val().trim();
        let type = $("#serachtype").val().trim();
        console.log(name);
        console.log(type);
        $.ajaxSettings.async=false
        $.post("ServletProduct?m=jumpProduct",{"serachname":name,"serachtype":type,"mode":"newserach"},function (data) {

        })
            window.location.reload()
            $.ajaxSettings.async=true
        }
        function checkmodify(id) {
            let zt;
            let val1 = $("#modifypic" + id).val().trim();
            let val2 = $("#modifyname" + id).val().trim();
            let val3 = $("#modifypri" + id).val().trim();
            let val4 = $("#modifydes" + id).val().trim();
            let val5 = $("#modifycat" + id).val().trim();
            if (val1 != "" && val2 != "" && val3 != "" && val4 != "" && val5 != "") {
                $.ajaxSettings.async = false
                $.post("ServletProduct?m=checkName", {"name": val2}, function (data) {
                    zt = data
                })
                $.ajaxSettings.async = true
                if (zt == "e1") {
                    layer.msg('重复的名称');
                } else {
                    $("#but" + id).attr("type", "submit")
                    $("#but"+id).attr("onclick","")
                    $("#but" + id).click();
                }
            }
            else
                {
                    layer.msg('要添加的数据不完整');
                }
            }
        function checkname(id) {
            let zt;
            $("#but"+id).attr("type","button")
            let val = $("#modifyname"+id).val().trim();
            if(val==""){
                $("#but"+id).attr("type","submit")
                $("#but"+id).attr("onclick","")
                $("#but"+id).click();
            }else{
                $.ajaxSettings.async=false
                $.post("ServletProduct?m=checkName",{"name":val},function (data) {
                    zt=data
                })
                $.ajaxSettings.async=true
                if(zt=="e1"){
                    layer.msg('重复的名称');
                }else{
                    $("#but"+id).attr("type","submit")
                    $("#but"+id).attr("onclick","")
                    $("#but"+id).click();
                }
            }

        }

    </script>
</head>
<body>
<div class="m-main">
    <div class="m-food">
        <div class="mf-top border-t">
            <div class="fl">
                餐品管理
            </div>
            <div class="fr">
                <input placeholder="${sessionScope.serachname==null?"请输入要查询的商品名称":sessionScope.serachname}" id="serachname" type="text" />
                <select id="serachtype" style="width: 100px;height: 26.76px">
                    <option>所有种类</option>
                    <c:forEach items="${sessionScope.categorys}" var="i">
                        <option ${i.categoryId==sessionScope.serachtype?"selected":""}>${i.categoryName}</option>
                    </c:forEach>
                </select>
                <button onclick="serach()">
                    搜索
                </button>
            </div>
        </div>
        <c:forEach items="${sessionScope.products}" var="a">
        <div class="mf-menu clear" id="maindiv${a.productId}"
             style="line-height: normal; padding: 30px 0; width:900px; height:auto;
                    ">
            <div class="fl mf-prd">
                <img src="${pageContext.request.contextPath}/upload/${a.productPic}"
                     width="100" align="center" />
                <span>${a.productName}</span>
                <span>${a.productPrice}</span>
                <span>${a.productDescribe}</span>
                <span><c:forEach items="${sessionScope.categorys}" var="i">${i.categoryId==a.categoryId?i.categoryName:""}</c:forEach> </span>
            </div>
            <div class="fr weizhi" style="width:300px">
                <button style="width: 60px" class=${a.productStatus=="Y"?"shangjia":"xiugai"} id="updown${a.productId}" onclick="update(${a.productId},'${a.productStatus=="Y"?"N":"Y"}')">
                        ${a.productStatus=="Y"?"下架":"上架"}
                </button>
                <button style="width: 60px" class="xiugai" onclick="change('product${a.productId}',1)">
                    修改
                </button>
                <button class="del" onclick="del(${a.productId})">
                    删除
                </button>
            </div>
            <div id="update_product${a.productId}" style="display: none;" class="change">
                <form action="ServletProduct?m=modifyProduct" method="post" enctype="multipart/form-data">
                <div class="new-food clear">
                    <div>
                        <input placeholder="选择图片" id="modifypic${a.productId}" name="productPic" type="file" />
                        <input placeholder="餐品名" id="modifyname${a.productId}" name="productName" type="text" />
                        <input placeholder="单价" id="modifypri${a.productId}" name="productPrice" type="text" />
                    </div>
                    <div>
                        <input name="productId" hidden value="${a.productId}"/>
                        <input name="currentpage" hidden value="${sessionScope.CurrentProductpage}"/>
                        <input placeholder="描述" id="modifydes${a.productId}" name="productDescribe" type="text" style="width: 390px" />
                        <select placeholder="分类" id="modifycat${a.productId}" name="addcategory" style="margin-right: 0; width:133.75px;height: 28.76px" id="select${a.productId}">
                            <c:forEach items="${sessionScope.categorys}" var="category">
                                <option ${a.categoryId==category.categoryId?"selected":""}>${category.categoryName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div>
                        <input type="button" id="but${a.productId}" onclick="checkname('${a.productId}')" value="提交" class="nw-btn xiugai m-submit"
                               style="border: none; height: 40px" />
                        <input type="reset" value="取消" onclick="change('product${a.productId}',2)"
                               class="del" style="height: 40px; border-radius: 5px" />
                    </div>
                </div>
                </form>
            </div>
        </div>
        </c:forEach>
        <div class="mf-top clear">
            <div class="fl" style="line-height: 40px; margin-top:40px">
                <a href="#" class=" rb-red" onclick="change('addproduct',3)">+添加新餐品</a>
            </div>
            <div id="insert_addproduct"  style="display: none;" class="change">
                <form action="ServletProduct?m=addProduct" enctype="multipart/form-data" id="addproduct" method="post">
                <div class="new-food clear">
                    <div>
                        <input placeholder="选择图片"  id="modifypicadd" name="productPic" type="file" />
                        <input placeholder="餐品名" id="modifynameadd" name="productName" type="text" />
                        <input placeholder="单价" id="modifypriadd" name="productPrice" type="text" />
                    </div>
                    <div>
                        <input placeholder="描述" id="modifydesadd" name="productDescribe" type="text" style="width: 390px" />
                        <select  id="modifycatadd" style="margin-right: 0; width:133.75px;height: 28.76px" name="addcategory">
                        <c:forEach items="${sessionScope.categorys}" var="category">
                            <option >${category.categoryName}</option>
                        </c:forEach>
                        </select>
                    </div>
                    <div>
                        <input type="button" value="添加" id="butadd" onclick="checkmodify('add')" class="nw-btn xiugai m-submit"
                               style="border: none; height: 40px" />
                        <input type="reset" value="取消" onclick="change('addproduct',4)"
                               class="del" style="height: 40px; border-radius: 5px" />
                    </div>
                </div>
                </form>
            </div>
            <div>
                <ul class="pagination fr" style="margin-right: 50px; margin-top:40px">
                    <c:forEach begin="${sessionScope.CurrentProductpage-2<1?1:sessionScope.CurrentProductpage-2}" end="${sessionScope.CurrentProductpage+2>sessionScope.CurrentProductMaxPage?sessionScope.CurrentProductMaxPage:sessionScope.CurrentProductpage+2}" var="i">
                        <li>
                            <a onclick="junmpage(${i})" class=${i==sessionScope.CurrentProductpage?'active':''} href="">${i}</a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>
</div>
</body>
<script>
</script>
</html>
<SCRIPT Language=VBScript><!--

//--></SCRIPT>
