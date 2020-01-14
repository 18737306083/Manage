package com.zyb.emp.bean;

/**
 * CREATE TABLE `college` (
  `college_id` int(4) NOT NULL AUTO_INCREMENT,
  `college_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`college_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

 * @author Administrator
 *
 */
public class College {
	private Integer collegeId;
	private String collegeName;
}
