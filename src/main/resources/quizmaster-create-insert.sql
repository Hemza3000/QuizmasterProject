-- -----------------------------------------------------
-- Schema Quizmaster
-- -----------------------------------------------------

SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0;
SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0;
SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE =
        'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Quizmaster
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Quizmaster`;

-- -----------------------------------------------------
-- Schema Quizmaster
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Quizmaster` DEFAULT CHARACTER SET utf8;
USE `Quizmaster`;

-- -----------------------------------------------------
-- Database user for Schema Quizmaster
-- -----------------------------------------------------
CREATE USER IF NOT EXISTS 'userQuizmaster'@'localhost'
    IDENTIFIED WITH caching_sha2_password
        BY 'pwQuizmaster' PASSWORD EXPIRE NEVER;
GRANT SELECT ON Quizmaster.* TO 'userQuizmaster'@'localhost';
GRANT INSERT ON Quizmaster.* TO 'userQuizmaster'@'localhost';
GRANT DELETE ON Quizmaster.* TO 'userQuizmaster'@'localhost';
GRANT UPDATE ON Quizmaster.* TO 'userQuizmaster'@'localhost';

-- -----------------------------------------------------
-- Table `Quizmaster`.`Course`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Quizmaster`.`Course`;

CREATE TABLE IF NOT EXISTS `Quizmaster`.`Course`
(
    `idCourse`   INT         NOT NULL AUTO_INCREMENT,
    `courseName` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`idCourse`)

)
    ENGINE = InnoDB
    AUTO_INCREMENT = 13
    DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Data for table `Quizmaster`.`Course`
-- -----------------------------------------------------
START TRANSACTION;
USE `Quizmaster`;

INSERT INTO Course (idCourse, courseName)
VALUES (1, 'SkillUp');
INSERT INTO Course (idCourse, courseName)
VALUES (2, 'No-Bull Bootcamp');
INSERT INTO Course (idCourse, courseName)
VALUES (3, 'Mentee to Mentor');
INSERT INTO Course (idCourse, courseName)
VALUES (4, 'Active Achievement');
INSERT INTO Course (idCourse, courseName)
VALUES (5, 'Practice to Perfect');
INSERT INTO Course (idCourse, courseName)
VALUES (6, 'Strive Training');
INSERT INTO Course (idCourse, courseName)
VALUES (7, 'Commission Kings');
INSERT INTO Course (idCourse, courseName)
VALUES (8, 'Productivity Today');
INSERT INTO Course (idCourse, courseName)
VALUES (9, 'Unbound Opportunities');
INSERT INTO Course (idCourse, courseName)
VALUES (10, 'Passion Chasers');
INSERT INTO Course (idCourse, courseName)
VALUES (11, 'Limitless Horizons');
INSERT INTO Course (idCourse, courseName)
VALUES (12, 'Excalibur Training');

COMMIT;

-- -----------------------------------------------------
-- Table `Quizmaster`.`Course_User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Quizmaster`.`Course_User`;

CREATE TABLE IF NOT EXISTS `Quizmaster`.`Course_User`
(
    `idUser`   INT NOT NULL,
    `idCourse` INT NOT NULL,
    INDEX `fk_Course_User` (`idUser` ASC) VISIBLE,
    INDEX `fk_User_Course` (`idCourse` ASC) VISIBLE,
    CONSTRAINT `fk_Course_User`
        FOREIGN KEY (`idUser`)
            REFERENCES `quizmaster`.`user` (`idUser`),
    CONSTRAINT `fk_User_Course`
        FOREIGN KEY (`idCourse`)
            REFERENCES `quizmaster`.`course` (`idCourse`)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `Quizmaster`.`Question`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Quizmaster`.`Question`;

