USE planningpoker;

CREATE TABLE `poker_session` (
  `session_id` int(11) NOT NULL AUTO_INCREMENT,
  `session_name` varchar(100) NOT NULL,
  `planning_card_set` int(11) NOT NULL DEFAULT '1',
  `voting_time_limit` int(11) NOT NULL DEFAULT '60',
  `host_email` varchar(50) NOT NULL,
  `session_url` varchar(100) NOT NULL,
  PRIMARY KEY (`session_id`),
  UNIQUE KEY `session_url` (`session_url`),
  KEY `host_email` (`host_email`),
  CONSTRAINT `host_email` FOREIGN KEY (`host_email`) REFERENCES `participant` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=latin1;


INSERT INTO `poker_session`(`session_id`,`session_name`,`planning_card_set`,`voting_time_limit`,`host_email`,`session_url`) VALUES (64,'Shopview Sprint 7 Planning',0,60,'sathishgurumoorthy@hcl.com','PChT962P6Y6feFFCN7fM5yAsN6MLVu3zABnBM1Ex');
