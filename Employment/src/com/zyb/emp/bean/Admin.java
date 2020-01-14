package com.zyb.emp.bean;
/**
 * CREATE TABLE `admin` (
  `username` varchar(20) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  `id` int(5) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
 * @author Administrator
 *
 */
public class Admin {
	private Integer id;
	private String username;
	private String password;
}
