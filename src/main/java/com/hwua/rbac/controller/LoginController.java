package com.hwua.rbac.controller;

import com.alibaba.fastjson.JSON;
import com.hwua.rbac.po.Auth;
import com.hwua.rbac.po.User;
import com.hwua.rbac.service.AuthService;
import com.hwua.rbac.service.UserService;
import com.hwua.rbac.util.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class LoginController {

    @Autowired
    private UserService userService;

    @Autowired
    private AuthService authService;

    @RequestMapping("/login")
    public String login(){
        return "login";
    }

    @RequestMapping(value = "/doLogin",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String doLogin(String username, String password, HttpSession session){
        User user = userService.login(username, password);
        if (user != null){
            //登录成功
            //查询当前用户的权限
            List<Auth> authList = authService.getByUserId(user.getDbid());
            session.setAttribute("user",user);
            session.setAttribute("authList",authList);
            return JSON.toJSONString(R.ok("登陆成功"));
        }else{
            //登录失败
            return JSON.toJSONString(R.error("登陆失败"));
        }
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session){
        session.invalidate();
        return "redirect:login";
    }

}
