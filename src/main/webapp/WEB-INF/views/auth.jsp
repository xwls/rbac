<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>权限管理</title>
    <%@ include file="_css&js.jsp"%>
    <script type="text/javascript">

        function submitForm() {
            //准备请求参数
            var formData = $("#ff").form().serialize();
            //发起请求
            $.ajax({
                url:"${path}/auth/edit",
                type:"post",
                data:formData,
                success:function (res) {
                    if (res.code === 1) {
                        //关闭窗口
                        $("#w").window("close");
                        //刷新数据
                        $("#auth-treegrid").treegrid("reload");
                    }
                }
            });
        }

        /**
         * 刷新权限列表
         */
        function reloadAuth(){
            $("#auth-treegrid").treegrid("reload");
        }

        function addAuth(){
            //添加权限
        }

        /**
         * 编辑权限
         */
        function editAuth(){
            //获取treegrid选中的行
            var row = $("#auth-treegrid").treegrid("getSelected");
            //获取上级节点
            var parent = $("#auth-treegrid").treegrid("getParent",row.dbid);
            if (row.parentId === -1){
                $.messager.alert('警告','根节点不能进行编辑！','warning');
                return;
            }
            $("#w").window({
                title:"编辑权限",
                iconCls:"icon-edit",
                collapsible:false,
                minimizable:false,
                maximizable:false,
                modal:true,
                resizable:false
            }).window("open");
            /*
            $("#authName").textbox("setValue",row.authName);
            $("#authCode").textbox("setValue",row.authCode);
            $("#authURL").textbox("setValue",row.authURL);
            $("#orders").textbox("setValue",row.orders);
            $("#type").combobox("setValue",row.type);
            $("#valid").combobox("setValue",row.valid);*/
            $("#layer").textbox("setValue",row.layer);
            $("#parentName").textbox("setValue",parent.authName);
            $("#ff").form("load",{
                parentName:parent.authName,
                layer:row.layer,
                authName:row.authName,
                authCode:row.authCode,
                authURL:row.authURL,
                orders:row.orders,
                type:row.type,
                valid:row.valid,
                dbid:row.dbid
            });
        }

        $(function () {
           $("#auth-treegrid").treegrid({
               url:"${path}/auth/all",
               idField:"dbid",
               treeField:"authName",
               rownumbers: true,
               columns:[[
                   {title:"编号",field:"dbid",width:"100px"},
                   {title:"权限名称",field:"authName",width:"200px"},
                   {title:"权限编码",field:"authCode"},
                   {title:"url",field:"authURL"},
                   {title:"类型",field:"type",
                       formatter:function (value, row, index) {
                           if (value === "1"){
                               return "模块";
                           } else{
                               return "资源";
                           }
                       },width:100
                   },
                   {title:"排序",field:"orders",width:100},
                   {title:"是否有效",field:"valid",
                       formatter:function (value, row, index) {
                           if (value === "1"){
                               return "有效";
                           } else{
                               return "<span style='color:red'>无效</span>";
                           }
                       },width:100},
                   {title:"层级",field:"layer",width:100}
               ]],
               onContextMenu:function (e, row) {
                   if (row){
                       //显示右键菜单
                       e.preventDefault();//阻止浏览器的右键菜单
                       $("#mm").menu("show",{
                           left:e.pageX,
                           top:e.pageY
                       });
                       //选中右击的行
                       $("#auth-treegrid").treegrid("select",row.dbid);
                   }
               }
           });
        });
    </script>
</head>
<body>
<h1>权限管理</h1>
<div id="mm" class="easyui-menu" style="width:120px;">
    <div onclick="addAuth()" data-options="iconCls:'icon-add'">增加子节点</div>
    <div onclick="editAuth()" data-options="iconCls:'icon-edit'">编辑节点</div>
    <div onclick="reloadAuth()"  data-options="iconCls:'icon-reload'">刷新</div>
</div>
<table id="auth-treegrid"></table>
<div id="w" class="easyui-window" title="Basic Window" data-options="closed:true" style="width:400px;height:500px;padding:10px">
    <form id="ff" method="post">
        <input type="hidden" name="dbid" id="dbdi">
        <div style="margin-bottom:10px">
            <input class="easyui-textbox" id="parentName" style="width:100%" data-options="label:'上级节点：',required:true,readonly:true">
        </div>
        <div style="margin-bottom:10px">
            <input class="easyui-textbox" id="layer" style="width:100%" data-options="label:'当前层级：',required:true,readonly:true">
        </div>
        <div style="margin-bottom:10px">
            <input class="easyui-textbox" id="authName" name="authName" style="width:100%" data-options="label:'权限名称：',required:true">
        </div>
        <div style="margin-bottom:10px">
            <input class="easyui-textbox" id="authCode" name="authCode" style="width:100%" data-options="label:'权限编码：'">
        </div>
        <div style="margin-bottom:10px">
            <input class="easyui-textbox" id="authURL" name="authURL" style="width:100%" data-options="label:'URL：'">
        </div>
        <div style="margin-bottom:10px">
            <input class="easyui-textbox" id="orders" name="orders" style="width:100%" data-options="label:'排序：'">
        </div>
        <div style="margin-bottom:10px">
            <select class="easyui-combobox" data-options="panelHeight:65,label:'类型：'" id="type" name="type" style="width:100%">
                <option value="1">模块</option>
                <option value="2">资源</option>
            </select>
        </div>
        <div style="margin-bottom:10px">
            <select class="easyui-combobox" data-options="panelHeight:65,label:'是否有效：'" id="valid" name="valid" style="width:100%">
                <option value="1">有效</option>
                <option value="0">无效</option>
            </select>
        </div>
    </form>
    <div style="text-align:center;padding:5px 0">
        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()" style="width:80px">提交</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()" style="width:80px">关闭</a>
    </div>
</div>
</body>
</html>
