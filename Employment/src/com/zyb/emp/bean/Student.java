package com.zyb.emp.bean;


/**
 * CREATE TABLE `stu` (
  `stu_id` varchar(11) NOT NULL,
  `stu_name` varchar(20) DEFAULT NULL,
  `college` varchar(2) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`stu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
 * @author Administrator
 *
 */
public class Student {
	private String stuId;
	private String stuName;
	private College college;
	private String email;
}
