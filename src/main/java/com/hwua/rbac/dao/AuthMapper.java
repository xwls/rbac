package com.hwua.rbac.dao;

import com.hwua.rbac.po.Auth;
import com.hwua.rbac.po.TreeNode;

import java.util.List;
import java.util.Map;

public interface AuthMapper {
    /**
     * 根据父节点的id查询权限
     * @param parentId 父节点的id
     * @return
     */
    List<Auth> queryByParentId(Integer parentId);

    /**
     * 查询有效的权限
     * @param parentId
     * @return
     */
    List<TreeNode> queryValidByParentId(Integer parentId);

    /**
     * 根据角色id查询角色所拥有的权限
     * @param roleId
     * @return
     */
    List<Integer> queryAuthIdByRoleId(Integer roleId);

    /**
     * 根据用户id查询用户所拥有的权限
     * @param userId
     * @return
     */
    List<Auth> queryAuthByUserId(Integer userId);

    /**
     * 更新权限
     * @param auth
     * @return
     */
    int doUpdate(Auth auth);

    /**
     * 删除
     * @param roleId
     * @return
     */
    int doDelete(Integer roleId);

    /**
     * 批量插入
     * @param param
     * @return
     */
    int doInsertBatch(Map<String,Object> param);
}
