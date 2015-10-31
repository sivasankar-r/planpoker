USE planningpoker;

CREATE TABLE `session_participants` (
  `session_id` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `joined` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`session_id`,`email`),
  KEY `email_fk` (`email`),
  CONSTRAINT `email_fk` FOREIGN KEY (`email`) REFERENCES `participant` (`email`),
  CONSTRAINT `session_fk` FOREIGN KEY (`session_id`) REFERENCES `poker_session` (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


INSERT INTO `session_participants`(`session_id`,`email`,`joined`) VALUES (64,'jayakarthiga.m@hcl.com',0);
INSERT INTO `session_participants`(`session_id`,`email`,`joined`) VALUES (64,'kalaivani.k@hcl.com',1);
INSERT INTO `session_participants`(`session_id`,`email`,`joined`) VALUES (64,'lakshminarayanan_s@hcl.com',1);
INSERT INTO `session_participants`(`session_id`,`email`,`joined`) VALUES (64,'lipsa.p@hcl.com',0);
INSERT INTO `session_participants`(`session_id`,`email`,`joined`) VALUES (64,'madan_g@hcl.com',1);
INSERT INTO `session_participants`(`session_id`,`email`,`joined`) VALUES (64,'muruganm@hcl.com',1);
INSERT INTO `session_participants`(`session_id`,`email`,`joined`) VALUES (64,'sashibhusan.p@hcl.com',1);
INSERT INTO `session_participants`(`session_id`,`email`,`joined`) VALUES (64,'sathishgurumoorthy@hcl.com',1);
INSERT INTO `session_participants`(`session_id`,`email`,`joined`) VALUES (64,'sindhujas@hcl.com',0);
INSERT INTO `session_participants`(`session_id`,`email`,`joined`) VALUES (64,'sivasankar_r@hcl.com',1);
INSERT INTO `session_participants`(`session_id`,`email`,`joined`) VALUES (64,'srganesh@hcl.com',0);
