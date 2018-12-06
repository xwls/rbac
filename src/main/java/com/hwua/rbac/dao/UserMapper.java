package com.hwua.rbac.dao;

import com.hwua.rbac.po.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserMapper {

    List<User> queryAll();

    User queryByUsernameAndPassword(@Param("username") String username, @Param("password") String password);

}
