<%--
  Created by IntelliJ IDEA.
  User: Hlast
  Date: 2023/3/9
  Time: 17:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <title>分类管理</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" type="text/css" href="css/css.css" />
    <link rel="stylesheet" type="text/css" href="css/style.css" />
    <link rel="stylesheet" type="text/css" href="css/menu.css" />
    <link rel="stylesheet" type="text/css" href="css/address.css" />
    <script src="js/jquery1.12.4.min.js" type="text/javascript"></script>
    <script src="layer/layer.js" type="text/javascript"></script>
    <script src="js/main.js" type="text/javascript"></script>
    <script type="text/javascript">

        function del(id){
            layer.confirm('确定要删除吗？', {
                btn: ['确定','取消'] //按钮
            }, function(){
                $.ajaxSettings.async=false
                $.post("ServletCategory?m=delCategory",{"id":id},function (data) {
                    if(data=="e1"){
                        layer.msg("该分类下存在商品无法删除", {
                            offset: 't',
                            anim: 6
                        });
                    }else{
                        window.location.reload()
                    }

                })

                $.ajaxSettings.async=true
            });
        }
        function save(id) {
            let name=$('#name'+id).val().trim()+''==""? $('#name'+id).attr("placeholder"):$('#name'+id).val().trim()+ '';
            console.log(name)
            $.ajaxSettings.async=false
            console.log(id)
            $.post("ServletCategory?m=modifyCategory",{"categoryId":id,"categoryName":name},function (data) {
                if(data=="e1"){
                    layer.msg('重复的种类');
                }else{
                    window.location.reload()
                }
            })

            $.ajaxSettings.async=true
        }
        function add() {
            let val = $("#addname").val().trim();
            if (val!=""){
                $.ajaxSettings.async=false
                $.post("ServletCategory?m=addCategory",{"categoryName":val},function (data) {
                    if(data==""){
                        window.location.reload()
                    }else{
                        layer.msg(data, {
                            offset: 't',
                            anim: 6
                        });
                    }
                })
                $.ajaxSettings.async=true
            }else{
                layer.msg("请不要输入空值", {
                    offset: 't',
                    anim: 6
                });
            }
        }
    </script>
</head>
<body>
<div class="m-main">
    <div class="m-food">
        <div class="mf-top border-t">
            <div>
                分类管理
            </div>
        </div>
        <c:forEach items="${sessionScope.allCategory}" var="category">
        <div class="mf-menu border-t"
             style="height: auto; line-height: normal; padding: 30px 0">

            <div class="fl">
                <span class="m-wt"></span>
                <span>${category.categoryName}</span>
            </div>
            <div class="fr  dingwei">
                <button class="xiugai"  onclick="change('category${category.categoryId}',1)">
                    修改
                </button>
                <button class="del" onclick="del(${category.categoryId})">
                    删除
                </button>
            </div>

            <div id="update_category${category.categoryId}" style="display: none;" class="change">
                <div style="padding-top: 20px" class="clear">
                    <span class="m-wt" style="padding: 0 30px; width: 70px"></span>
                    <input type="text" class="t-ad" maxlength="20" id="name${category.categoryId}" style="width: 150px" placeholder="${category.categoryName}" />
                </div>

                <div class="act-botton clear"
                     style="margin: 10px 0 10px 15px; padding: 10px 0">
                    <div class="save-button">
                        <a href="javascript:" class="radius" onclick="save(${category.categoryId})">保存</a>
                    </div>
                    <div class="cancel-button">
                        <a href="javascript:" class="radius"
                           onclick="change('category${category.categoryId}',2)">取消</a>
                    </div>
                </div>
            </div>
        </div>
        </c:forEach>
        <div class="mf-top" style="margin-top: 30px">
            <div id="addcategory">
                <div style="line-height: 40px">
                    <span class="m-wt" style="padding: 0 20px"></span><a href="#" class=" rb-red" onclick="change('addcategory',3)">+添加新分类</a>
                </div>
            </div>
            <div id="insert_addcategory" style="display: none;" class="change">
                <div style="padding-top: 20px" class="clear">
                    <span class="m-wt" style="padding: 0 30px; width: 70px"></span>
                    <input type="text" id="addname" maxlength="20" class="t-ad" style="width: 150px"
                           placeholder="请输入分类名称" />
                </div>

                <div class="act-botton clear"
                     style="margin: 10px 0 10px 15px; padding: 10px 0">
                    <div class="save-button">
                        <a href="javascript:" onclick="add()" class="radius">保存</a>
                    </div>
                    <div class="cancel-button">
                        <a href="javascript:" class="radius"
                           onclick="change('addcategory',4)">取消</a>
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
