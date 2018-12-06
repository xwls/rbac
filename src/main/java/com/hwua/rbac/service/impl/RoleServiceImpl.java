package com.hwua.rbac.service.impl;

import com.hwua.rbac.dao.AuthMapper;
import com.hwua.rbac.dao.RoleMapper;
import com.hwua.rbac.po.Role;
import com.hwua.rbac.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service("roleService")
public class RoleServiceImpl implements RoleService {

    @Autowired
    private AuthMapper authMapper;

    @Autowired
    private RoleMapper roleMapper;

    @Override
    public List<Role> getAllRole() {
        return roleMapper.queryAll();
    }

    @Override
    public List<Role> getValidRole() {
        return roleMapper.queryValid();
    }

    @Override
    public List<Integer> getRoleIdByUserId(Integer userId) {
        return roleMapper.queryRoleIdByUserId(userId);
    }

    @Transactional
    @Override
    public int grant(Map<String, Object> param) {
        Integer roleId = (Integer) param.get("roleId");
        int i = authMapper.doDelete(roleId);
        int i1 = authMapper.doInsertBatch(param);
        return i + i1;
    }
}
