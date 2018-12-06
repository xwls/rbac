package com.hwua.rbac.service;

import com.hwua.rbac.po.User;

import java.util.List;

public interface UserService {
    List<User> getAllUser();

    User login(String username, String password);
}
