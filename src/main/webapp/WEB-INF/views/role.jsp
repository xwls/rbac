<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>角色管理</title>
    <%@ include file="_css&js.jsp"%>
    <script type="text/javascript">

        function grantAuth() {
            //获取选中的权限的id
            var nodes = $("#auth-tree").tree("getChecked");
            var url = "${path}/role/grantAuth?";
            for (var i = 0; i < nodes.length; i++){
                var node = nodes[i];
                url += "authId="+node.id+"&"
            }
            var row = $("#role-datagrid").datagrid("getSelected");
            url += "roleId="+row.dbid;
            $.ajax({
                url:url,
                type:"get",
                success:function (res) {
                    if (res.code === 1) {
                        //成功
                        $.messager.alert("提示信息","操作成功","success");
                        $("#role-window").window("close");
                    }else{
                        $.messager.alert("提示信息","操作失败","error");
                    }
                }
            });
        }

        function showGrantAuthWindow(roleId){
            //显示window
            $("#role-window").window({
                title:"授权窗口",
                iconCls:"icon-edit",
                collapsible:false,
                minimizable:false,
                maximizable:false,
                modal:true,
                resizable:false,
                footer:"#footer",
                onOpen:function () {
                    //初始化tree，显示系统中所有有效的权限
                    $("#auth-tree").tree({
                        url:"${path}/auth/allValid?roleId="+roleId,
                        checkbox:true,
                        cascadeCheck:false
                    });
                },
                onClose:function () {
                    // alert("close");
                }
            }).window("open");
        }
        $(function () {
            $("#role-datagrid").datagrid({
                url: "${path}/role/all",
                rownumbers: true,
                singleSelect: true,
                pagination:true,
                method: 'get',
                columns: [[
                    {field: 'roleName', title: '角色名称'},
                    {field: 'roleCode', title: '角色编码'},
                    {
                        field: 'valid', title: '是否有效',
                        formatter: function (value, row, index) {
                            if (value === "1") {
                                return "有效";
                            } else {
                                return "<span style='color:red'>无效</span>";
                            }
                        }
                    },
                    {field: 'orders', title: '排序'},
                    {
                        field: 'dbid', title: '授权',
                        formatter: function (value, row, index) {
                            return "<a href='javascript:void(0)' onclick='showGrantAuthWindow("+value+")'>授权</a>";
                        }
                    }
                ]]
            });
        });
    </script>
</head>
<body>
<table id="role-datagrid"></table>
<div id="role-window" class="easyui-window" title="Basic Window" data-options="closed:true" style="width:400px;height:500px;padding:10px">
    <ul id="auth-tree"></ul>
    <div id="footer">
        <div style="text-align:center;padding:5px 0">
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="grantAuth()" style="width:80px">提交</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()" style="width:80px">关闭</a>
        </div>
    </div>
</div>

</body>
</html>
