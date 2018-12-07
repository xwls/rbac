<%@ page import="com.alibaba.fastjson.JSON" %>
<%@ page import="com.hwua.rbac.po.Auth" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>Title</title>
    <%@ include file="_css&js.jsp"%>
    <script type="text/javascript">
        $(function () {
            $("#tree").tree({
                url: "${path}/temp/tree_data1.json",
                onClick:function (node) {
                    if (!node.children){
                        //打开页面
                        var mainTabs = $("#main-tabs");
                        if (!mainTabs.tabs("exists",node.text)){
                            //添加tab
                            mainTabs.tabs("add",{
                                title:node.text,
                                content:"<iframe width='100%' height='100%' src='${path}"+node.url+"'/>",
                                closable: true
                            });
                        } else {
                            // 选中
                            mainTabs.tabs("select",node.text);
                        }

                    }
                }
            });
        });
    </script>
</head>
<body class="easyui-layout">
<div data-options="region:'north',border:false" style="height: 90px;;background:#B3DFDA;padding:10px">
    <h1 style="height: 50px;margin: 5px ;float: left">XXX权限管理系统</h1>
    <c:if test="${sessionScope.user != null}">
        <p style="font-size: 20px;float: right">欢迎${sessionScope.user.userName}&nbsp;&nbsp;
        <a href="${path}/logout" style="float: right">退出</a></p>
    </c:if>
</div>
<div data-options="region:'west',split:true,title:'功能模块'" style="width:150px;">
    <div class="easyui-accordion" data-options="fit:true">
        <%--<div title="XXX" style="overflow:auto;">
            <ul id="tree"></ul>
        </div>--%>
        <c:forEach items="${sessionScope.authList}" var="auth">
            <div title="${auth.text}" style="overflow:auto;">
                <ul id="tree-${auth.id}"></ul>
                <script type="text/javascript">
                    <%
                        Auth auth = (Auth) pageContext.getAttribute("auth");
                        String authJson = JSON.toJSONString(auth.getChildren());
                        pageContext.setAttribute("authJson",authJson);
                    %>
                    var treeData = '${authJson}';
                    treeData = JSON.parse(treeData);
                    $("#tree-${auth.id}").tree({
                        data:treeData,
                        onClick:function (node) {
                            if (node.children.length === 0){
                                //打开页面
                                var mainTabs = $("#main-tabs");
                                if (!mainTabs.tabs("exists",node.text)){
                                    //添加tab
                                    mainTabs.tabs("add",{
                                        title:node.text,
                                        content:"<iframe width='100%' height='100%' src='${path}"+node.authURL+"'/>",
                                        closable: true
                                    });
                                } else {
                                    // 选中
                                    mainTabs.tabs("select",node.text);
                                }

                            }
                        }
                    });
                </script>
            </div>
        </c:forEach>
    </div>
</div>
<div data-options="region:'center'" style="overflow: hidden">
    <div id="main-tabs" class="easyui-tabs"></div>
</div>
</body>
</html>
