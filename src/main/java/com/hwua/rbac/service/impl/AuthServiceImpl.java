package com.hwua.rbac.service.impl;

import com.hwua.rbac.dao.AuthMapper;
import com.hwua.rbac.po.Auth;
import com.hwua.rbac.po.TreeNode;
import com.hwua.rbac.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service("authService")
public class AuthServiceImpl implements AuthService {

    @Autowired
    private AuthMapper authMapper;

    @Override
    public List<Auth> getAllAuth() {
        return authMapper.queryByParentId(-1);
    }

    @Override
    public List<TreeNode> getValidAuth(Integer roleId) {
        //所有有效的权限
        List<TreeNode> nodes = authMapper.queryValidByParentId(-1);
        //查询角色对应的权限
        List<Integer> authIds = authMapper.queryAuthIdByRoleId(roleId);
        parseAuth(nodes,authIds);
        return nodes;
    }

    private void parseAuth(List<TreeNode> nodes, List<Integer> authIds) {
        for (TreeNode treeNode : nodes) {
            if (authIds.contains(treeNode.getId())){
                treeNode.setChecked(true);
            }
            List<TreeNode> children = treeNode.getChildren();
            parseAuth(children,authIds);
        }
    }

    @Override
    public int edit(Auth auth) {
        return authMapper.doUpdate(auth);
    }

    @Override
    public List<Auth> getByUserId(Integer userId) {
        List<Auth> authTrees = authMapper.queryAuthByUserId(userId);
        //组织tree的结构
        Auth father = null;
        Auth son = null;
        List<Auth> children = null;
        for (int i = 0; i < authTrees.size(); i++) {
            children = new ArrayList<>();
            //默认第i个是father
            father = authTrees.get(i);
            for (int j = 0; j < authTrees.size(); j++) {
                son = authTrees.get(j);
                if (son.getParentId().equals(father.getDbid())){
                    authTrees.remove(j);
                    j--;
                    children.add(son);
                }
            }
            father.setChildren(children);
        }
        return authTrees;
    }
}
