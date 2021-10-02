CREATE TABLE final.crew(
  `crewIdx` int NOT NULL AUTO_INCREMENT,
  `crewName` varchar(50) COLLATE utf8_bin NOT NULL,
  `crewPhoto` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `crewDiscription` text COLLATE utf8_bin NOT NULL,
  `crewCreatedate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `crewTag` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `memberIdx` int NOT NULL,
  PRIMARY KEY (`crewIdx`),
  UNIQUE KEY `unique_crewName` (`crewName`),
  KEY `fk_memberIdx_to_crewOwner` (`memberIdx`),
  CONSTRAINT `fk_memberIdx_to_crewOwner` FOREIGN KEY (`memberIdx`) REFERENCES `member` (`memberIdx`) ON DELETE CASCADE
) ;

CREATE TABLE final.crewComment (
  `crewCommentIdx` int NOT NULL AUTO_INCREMENT,
  `crewComment` text COLLATE utf8_bin NOT NULL,
  `crewCommentDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `memberIdx` int NOT NULL,
  `crewIdx` int NOT NULL,
  PRIMARY KEY (`crewCommentIdx`),
  KEY `fk_memberIdx_to_crewComment` (`memberIdx`),
  KEY `fk_crewIdx_to_crewComment` (`crewIdx`),
  CONSTRAINT `fk_crewIdx_to_crewComment` FOREIGN KEY (`crewIdx`) REFERENCES `crew` (`crewIdx`) ON DELETE CASCADE,
  CONSTRAINT `fk_memberIdx_to_crewComment` FOREIGN KEY (`memberIdx`) REFERENCES `member` (`memberIdx`) ON DELETE CASCADE
) ;

CREATE TABLE final.crewreg (
  `crewRegIdx` int NOT NULL AUTO_INCREMENT,
  `crewRegdate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `memberIdx` int NOT NULL,
  `crewIdx` int NOT NULL,
  PRIMARY KEY (`crewRegIdx`),
  KEY `fk_memberIdx_to_crewReg` (`memberIdx`),
  KEY `fk_crewIdx_to_crewReg` (`crewIdx`),
  CONSTRAINT `fk_crewIdx_to_crewReg` FOREIGN KEY (`crewIdx`) REFERENCES `crew` (`crewIdx`) ON DELETE CASCADE,
  CONSTRAINT `fk_memberIdx_to_crewReg` FOREIGN KEY (`memberIdx`) REFERENCES `member` (`memberIdx`) ON DELETE CASCADE
) ;

CREATE TABLE final.follow (
  `followIdx` int NOT NULL AUTO_INCREMENT,
  `followDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `memberIdx` int NOT NULL,
  `memberIdx2` int NOT NULL,
  PRIMARY KEY (`followIdx`),
  KEY `fk_myMemberIdx` (`memberIdx`),
  KEY `fk_followMemberIdx` (`memberIdx2`),
  CONSTRAINT `fk_followMemberIdx` FOREIGN KEY (`memberIdx2`) REFERENCES `member` (`memberIdx`) ON DELETE CASCADE,
  CONSTRAINT `fk_myMemberIdx` FOREIGN KEY (`memberIdx`) REFERENCES `member` (`memberIdx`) ON DELETE CASCADE
) ;

CREATE TABLE final.like (
  `likeIdx` int NOT NULL AUTO_INCREMENT,
  `likeDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `memberIdx` int NOT NULL,
  `boardIdx` int NOT NULL,
  PRIMARY KEY (`likeIdx`),
  KEY `fk_myMemberIdx_to_like` (`memberIdx`),
  KEY `fk_boardIdx` (`boardIdx`),
  CONSTRAINT `fk_boardIdx` FOREIGN KEY (`boardIdx`) REFERENCES `photoBoard` (`boardIdx`) ON DELETE CASCADE,
  CONSTRAINT `fk_myMemberIdx_to_like` FOREIGN KEY (`memberIdx`) REFERENCES `member` (`memberIdx`) ON DELETE CASCADE
) ;

CREATE TABLE final.member (
  `memberIdx` int NOT NULL AUTO_INCREMENT,
  `memberId` varchar(50) COLLATE utf8_bin NOT NULL,
  `memberPw` varchar(100) COLLATE utf8_bin NOT NULL,
  `memberName` varchar(50) COLLATE utf8_bin NOT NULL,
  `memberEmail` varchar(40) COLLATE utf8_bin NOT NULL,
  `memberProfile` varchar(100) COLLATE utf8_bin DEFAULT 'default.jpg',
  `memberNickname` varchar(50) COLLATE utf8_bin NOT NULL,
  `memberRegdate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `memberBirth` date DEFAULT NULL,
  PRIMARY KEY (`memberIdx`),
  UNIQUE KEY `member_memberid_uq` (`memberId`),
  UNIQUE KEY `member_memberNickname_uq` (`memberNickname`)
) ;

CREATE TABLE final.mountain (
  `idx` int NOT NULL AUTO_INCREMENT,
  `infoidx` int DEFAULT NULL,
  `mname` varchar(45) COLLATE utf8_bin NOT NULL,
  `mcode` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `address` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `x` double DEFAULT NULL,
  `y` double DEFAULT NULL,
  `info` varchar(2000) COLLATE utf8_bin DEFAULT NULL,
  `height` int DEFAULT NULL,
  `detail` varchar(2000) COLLATE utf8_bin DEFAULT NULL,
  `transport` varchar(800) COLLATE utf8_bin DEFAULT NULL,
  `img` varchar(100) COLLATE utf8_bin DEFAULT 'default.jpg',
  PRIMARY KEY (`idx`)
) ;

CREATE TABLE final.photoBoard (
  `boardIdx` int NOT NULL AUTO_INCREMENT,
  `boardPhoto` varchar(100) COLLATE utf8_bin NOT NULL,
  `boardDiscription` text COLLATE utf8_bin,
  `boardDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `hashtag` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `tag` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `memberIdx` int NOT NULL,
  PRIMARY KEY (`boardIdx`),
  KEY `FK_memberIdx_to_board` (`memberIdx`),
  CONSTRAINT `FK_memberIdx_to_board` FOREIGN KEY (`memberIdx`) REFERENCES `member` (`memberIdx`) ON DELETE CASCADE
) ;

CREATE TABLE final.photoBoardComment (
  `boardCommentIdx` int NOT NULL AUTO_INCREMENT,
  `comment` text COLLATE utf8_bin NOT NULL,
  `commentDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `boardIdx` int NOT NULL,
  `memberIdx` int NOT NULL,
  PRIMARY KEY (`boardCommentIdx`),
  KEY `FK_boardIdx_to_boardComment` (`boardIdx`),
  KEY `FK_memberIdx_to_boardComment` (`memberIdx`),
  CONSTRAINT `FK_boardIdx_to_boardComment` FOREIGN KEY (`boardIdx`) REFERENCES `photoBoard` (`boardIdx`) ON DELETE CASCADE,
  CONSTRAINT `FK_memberIdx_to_boardComment` FOREIGN KEY (`memberIdx`) REFERENCES `member` (`memberIdx`) ON DELETE CASCADE
) ;

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `bit`@`%` 
    SQL SECURITY DEFINER
VIEW `final`.`countLike` AS
    SELECT 
        COUNT(0) AS `count`, `L`.`boardIdx` AS `boardIdx`
    FROM
        `final`.`like` `L`
    GROUP BY `L`.`boardIdx`;
    
    