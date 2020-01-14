package com.zyb.emp.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.zyb.emp.bean.Admin;
import com.zyb.emp.service.AdminService;
 
/**
 * 管理员登陆控制
 * @author Administrator
 *
 */
@Controller
public class AdminController {
	private Logger logger=LoggerFactory.getLogger(this.getClass());
	@Autowired
	private AdminService adminService;
	
	@RequestMapping("/")
	public String loginPage(){
		return "login";
	}
	
	//登录
	@RequestMapping(value="/login",method = RequestMethod.POST)
	private String login(Model model,String username,String password){
		
		Admin admin = adminService.login(username,password);
		if(admin!=null){
			getSession().setAttribute("ADMIN", admin);
			return "main";
		}else
		model.addAttribute("loginError","用户名或密码错误！");	
		return "login";
	}
	
	@RequestMapping(value ="/unlogin")
	private String appointBooks(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		request.getSession().removeAttribute("READER");
		return "redirect:login";
	}
	
	public HttpSession getSession() {
		HttpServletRequest request = getRequest();
		return request.getSession();
	}

	private HttpServletRequest getRequest() {
		ServletRequestAttributes requestAttributes = 
				(ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
		return requestAttributes.getRequest();
	}
}
