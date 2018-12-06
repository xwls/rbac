package com.hwua.rbac.dao;

import com.hwua.rbac.po.Role;

import java.util.List;

public interface RoleMapper {

    List<Role> queryAll();

    List<Role> queryValid();

    /**
     * 根据用户id查询用户所拥有的角色
     * @param userId
     * @return
     */
    List<Integer> queryRoleIdByUserId(Integer userId);

}
