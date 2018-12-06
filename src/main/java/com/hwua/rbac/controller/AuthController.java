package com.hwua.rbac.controller;

import com.alibaba.fastjson.JSON;
import com.hwua.rbac.po.Auth;
import com.hwua.rbac.po.TreeNode;
import com.hwua.rbac.service.AuthService;
import com.hwua.rbac.util.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private AuthService authService;

    @RequestMapping("/main")
    public String main(){
        return "auth";
    }

    @RequestMapping(value = "/all",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String allAuth(){
        List<Auth> allAuth = authService.getAllAuth();
        return JSON.toJSONString(allAuth);
    }

    @RequestMapping(value = "/allValid",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String allValidAuth(Integer roleId){
        List<TreeNode> allAuth = authService.getValidAuth(roleId);
        return JSON.toJSONString(allAuth);
    }

    @RequestMapping(value = "/edit",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String editAuth(Auth auth){
        int edit = authService.edit(auth);
        return JSON.toJSONString(edit == 1 ? R.ok() : R.error());
    }
}
