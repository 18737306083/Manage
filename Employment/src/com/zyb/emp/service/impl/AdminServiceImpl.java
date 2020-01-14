package com.zyb.emp.service.impl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zyb.emp.bean.Admin;
import com.zyb.emp.dao.AdminDao;
import com.zyb.emp.service.AdminService;
 
@Service("adminService")
public class AdminServiceImpl implements AdminService{
	private Logger logger=LoggerFactory.getLogger(this.getClass());
	@Autowired
	private AdminDao adminDao;
	@Override
	public Admin login(String username, String password) {
		return adminDao.login(username,password);
	}
	
	

 
}
