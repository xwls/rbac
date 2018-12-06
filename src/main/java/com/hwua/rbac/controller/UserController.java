package com.hwua.rbac.controller;

import com.alibaba.fastjson.JSON;
import com.hwua.rbac.po.Role;
import com.hwua.rbac.po.User;
import com.hwua.rbac.service.RoleService;
import com.hwua.rbac.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private RoleService roleService;

    @RequestMapping("/main")
    public String main(){
        return "user";
    }

    @ResponseBody
    @RequestMapping(value = "/all",produces = "application/json;charset=utf-8")
    public String allRole(){
        List<User> users = userService.getAllUser();
        return JSON.toJSONString(users);
    }

    @RequestMapping(value = "/roleIds",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String roleIds(Integer userId){
        List<Integer> roleIds = roleService.getRoleIdByUserId(userId);
        return JSON.toJSONString(roleIds);
    }

}
