USE planningpoker;

CREATE TABLE `participant` (
  `name` varchar(30) NOT NULL,
  `email` varchar(50) NOT NULL DEFAULT '',
  `project` varchar(20) NOT NULL,
  `created_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


INSERT INTO `participant`(`name`,`email`,`project`,`created_ts`) VALUES ('Algates','azhagesan.r@hcl.com','Patterns','2015-09-28 00:00:00');
INSERT INTO `participant`(`name`,`email`,`project`,`created_ts`) VALUES ('Jagan','jagan.ks@hcl.com','Patterns','2015-08-29 00:00:00');
INSERT INTO `participant`(`name`,`email`,`project`,`created_ts`) VALUES ('Jayakarthiga','jayakarthiga.m@hcl.com','shopview','2015-08-29 20:15:57');
INSERT INTO `participant`(`name`,`email`,`project`,`created_ts`) VALUES ('Kalaivani','kalaivani.k@hcl.com','shopview','2015-10-27 00:00:00');
INSERT INTO `participant`(`name`,`email`,`project`,`created_ts`) VALUES ('Lakshmi','lakshminarayanan_s@hcl.com','shopview','2015-08-29 20:16:14');
INSERT INTO `participant`(`name`,`email`,`project`,`created_ts`) VALUES ('Lipsa','lipsa.p@hcl.com','shopview','2015-10-27 00:00:00');
INSERT INTO `participant`(`name`,`email`,`project`,`created_ts`) VALUES ('Madan','madan_g@hcl.com','shopview','2015-08-29 20:16:42');
INSERT INTO `participant`(`name`,`email`,`project`,`created_ts`) VALUES ('Muthu','muruganm@hcl.com','shopview','2015-08-29 20:16:28');
INSERT INTO `participant`(`name`,`email`,`project`,`created_ts`) VALUES ('Sashi','sashibhusan.p@hcl.com','shopview','2015-08-29 20:15:38');
INSERT INTO `participant`(`name`,`email`,`project`,`created_ts`) VALUES ('Sathish','sathishgurumoorthy@hcl.com','shopview','0001-01-01 00:00:00');
INSERT INTO `participant`(`name`,`email`,`project`,`created_ts`) VALUES ('Sindhuja','sindhujas@hcl.com','shopview','2015-08-29 20:14:06');
INSERT INTO `participant`(`name`,`email`,`project`,`created_ts`) VALUES ('Siva','sivasankar_r@hcl.com','shopview','0001-01-01 00:00:00');
INSERT INTO `participant`(`name`,`email`,`project`,`created_ts`) VALUES ('Srini','srganesh@hcl.com','shopview','2015-08-29 20:15:20');
INSERT INTO `participant`(`name`,`email`,`project`,`created_ts`) VALUES ('Sundarlal','sundarlal.chod@hcl.com','shopview','2015-08-29 20:14:53');
