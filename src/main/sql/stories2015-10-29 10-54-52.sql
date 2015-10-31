USE planningpoker;

CREATE TABLE `stories` (
  `story_id` int(11) NOT NULL AUTO_INCREMENT,
  `story_external_id` varchar(20) DEFAULT NULL,
  `story_title` varchar(200) NOT NULL,
  `story_description` varchar(500) DEFAULT NULL,
  `session_id` int(11) NOT NULL,
  `final_points` int(11) DEFAULT NULL,
  `voted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`story_id`),
  KEY `session_id_fk` (`session_id`),
  CONSTRAINT `session_id_fk` FOREIGN KEY (`session_id`) REFERENCES `poker_session` (`session_id`)
) ENGINE=InnoDB AUTO_INCREMENT=309 DEFAULT CHARSET=latin1;


INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (200,null,'595267	Related Item',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (201,null,'595268	Reference Drawing ',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (202,null,'595270	Reinspection',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (203,null,'595271	Customizable',null,64,0,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (204,null,'595272	Verfication',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (205,null,'595310	NC Header Section (object 1)',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (206,null,'595311	NC Header Section (object 2)',null,64,0,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (207,null,'595312	NC Header Section (object 3)',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (208,null,'595313	NC Header Section (object 4)',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (209,null,'595314	NC Header Section (object 5)',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (210,null,'595315	NC Header Section (object 6)',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (211,null,'595316	NC Header Section (object 7)',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (212,null,'595317	NC Header Section (object 8)',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (213,null,'595319	NC Header Section (object 12)',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (214,null,'595320	NC Header Section (object 15)',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (215,null,'595322	Part Information',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (216,null,'595895	SVOP004-046 Non-Printable Attachments  ',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (217,null,'595323	CA Header Section (object 1)',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (218,null,'595324	CA Header Section (object 2)',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (219,null,'595326	RFA Header Section (object 1)',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (220,null,'595327	RFA Header Section (object 2)',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (221,null,'595336	Planning Summary - Non-Unitized (object 1a) ',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (222,null,'595407	Alternate Buyoff - Non Unitized (object 1b)',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (223,null,'595408	Unitized (object 1)',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (224,null,'595409	Related Revisions',null,64,0,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (225,null,'595419	Signatures',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (226,null,'595420	Routing History',null,64,2,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (227,null,'595421	Routing Comments',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (228,null,'595422	Attachment List',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (229,null,'595423	Discrepancy/Disposition',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (230,null,'595424	Planning Coverage',null,64,0,0);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (231,null,'595425	Non-Unitized',null,64,0,0);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (232,null,'595431	Coverage (object 1a)',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (233,null,'595432	Alternate Buyoff (object 1b) ',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (234,null,'595433	Planning Coverage',null,64,0,0);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (235,null,'595434	Unitized (object 1c)',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (236,null,'595435	Plan  Section - Non-Unitized (object 1a)',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (237,null,'595436	Plan  Section -Unitized (object 1b)',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (238,null,'595437	Related Revisions',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (239,null,'595438	Associate Item',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (240,null,'595439	Plan Section (object 2)',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (241,null,'595440	Order Section - Non-Unitized (object 1a)',null,64,3,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (242,null,'595441	Order Section - Unitized (object 1b)',null,64,2,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (243,null,'595442	Order Work With ',null,64,0,0);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (244,null,'595444	Order Section (object 3)',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (245,null,'595445	Associate Item',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (246,null,'595447	Order Section (object 6) ',null,64,0,0);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (247,null,'595448	Order Section (object 2)',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (248,null,'595870	Codes Section (object 1)',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (249,null,'595871	NCM/ERP Company',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (250,null,'595872	Codes Section (object 3)',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (251,null,'595873	Codes Section (object 4)',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (252,null,'595874	Codes Section (object 5)',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (253,null,'595875	Codes Section -Unitized (object 6a)',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (254,null,'595876	Codes Section -Non-Unitized (object 6b)',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (255,null,'595877	Defect Codes Section(object 1)',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (256,null,'595878	Defect Codes Section(object 2)',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (257,null,'595879	Defect Codes Section  (object 2b)',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (258,null,'595880	Defect Codes Section(object 3)',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (259,null,'595881	Defect Codes Section(object 4)',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (260,null,'595882	Defect Codes Section(object 5)',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (261,null,'595883	Defect Codes Section(object 6)',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (262,null,'595884	Defect Codes Section(object 7)',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (263,null,'595885	Defect Codes Section (object 8a)',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (264,null,'595886	Defect Codes Section (object 8b)',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (265,null,'595887	Defect Codes Section(object 9)',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (266,null,'595888	Defect Codes Section(object 10)',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (267,null,'595889	Attachments',null,64,2,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (268,null,'595890	Regular Footer',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (269,null,'595891	Order Footer',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (270,null,'595892	Attachment Footer',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (271,null,'595893	Narrative',null,64,1,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (272,null,'595894	Action Plan ',null,64,2,1);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (273,null,'595099	User Story :Gather Sprint 7 Requirements and document P490S',null,64,0,0);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (274,null,'593818	Attachment section heading is not there in IP Report',null,64,0,0);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (275,null,'601505	Operation Number and step number field naming is different from legacy report',null,64,0,0);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (276,null,'593813	Lines are not properly aligned in OPERATIONS/DETAIL SECTION. Please refer the screen shot below',null,64,0,0);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (277,null,'590448	OWI MHIR Print - Gap between Order Header and Operation Section',null,64,0,0);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (278,null,'601834	REL REC value is missing in IP Print - Header section',null,64,0,0);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (279,null,'601863	OWI - IP Print - Operation Section - Narrative missing details',null,64,0,0);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (280,null,'601865	OWI - IP Print - Exception Section - BEMSID/Name - Name data missing',null,64,0,0);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (281,null,'601866	Non-Printable Attachments section to be printed on a fresh page',null,64,0,0);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (282,null,'601889	The divider has to be till the bottom of the page',null,64,0,0);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (283,null,'601906	Value of type and Quantity are not alligned properly in Formatted Table section',null,64,0,0);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (284,null,'601907	Divider is not needed after the field "Page" in footer section',null,64,0,0);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (285,null,'601908	Field "Pgm ID" in footer has to be replaced by "Program ID"',null,64,0,0);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (286,null,'601909	Footer border is not uniform',null,64,0,0);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (287,null,'601910	Right side water mark is not fully visible',null,64,0,0);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (288,null,'601911	Last page of the footer does not have LP',null,64,0,0);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (289,null,'601917	PMW - EPD - Action Plan - Attach Graphic PDF without graphic',null,64,0,0);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (290,null,'601924	:”FINAL “ Value should be displayed in the Column value of “DISPOSITION TYPE” but it is displaying “F”.',null,64,0,0);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (291,null,'601925	Empty space below the metallic material section',null,64,0,0);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (292,null,'601926	Metallic material section and Raw material section heading comes together',null,64,0,0);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (293,null,'601927	Blank page is getting generated at last in MHIR order 1',null,64,0,0);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (294,null,'601928	Author name is not getting printed in the footer',null,64,0,0);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (295,null,'601903	Header is repeating 2 times',null,64,0,0);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (296,null,'601904	Quantity Accepted and Quantity Rejected fields are missing',null,64,0,0);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (297,null,'601708	Table is distorted in Metallic section',null,64,0,0);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (298,null,'601709	Extra space is present between the metallic section and footer',null,64,0,0);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (299,null,'601711	Sub-Spec Style and Sub-Spec Resin fields are not needed',null,64,0,0);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (300,null,'601729	Matl Category value is "ALUMINUM ALLOY". The value is wrongly printed in the report.',null,64,0,0);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (301,null,'601898	Label "Text" is missing in FF Note section',null,64,0,0);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (302,null,'601893	Table is distorted in Part Removal section',null,64,0,0);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (303,null,'601894	Field label "SOCIAL NUMBER" has to be replaced by "Serial Number:" in the Fit Check Part Tag',null,64,0,0);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (304,null,'601891	No water mark should be present over part tag pages',null,64,0,0);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (305,null,'601887	Field serial is missing in Line Move Item part tag',null,64,0,0);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (306,null,'601888	Line is not needed below the field label "Additional Information”',null,64,0,0);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (307,null,'601897	Field label "ATTCHED TO" has to be replaced by "Attached To" in FFNote section',null,64,0,0);
INSERT INTO `stories`(`story_id`,`story_external_id`,`story_title`,`story_description`,`session_id`,`final_points`,`voted`) VALUES (308,null,'	POC and template for PDF Viewer',null,64,0,0);