CREATE TABLE IF NOT EXISTS `Quizmaster`.`Question`
(
    idQuestion   INT          NOT NULL AUTO_INCREMENT,
    description  VARCHAR(200) NOT NULL,
    answerRight  VARCHAR(45)  NOT NULL,
    answerWrong1 VARCHAR(45)  NOT NULL,
    answerWrong2 VARCHAR(45)  NOT NULL,
    answerWrong3 VARCHAR(45)  NOT NULL,
    PRIMARY KEY (`idQuestion`)
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 8
    DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Data for table `Quizmaster`.`Question`
-- -----------------------------------------------------
START TRANSACTION;
USE `Quizmaster`;

INSERT INTO Question (idQuestion, description, answerRight, answerWrong1, answerWrong2, answerWrong3)
VALUES (1, 'Wat is 1+1?', '2', '15', '166', '345');
INSERT INTO Question (idQuestion, description, answerRight, answerWrong1, answerWrong2, answerWrong3)
VALUES (2, 'Wat is 2+2?', '4', 'werw', 'ewrw', 'ww');
INSERT INTO Question (idQuestion, description, answerRight, answerWrong1, answerWrong2, answerWrong3)
VALUES (3, 'Wat is 3+3?', '6', '345', '533', '353');
INSERT INTO Question (idQuestion, description, answerRight, answerWrong1, answerWrong2, answerWrong3)
VALUES (4, 'Wat is 10x5?', '50', 'Appel', '655', '23');
INSERT INTO Question (idQuestion, description, answerRight, answerWrong1, answerWrong2, answerWrong3)
VALUES (5, 'Wat is 60/2?', '30 ', '545', 'Sinterklaas', 'Boeien');
INSERT INTO Question (idQuestion, description, answerRight, answerWrong1, answerWrong2, answerWrong3)
VALUES (6, 'Wat is de hoofdstad van Nederland?', 'Amsterdam', 'Enschede', 'Rotterdam', 'Urk');
INSERT INTO Question (idQuestion, description, answerRight, answerWrong1, answerWrong2, answerWrong3)
VALUES (7, 'Hoe is het?', 'Oke', 'Goed', 'Slecht', 'Matig');

COMMIT;

-- -----------------------------------------------------
-- Table `Quizmaster`.`Quiz` ---------------------- TODO
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Quizmaster`.`Quiz`;

CREATE TABLE IF NOT EXISTS `Quizmaster`.`Quiz`
(
    `idQuiz`   INT         NOT NULL AUTO_INCREMENT,
    `quizName` VARCHAR(25) NOT NULL,
    PRIMARY KEY (`idQuiz`)
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 1
    DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Data for table `Quizmaster`.`Quiz` ------------- TODO
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table `Quizmaster`.`StudentGroup` -------------- TODO
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Quizmaster`.`StudentGroup`;

CREATE TABLE IF NOT EXISTS `Quizmaster`.`StudentGroup`
(
    `idStudentGroup`   INT         NOT NULL AUTO_INCREMENT,
    `StudentGroupName` VARCHAR(20) NOT NULL,
    `idCourse`         INT         NOT NULL,
    PRIMARY KEY (`idStudentGroup`),
    INDEX `fk_Group_Course_idx` (`idCourse` ASC) VISIBLE,
    CONSTRAINT `fk_Group_Course`
        FOREIGN KEY (`idCourse`)
            REFERENCES `Quizmaster`.`Course` (`idCourse`)
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 2
    DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Data for table `Quizmaster`.`StudentGroup` ----- TODO
-- -----------------------------------------------------
START TRANSACTION;
USE `Quizmaster`;

INSERT INTO `Quizmaster`.`StudentGroup` (`idStudentGroup`, `StudentGroupName`, `idCourse`)
VALUES (1, 'Group1', 1);

COMMIT;

-- -----------------------------------------------------
-- Table `Quizmaster`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Quizmaster`.`User`;

CREATE TABLE IF NOT EXISTS `Quizmaster`.`User`
(
    `idUser`    INT         NOT NULL AUTO_INCREMENT,
    `userName`  VARCHAR(20) NOT NULL,
    `password`  VARCHAR(20) NOT NULL,
    `role`      VARCHAR(20) NOT NULL,
    `firstName` VARCHAR(15) NOT NULL,
    `lastName`  VARCHAR(25) NOT NULL,
    PRIMARY KEY (`idUser`),
    UNIQUE INDEX `userName_UNIQUE` (`userName` ASC) VISIBLE
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 7
    DEFAULT CHARACTER SET = utf8;
-- -----------------------------------------------------
-- Data for table `Quizmaster`.`User`
-- -----------------------------------------------------
START TRANSACTION;
USE `Quizmaster`;

INSERT INTO `Quizmaster`.`User` (`idUser`, `userName`, `password`, `role`, `firstName`, `lastName`)
VALUES ('1', 'User1', 'pwUser1', 'STUDENT', 'Piet', 'Kweetniet');
INSERT INTO `Quizmaster`.`User` (`idUser`, `userName`, `password`, `role`, `firstName`, `lastName`)
VALUES ('2', 'User2', 'pwUser2', 'DOCENT', 'Huub', 'Huub-Barbatruuk');
INSERT INTO `Quizmaster`.`User` (`idUser`, `userName`, `password`, `role`, `firstName`, `lastName`)
VALUES ('3', 'User3', 'pwUser3', 'COORDINATOR', 'Co', 'Ordinator');
INSERT INTO `Quizmaster`.`User` (`idUser`, `userName`, `password`, `role`, `firstName`, `lastName`)
VALUES ('4', 'User4', 'pwUser4', 'ADMINISTRATOR', 'Ad', 'Ministrator');
INSERT INTO `Quizmaster`.`User` (`idUser`, `userName`, `password`, `role`, `firstName`, `lastName`)
VALUES ('5', 'User5', 'pwUser5', 'TECHNISCH_BEHEERDER', 'Rinus', 'Radeloos');
INSERT INTO `Quizmaster`.`User` (`idUser`, `userName`, `password`, `role`, `firstName`, `lastName`)
VALUES ('6', 'Daan', 'pwDaan', 'TECHNISCH_BEHEERDER', 'Daan', 'Banaan');

COMMIT;

SET SQL_MODE = @OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;