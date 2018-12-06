package com.hwua.rbac.service;

import com.hwua.rbac.po.Auth;
import com.hwua.rbac.po.TreeNode;

import java.util.List;

public interface AuthService {
    List<Auth> getAllAuth();

    List<TreeNode> getValidAuth(Integer roleId);

    int edit(Auth auth);

    List<Auth> getByUserId(Integer userId);
}
