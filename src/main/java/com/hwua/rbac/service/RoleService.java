package com.hwua.rbac.service;

import com.hwua.rbac.po.Role;

import java.util.List;
import java.util.Map;

public interface RoleService {

    /**
     * 获取所有角色
     * @return
     */
    List<Role> getAllRole();

    /**
     * 获取有效的角色
     * @return
     */
    List<Role> getValidRole();

    /**
     * 根据用户id查询角色id
     * @param userId
     * @return
     */
    List<Integer> getRoleIdByUserId(Integer userId);

    /**
     * 授权
     * @param param 需要包含roleId(Integer)及authIds(List<Integer>)
     * @return
     */
    int grant(Map<String,Object> param);
}
