<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>用户管理</title>
    <%@ include file="_css&js.jsp"%>
    <script type="text/javascript">

        function showGrantRoleWindow(userId){
            //显示window
            $("#user-window").window({
                title:"授予角色窗口",
                iconCls:"icon-edit",
                collapsible:false,
                minimizable:false,
                maximizable:false,
                modal:true,
                resizable:false,
                footer:"#footer",
                onOpen:function () {
                    // 获取系统中所有有效的角色
                    $("#role-datagrid").datagrid({
                        url:"${path}/role/allValid",
                        checkbox:true,
                        idField:"dbid",
                        columns:[[
                            {field:"dbid",title:"dbid",checkbox:true},
                            {field:"roleName",title:"角色名称"},
                            {field:"roleCode",title:"角色编码"}
                        ]],
                        onLoadSuccess:function (data) {
                            //获取当前选中用户所拥有的角色
                            $.ajax({
                                url:"${path}/user/roleIds?userId="+userId,
                                success:function (res) {
                                    res.forEach(function (value,index) {
                                        $("#role-datagrid").datagrid("selectRecord",value);
                                    });
                                }
                            });
                        }
                    });
                },
                onClose:function () {
                    // 取消datagrid中选中的行
                    $("#role-datagrid").datagrid("unselectAll");
                }
            }).window("open");
        }

        $(function () {
            $("#user-datagrid").datagrid({
                url:"${path}/user/all",
                rownumbers: true,
                singleSelect: true,
                pagination:true,
                method: 'get',
                columns:[[
                    {field:"userName",title:"用户名"},
                    {field:"realName",title:"真实姓名"},
                    {field:"valid",title:"是否有效",
                        formatter: function (value, row, index) {
                            if (value === "1") {
                                return "有效";
                            } else {
                                return "<span style='color:red'>无效</span>";
                            }
                        }
                    },
                    {field:"dbid",title:"操作",
                        formatter: function (value, row, index) {
                            return "<a href='javascript:void(0)' onclick='showGrantRoleWindow("+value+")'>授予角色</a>";
                        }
                    }
                ]]
            });
        });
    </script>
</head>
<body>
<h1>用户管理</h1>
<table id="user-datagrid"></table>
<div id="user-window" class="easyui-window" title="Basic Window" data-options="closed:true" style="width:400px;height:500px;padding:10px">
    <table id="role-datagrid"></table>
    <div id="footer">
        <div style="text-align:center;padding:5px 0">
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="grantAuth()" style="width:80px">提交</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()" style="width:80px">关闭</a>
        </div>
    </div>
</div>

</body>
</html>
