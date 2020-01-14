package com.zyb.emp.bean;

import java.util.Date;


/**
 * CREATE TABLE `careertalk` (
  `careertalk_id` int(7) NOT NULL AUTO_INCREMENT,
  `start_time` date DEFAULT NULL,
  `long_time` int(4) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `desc` text,
  `company` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`careertalk_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
 * @author Administrator
 *
 */
public class CareerTalk {
	private Integer careertalkId;
	private Date startTime;
	private Integer longTime;
	private String tilte;
	private String desc;
	private String company;
}
