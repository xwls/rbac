package com.hwua.rbac.test;

import com.alibaba.fastjson.JSON;
import com.hwua.rbac.po.Auth;
import com.hwua.rbac.service.AuthService;
import org.junit.Test;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.List;

public class TestRBAC {

    @Test
    public void test(){
        ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
        AuthService authService = context.getBean(AuthService.class);
        List<Auth> authTreeList = authService.getByUserId(26);
        System.out.println(JSON.toJSONString(authTreeList));
        context.close();
    }

}
