package com.hwua.rbac.controller;

import com.alibaba.fastjson.JSON;
import com.hwua.rbac.po.Role;
import com.hwua.rbac.service.AuthService;
import com.hwua.rbac.service.RoleService;
import com.hwua.rbac.util.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/role")
public class RoleController {

    @Autowired
    private RoleService roleService;

    @RequestMapping("/main")
    public String main(){
        return "role";
    }

    @ResponseBody
    @RequestMapping(value = "/all",produces = "application/json;charset=utf-8")
    public String allRole(){
        List<Role> roles = roleService.getAllRole();
        return JSON.toJSONString(roles);
    }


    @RequestMapping(value = "/allValid",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String allValidAuth(){
        List<Role> roles = roleService.getValidRole();
        return JSON.toJSONString(roles);
    }

    @RequestMapping(value = "/grantAuth",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String grantAuth(Integer roleId, @RequestParam("authId") ArrayList<Integer> authIds){
        Map<String, Object> map = new HashMap<>();
        map.put("roleId",roleId);
        map.put("authIds",authIds);
        int grant = roleService.grant(map);
        return JSON.toJSONString(grant > 0 ? R.ok() : R.error());
    }

}
