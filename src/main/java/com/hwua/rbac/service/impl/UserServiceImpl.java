package com.hwua.rbac.service.impl;

import com.hwua.rbac.dao.UserMapper;
import com.hwua.rbac.po.User;
import com.hwua.rbac.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("userService")
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public List<User> getAllUser() {
        return userMapper.queryAll();
    }

    @Override
    public User login(String username, String password) {
        return userMapper.queryByUsernameAndPassword(username,password);
    }
}
