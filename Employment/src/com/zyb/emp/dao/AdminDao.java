package com.zyb.emp.dao;

import org.apache.ibatis.annotations.Param;

import com.zyb.emp.bean.Admin;

public interface AdminDao {

	Admin login(@Param("username")String username, @Param("password")String password);

}
