-- MySQL Script generated by MySQL Workbench
-- Thu Dec  9 11:28:07 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema gdf
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `gdf` ;

-- -----------------------------------------------------
-- Schema gdf
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `gdf` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema new_schema1
-- -----------------------------------------------------
USE `gdf` ;

-- -----------------------------------------------------
-- Table `COUNTRY`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `COUNTRY` ;

CREATE TABLE IF NOT EXISTS `COUNTRY` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `CODE` CHAR(2) NOT NULL,
  `NAME` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `USER_ADDRESS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `USER_ADDRESS` ;

CREATE TABLE IF NOT EXISTS `USER_ADDRESS` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `ADDRESS_LINE` VARCHAR(75) NULL,
  `POSTCODE` VARCHAR(45) NOT NULL,
  `STATE` VARCHAR(75) NOT NULL,
  `CITY` VARCHAR(45) NOT NULL,
  `CREATED_ON` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UPDATED_ON` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `COUNTRY_ID` INT NOT NULL,
  PRIMARY KEY (`ID`, `COUNTRY_ID`),
  CONSTRAINT `fk_USER_ADDRESS_COUNTRY1`
    FOREIGN KEY (`COUNTRY_ID`)
    REFERENCES `COUNTRY` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_USER_ADDRESS_COUNTRY1_idx` ON `USER_ADDRESS` (`COUNTRY_ID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `USER`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `USER` ;

CREATE TABLE IF NOT EXISTS `USER` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `FIRSTNAME` VARCHAR(25) NOT NULL,
  `LASTNAME` VARCHAR(25) NULL,
  `GENDER` VARCHAR(6) NULL,
  `DOB` VARCHAR(10) NULL,
  `EMAIL` VARCHAR(100) NULL,
  `PHONE` VARCHAR(15) NULL,
  `MOBILE` VARCHAR(15) NULL,
  `CREATED_ON` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UPDATED_ON` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `PROFILE_FILE` VARCHAR(50) NULL,
  `IMAGE` BLOB NOT NULL,
  `USER_ADDRESS_ID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `fk_USER_USER_ADDRESS1`
    FOREIGN KEY (`USER_ADDRESS_ID`)
    REFERENCES `USER_ADDRESS` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_USER_USER_ADDRESS1_idx` ON `USER` (`USER_ADDRESS_ID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `DEED_CATEGORY`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DEED_CATEGORY` ;

CREATE TABLE IF NOT EXISTS `DEED_CATEGORY` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `TYPE` VARCHAR(45) NOT NULL,
  `SUBTYPE` VARCHAR(45) NOT NULL,
  `CONFIRMED` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DEEDER_ADDRESS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DEEDER_ADDRESS` ;

CREATE TABLE IF NOT EXISTS `DEEDER_ADDRESS` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `LINE1` VARCHAR(45) NULL,
  `LINE2` VARCHAR(45) NULL COMMENT '	',
  `POSTCODE` VARCHAR(45) NOT NULL,
  `STATE` VARCHAR(75) NOT NULL,
  `CITY` VARCHAR(45) NOT NULL,
  `CREATED_ON` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UPDATED_ON` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `COUNTRY_ID` INT NOT NULL,
  PRIMARY KEY (`ID`, `COUNTRY_ID`),
  CONSTRAINT `fk_DEEDER_ADDRESS_COUNTRY1`
    FOREIGN KEY (`COUNTRY_ID`)
    REFERENCES `COUNTRY` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_DEEDER_ADDRESS_COUNTRY1_idx` ON `DEEDER_ADDRESS` (`COUNTRY_ID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `DEEDER`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DEEDER` ;

CREATE TABLE IF NOT EXISTS `DEEDER` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `FIRSTNAME` VARCHAR(45) NOT NULL,
  `LASTNAME` VARCHAR(45) NOT NULL,
  `GENDER` VARCHAR(10) NULL,
  `DOB` VARCHAR(10) NULL,
  `EMAIL` VARCHAR(100) NULL,
  `PHONE` VARCHAR(15) NULL,
  `MOBILE` VARCHAR(15) NULL,
  `ABOUT` VARCHAR(350) NULL,
  `PROFILE_FILE` VARCHAR(50) NULL,
  `CREATED_ON` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UPDATED_ON` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `CONFIRMED` TINYINT NOT NULL DEFAULT 1,
  `IMAGE` BLOB NULL,
  `NOMINATED` TINYINT(1) NULL DEFAULT 0,
  `DEEDER_ADDRESS_ID` INT NOT NULL,
  PRIMARY KEY (`ID`, `DEEDER_ADDRESS_ID`),
  CONSTRAINT `fk_DEEDER_DEEDER_ADDRESS1`
    FOREIGN KEY (`DEEDER_ADDRESS_ID`)
    REFERENCES `DEEDER_ADDRESS` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_DEEDER_DEEDER_ADDRESS1_idx` ON `DEEDER` (`DEEDER_ADDRESS_ID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `NGO_CATEGORY`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `NGO_CATEGORY` ;

CREATE TABLE IF NOT EXISTS `NGO_CATEGORY` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `TYPE` VARCHAR(100) NOT NULL,
  `SUBTYPE` VARCHAR(100) NOT NULL,
  `CONFIRMED` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NGO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `NGO` ;

CREATE TABLE IF NOT EXISTS `NGO` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `NAME` VARCHAR(45) NOT NULL,
  `WEBSITE` VARCHAR(55) NULL,
  `NGO_CATEGORY_ID` INT NOT NULL,
  `CREATED_ON` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UPDATED_ON` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `DESCRIPTION` VARCHAR(350) NOT NULL,
  `EMAIL` VARCHAR(100) NOT NULL,
  `PROFILE_FILE` VARCHAR(50) NOT NULL,
  `IMAGE` BLOB NOT NULL,
  `CONFIRMED` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`ID`),
  CONSTRAINT `fk_NGO_NGO_CATEGORY1`
    FOREIGN KEY (`NGO_CATEGORY_ID`)
    REFERENCES `NGO_CATEGORY` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_NGO_NGO_CATEGORY1_idx` ON `NGO` (`NGO_CATEGORY_ID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `DEED`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DEED` ;

CREATE TABLE IF NOT EXISTS `DEED` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `DEED_DATE` DATE NOT NULL,
  `TITLE` VARCHAR(50) NOT NULL,
  `DESCRIPTION` VARCHAR(500) NOT NULL,
  `LINK1` VARCHAR(350) NOT NULL,
  `LINK2` VARCHAR(350) NULL,
  `LINK3` VARCHAR(350) NULL,
  `DEEDCATEGORY_ID` INT NOT NULL,
  `CONFIRMED` TINYINT NOT NULL DEFAULT 0,
  `CREATED_ON` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UPDATED_ON` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `DEEDER_ID` INT NULL,
  `NGO_ID` INT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `fk_DEED_DEEDCATEGORY1`
    FOREIGN KEY (`DEEDCATEGORY_ID`)
    REFERENCES `DEED_CATEGORY` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DEED_DEEDER1`
    FOREIGN KEY (`DEEDER_ID`)
    REFERENCES `DEEDER` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DEED_NGO1`
    FOREIGN KEY (`NGO_ID`)
    REFERENCES `NGO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_DEED_DEEDCATEGORY1_idx` ON `DEED` (`DEEDCATEGORY_ID` ASC) VISIBLE;

CREATE INDEX `fk_DEED_DEEDER1_idx` ON `DEED` (`DEEDER_ID` ASC) VISIBLE;

CREATE INDEX `fk_DEED_NGO1_idx` ON `DEED` (`NGO_ID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `BUSINESS_CATEGORY`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BUSINESS_CATEGORY` ;

CREATE TABLE IF NOT EXISTS `BUSINESS_CATEGORY` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `TYPE` VARCHAR(45) NOT NULL,
  `SUBTYPE` VARCHAR(45) NOT NULL,
  `CONFIRMED` TINYINT(1) NULL DEFAULT 0,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BUSINESS_ADDRESS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BUSINESS_ADDRESS` ;

CREATE TABLE IF NOT EXISTS `BUSINESS_ADDRESS` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `ADDRESS_LINE` VARCHAR(45) NOT NULL,
  `CITY` VARCHAR(45) NULL,
  `POSTCODE` VARCHAR(45) NULL,
  `STATE` VARCHAR(45) NULL,
  `PHONE` VARCHAR(15) NULL,
  `COUNTRY_ID` INT NOT NULL,
  PRIMARY KEY (`ID`, `COUNTRY_ID`),
  CONSTRAINT `fk_BUSINESS_ADDRESS_COUNTRY1`
    FOREIGN KEY (`COUNTRY_ID`)
    REFERENCES `COUNTRY` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_BUSINESS_ADDRESS_COUNTRY1_idx` ON `BUSINESS_ADDRESS` (`COUNTRY_ID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `BUSINESS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BUSINESS` ;

CREATE TABLE IF NOT EXISTS `BUSINESS` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `NAME` VARCHAR(45) NOT NULL,
  `EMAIL` VARCHAR(100) NOT NULL,
  `DESCRIPTION` VARCHAR(350) NULL,
  `WEBSITE` VARCHAR(100) NOT NULL,
  `CREATED_ON` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UPDATED_ON` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `BUSINESS_CATEGORY_ID` INT NOT NULL,
  `PROFILE_FILE` VARCHAR(50) NOT NULL,
  `CONFIRMED` TINYINT(1) NOT NULL DEFAULT 1,
  `IMAGE` BLOB NOT NULL,
  `BUSINESS_ADDRESS_ID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `fk_BUSINESS_BUSINESS_CATEGORY1`
    FOREIGN KEY (`BUSINESS_CATEGORY_ID`)
    REFERENCES `BUSINESS_CATEGORY` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_BUSINESS_BUSINESS_ADDRESS1`
    FOREIGN KEY (`BUSINESS_ADDRESS_ID`)
    REFERENCES `BUSINESS_ADDRESS` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_BUSINESS_BUSINESS_CATEGORY1_idx` ON `BUSINESS` (`BUSINESS_CATEGORY_ID` ASC) VISIBLE;

CREATE INDEX `fk_BUSINESS_BUSINESS_ADDRESS1_idx` ON `BUSINESS` (`BUSINESS_ADDRESS_ID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `DEED_ADDRESS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DEED_ADDRESS` ;

CREATE TABLE IF NOT EXISTS `DEED_ADDRESS` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `ADDRESS_LINE` VARCHAR(75) NOT NULL,
  `CITY` VARCHAR(45) NOT NULL,
  `POSTCODE` VARCHAR(10) NULL,
  `STATE` VARCHAR(45) NOT NULL,
  `CONFIRMED` INT NOT NULL DEFAULT 0,
  `DEED_ID` INT NOT NULL,
  `CREATED_ON` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UPDATED_ON` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `COUNTRY_ID` INT NOT NULL,
  PRIMARY KEY (`ID`, `COUNTRY_ID`),
  CONSTRAINT `fk_DEEDADDRESS_DEED1`
    FOREIGN KEY (`DEED_ID`)
    REFERENCES `DEED` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DEED_ADDRESS_COUNTRY1`
    FOREIGN KEY (`COUNTRY_ID`)
    REFERENCES `COUNTRY` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_DEEDADDRESS_DEED1_idx` ON `DEED_ADDRESS` (`DEED_ID` ASC) VISIBLE;

CREATE INDEX `fk_DEED_ADDRESS_COUNTRY1_idx` ON `DEED_ADDRESS` (`COUNTRY_ID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `BUSINESS_OFFER`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BUSINESS_OFFER` ;

CREATE TABLE IF NOT EXISTS `BUSINESS_OFFER` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `TYPE` VARCHAR(12) NOT NULL,
  `DESCRIPTION` VARCHAR(350) NULL,
  `DEED_ID` INT NOT NULL,
  `OFFERED_ON` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `BUSINESS_ID` INT NOT NULL,
  `VALUE` VARCHAR(25) NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `fk_OFFERS_DEED1`
    FOREIGN KEY (`DEED_ID`)
    REFERENCES `DEED` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OFFER_BUSINESS1`
    FOREIGN KEY (`BUSINESS_ID`)
    REFERENCES `BUSINESS` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_OFFERS_DEED1_idx` ON `BUSINESS_OFFER` (`DEED_ID` ASC) VISIBLE;

CREATE INDEX `fk_OFFER_BUSINESS1_idx` ON `BUSINESS_OFFER` (`BUSINESS_ID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `ACCESS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ACCESS` ;

CREATE TABLE IF NOT EXISTS `ACCESS` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `EMAIL` VARCHAR(50) NOT NULL,
  `PASSWORD` VARCHAR(50) NOT NULL,
  `ENTITY_TYPE` VARCHAR(10) NOT NULL DEFAULT 'USER',
  `FAILED_ATTEMPTS` INT NOT NULL DEFAULT 0,
  `CREATED_ON` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DEEDER_NOMINATION`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DEEDER_NOMINATION` ;

CREATE TABLE IF NOT EXISTS `DEEDER_NOMINATION` (
  `USER_ID` INT NOT NULL,
  `DEEDER_ID` INT NOT NULL,
  PRIMARY KEY (`USER_ID`, `DEEDER_ID`),
  CONSTRAINT `fk_USER_has_DEEDER_USER1`
    FOREIGN KEY (`USER_ID`)
    REFERENCES `USER` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_USER_has_DEEDER_DEEDER1`
    FOREIGN KEY (`DEEDER_ID`)
    REFERENCES `DEEDER` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_USER_has_DEEDER_DEEDER1_idx` ON `DEEDER_NOMINATION` (`DEEDER_ID` ASC) VISIBLE;

CREATE INDEX `fk_USER_has_DEEDER_USER1_idx` ON `DEEDER_NOMINATION` (`USER_ID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `GOVERNMENT_ORGS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GOVERNMENT_ORGS` ;

CREATE TABLE IF NOT EXISTS `GOVERNMENT_ORGS` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `MINISTRY` VARCHAR(100) NOT NULL,
  `DEPARTMENT` VARCHAR(100) NOT NULL,
  `CONFIRMED` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GOVERNMENT_ADDRESS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GOVERNMENT_ADDRESS` ;

CREATE TABLE IF NOT EXISTS `GOVERNMENT_ADDRESS` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `ADDRESS_LINE` VARCHAR(45) NOT NULL,
  `CITY` VARCHAR(45) NOT NULL,
  `POSTCODE` VARCHAR(45) NOT NULL,
  `STATE` VARCHAR(45) NOT NULL,
  `PHONE` VARCHAR(15) NULL,
  `COUNTRY_ID` INT NOT NULL,
  PRIMARY KEY (`ID`, `COUNTRY_ID`),
  CONSTRAINT `fk_GOVERNMENT_ADDRESS_COUNTRY1`
    FOREIGN KEY (`COUNTRY_ID`)
    REFERENCES `COUNTRY` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_GOVERNMENT_ADDRESS_COUNTRY1_idx` ON `GOVERNMENT_ADDRESS` (`COUNTRY_ID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `GOVERNMENT`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GOVERNMENT` ;

CREATE TABLE IF NOT EXISTS `GOVERNMENT` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `NAME` VARCHAR(150) NOT NULL,
  `EMAIL` VARCHAR(150) NOT NULL,
  `DESCRIPTION` VARCHAR(350) NOT NULL,
  `WEBSITE` VARCHAR(100) NULL,
  `CONTACT_NAME` VARCHAR(100) NULL,
  `GOVT_ORGS_ID` INT NOT NULL,
  `CREATED_ON` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UPDATED_ON` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `PROFILE_FILE` VARCHAR(50) NOT NULL,
  `CONFIRMED` TINYINT(1) NOT NULL DEFAULT 1,
  `IMAGE` BLOB NOT NULL,
  `GOVERNMENT_ADDRESS_ID` INT NOT NULL,
  PRIMARY KEY (`ID`, `GOVERNMENT_ADDRESS_ID`),
  CONSTRAINT `fk_GOVT_OFFICE_GOVT_ORGS1`
    FOREIGN KEY (`GOVT_ORGS_ID`)
    REFERENCES `GOVERNMENT_ORGS` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_GOVERNMENT_GOVERNMENT_ADDRESS1`
    FOREIGN KEY (`GOVERNMENT_ADDRESS_ID`)
    REFERENCES `GOVERNMENT_ADDRESS` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_GOVT_OFFICE_GOVT_ORGS1_idx` ON `GOVERNMENT` (`GOVT_ORGS_ID` ASC) VISIBLE;

CREATE INDEX `fk_GOVERNMENT_GOVERNMENT_ADDRESS1_idx` ON `GOVERNMENT` (`GOVERNMENT_ADDRESS_ID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `NGO_ADDRESS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `NGO_ADDRESS` ;

CREATE TABLE IF NOT EXISTS `NGO_ADDRESS` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `ADDRESS_LINE` VARCHAR(75) NOT NULL,
  `POSTCODE` VARCHAR(10) NOT NULL,
  `CITY` VARCHAR(45) NOT NULL,
  `STATE` VARCHAR(45) NOT NULL,
  `NGO_ID` INT NOT NULL,
  `PHONE` VARCHAR(15) NOT NULL,
  `COUNTRY_ID` INT NOT NULL,
  PRIMARY KEY (`ID`, `COUNTRY_ID`),
  CONSTRAINT `fk_NGO_ADDRESS_NGO1`
    FOREIGN KEY (`NGO_ID`)
    REFERENCES `NGO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_NGO_ADDRESS_COUNTRY1`
    FOREIGN KEY (`COUNTRY_ID`)
    REFERENCES `COUNTRY` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_NGO_ADDRESS_NGO1_idx` ON `NGO_ADDRESS` (`NGO_ID` ASC) VISIBLE;

CREATE INDEX `fk_NGO_ADDRESS_COUNTRY1_idx` ON `NGO_ADDRESS` (`COUNTRY_ID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `GOVERNMENT_OFFER`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GOVERNMENT_OFFER` ;

CREATE TABLE IF NOT EXISTS `GOVERNMENT_OFFER` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `TYPE` VARCHAR(12) NOT NULL,
  `DESCRIPTION` VARCHAR(150) NULL,
  `OFFERED_ON` TIMESTAMP NOT NULL,
  `DEED_ID` INT NOT NULL,
  `VALUE` VARCHAR(25) NULL,
  `GOVERNMENT_ID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `fk_GOVERNMENT_OFFER_DEED1`
    FOREIGN KEY (`DEED_ID`)
    REFERENCES `DEED` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_GOVERNMENT_OFFER_GOVERNMENT1`
    FOREIGN KEY (`GOVERNMENT_ID`)
    REFERENCES `GOVERNMENT` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_GOVERNMENT_OFFER_DEED1_idx` ON `GOVERNMENT_OFFER` (`DEED_ID` ASC) VISIBLE;

CREATE INDEX `fk_GOVERNMENT_OFFER_GOVERNMENT1_idx` ON `GOVERNMENT_OFFER` (`GOVERNMENT_ID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `NGO_OFFER`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `NGO_OFFER` ;

CREATE TABLE IF NOT EXISTS `NGO_OFFER` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `TYPE` VARCHAR(12) NOT NULL,
  `DESCRIPTION` VARCHAR(150) NULL,
  `OFFERED_ON` TIMESTAMP NULL,
  `NGO_ID` INT NOT NULL,
  `DEED_ID` INT NOT NULL,
  `VALUE` VARCHAR(25) NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `fk_NGO_OFFER_NGO1`
    FOREIGN KEY (`NGO_ID`)
    REFERENCES `NGO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_NGO_OFFER_DEED1`
    FOREIGN KEY (`DEED_ID`)
    REFERENCES `DEED` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_NGO_OFFER_NGO1_idx` ON `NGO_OFFER` (`NGO_ID` ASC) VISIBLE;

CREATE INDEX `fk_NGO_OFFER_DEED1_idx` ON `NGO_OFFER` (`DEED_ID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `DEED_COMMENT`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DEED_COMMENT` ;

CREATE TABLE IF NOT EXISTS `DEED_COMMENT` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `TEXT` VARCHAR(1000) NOT NULL,
  `DATE` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ACCESS_TYPE` VARCHAR(10) NOT NULL,
  `ACCESS_ID` INT NOT NULL,
  `DEED_ID` INT NOT NULL,
  `LIKES` INT NOT NULL DEFAULT 0,
  `POSTED_BY` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `fk_COMMENT_DEED1`
    FOREIGN KEY (`DEED_ID`)
    REFERENCES `DEED` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_COMMENT_DEED1_idx` ON `DEED_COMMENT` (`DEED_ID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `ON_HOLD`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ON_HOLD` ;

CREATE TABLE IF NOT EXISTS `ON_HOLD` (
  `EMAIL` VARCHAR(50) NOT NULL,
  `ENTITY_TYPE` VARCHAR(20) NOT NULL,
  `ENTITY_ID` INT NOT NULL,
  PRIMARY KEY (`EMAIL`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ACTIVITY`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ACTIVITY` ;

CREATE TABLE IF NOT EXISTS `ACTIVITY` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `DATE` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `MESSAGE` VARCHAR(250) NOT NULL,
  `ACCESS_ID` INT NOT NULL,
  `ACTIVITY_TYPE` VARCHAR(20) NOT NULL,
  `ENTITY_NAME` VARCHAR(125) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BUSINESS_OFFER_COMMENT`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BUSINESS_OFFER_COMMENT` ;

CREATE TABLE IF NOT EXISTS `BUSINESS_OFFER_COMMENT` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `TEXT` VARCHAR(800) NOT NULL,
  `ENTITY_TYPE` VARCHAR(15) NOT NULL,
  `POSTED_BY` VARCHAR(50) NOT NULL,
  `DATE` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `BUSINESS_OFFER_ID` INT NOT NULL,
  `LIKES` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`),
  CONSTRAINT `fk_BUSINESS_OFFER_COMMENT_BUSINESS_OFFER1`
    FOREIGN KEY (`BUSINESS_OFFER_ID`)
    REFERENCES `BUSINESS_OFFER` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_BUSINESS_OFFER_COMMENT_BUSINESS_OFFER1_idx` ON `BUSINESS_OFFER_COMMENT` (`BUSINESS_OFFER_ID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `GOVERNMENT_OFFER_COMMENT`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GOVERNMENT_OFFER_COMMENT` ;

CREATE TABLE IF NOT EXISTS `GOVERNMENT_OFFER_COMMENT` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `TEXT` VARCHAR(1000) NOT NULL,
  `DATE` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ENTITY_TYPE` VARCHAR(10) NOT NULL,
  `POSTED_BY` VARCHAR(50) NOT NULL,
  `GOVERNMENT_OFFER_ID` INT NOT NULL,
  `LIKES` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`),
  CONSTRAINT `fk_GOVERNMENT_OFFER_COMMENT_GOVERNMENT_OFFER1`
    FOREIGN KEY (`GOVERNMENT_OFFER_ID`)
    REFERENCES `GOVERNMENT_OFFER` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_GOVERNMENT_OFFER_COMMENT_GOVERNMENT_OFFER1_idx` ON `GOVERNMENT_OFFER_COMMENT` (`GOVERNMENT_OFFER_ID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `NGO_OFFER_COMMENT`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `NGO_OFFER_COMMENT` ;

CREATE TABLE IF NOT EXISTS `NGO_OFFER_COMMENT` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `TEXT` VARCHAR(1000) NOT NULL,
  `DATE` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ENTITY_TYPE` VARCHAR(10) NOT NULL,
  `POSTED_BY` VARCHAR(50) NOT NULL,
  `NGO_OFFER_ID` INT NOT NULL,
  `LIKES` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`),
  CONSTRAINT `fk_NGO_OFFER_COMMENT_NGO_OFFER1`
    FOREIGN KEY (`NGO_OFFER_ID`)
    REFERENCES `NGO_OFFER` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_NGO_OFFER_COMMENT_NGO_OFFER1_idx` ON `NGO_OFFER_COMMENT` (`NGO_OFFER_ID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `DEED_LIKE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DEED_LIKE` ;

CREATE TABLE IF NOT EXISTS `DEED_LIKE` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `DEED_ID` INT NOT NULL,
  `TIME` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ENTITY_ID` INT NOT NULL,
  `ENTITY_TYPE` VARCHAR(10) NOT NULL,
  `LIKE_BY_NAME` VARCHAR(75) NOT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `fk_DEED_LIKE_DEED1`
    FOREIGN KEY (`DEED_ID`)
    REFERENCES `DEED` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_DEED_LIKE_DEED1_idx` ON `DEED_LIKE` (`DEED_ID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `DEEDER_LIKE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DEEDER_LIKE` ;

CREATE TABLE IF NOT EXISTS `DEEDER_LIKE` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `DEEDER_ID` INT NOT NULL,
  `TIME` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `ENTITY_ID` INT NOT NULL,
  `ENTITY_TYPE` VARCHAR(10) NOT NULL,
  `LIKE_BY_NAME` VARCHAR(75) NOT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `fk_DEEDER_LIKE_DEEDER1`
    FOREIGN KEY (`DEEDER_ID`)
    REFERENCES `DEEDER` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_DEEDER_LIKE_DEEDER1_idx` ON `DEEDER_LIKE` (`DEEDER_ID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `BUSINESS_OFFER_LIKE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BUSINESS_OFFER_LIKE` ;

CREATE TABLE IF NOT EXISTS `BUSINESS_OFFER_LIKE` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `BUSINESS_OFFER_ID` INT NOT NULL,
  `TIME` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `ENTITY_ID` INT NOT NULL,
  `ENTITY_TYPE` VARCHAR(20) NOT NULL,
  `LIKE_BY_NAME` VARCHAR(75) NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `fk_BUSINESS_OFFER_LIKE_BUSINESS_OFFER1`
    FOREIGN KEY (`BUSINESS_OFFER_ID`)
    REFERENCES `BUSINESS_OFFER` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_BUSINESS_OFFER_LIKE_BUSINESS_OFFER1_idx` ON `BUSINESS_OFFER_LIKE` (`BUSINESS_OFFER_ID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `GOVERNMENT_OFFER_LIKE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GOVERNMENT_OFFER_LIKE` ;

CREATE TABLE IF NOT EXISTS `GOVERNMENT_OFFER_LIKE` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `GOVERNMENT_OFFER_ID` INT NOT NULL,
  `TIME` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `ENTITY_ID` INT NOT NULL,
  `ENTITY_TYPE` VARCHAR(20) NOT NULL,
  `LIKE_BY_NAME` VARCHAR(75) NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `fk_GOVERNMENT_OFFER_LIKE_GOVERNMENT_OFFER1`
    FOREIGN KEY (`GOVERNMENT_OFFER_ID`)
    REFERENCES `GOVERNMENT_OFFER` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_GOVERNMENT_OFFER_LIKE_GOVERNMENT_OFFER1_idx` ON `GOVERNMENT_OFFER_LIKE` (`GOVERNMENT_OFFER_ID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `NGO_OFFER_LIKE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `NGO_OFFER_LIKE` ;

CREATE TABLE IF NOT EXISTS `NGO_OFFER_LIKE` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `TIME` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ENTITY_ID` INT NOT NULL,
  `ENTITY_TYPE` VARCHAR(10) NOT NULL,
  `NGO_OFFER_ID` INT NOT NULL,
  `LIKE_BY_NAME` VARCHAR(75) NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `fk_NGO_OFFER_LIKE_NGO_OFFER1`
    FOREIGN KEY (`NGO_OFFER_ID`)
    REFERENCES `NGO_OFFER` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_NGO_OFFER_LIKE_NGO_OFFER1_idx` ON `NGO_OFFER_LIKE` (`NGO_OFFER_ID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `EMAIL_MESSAGE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `EMAIL_MESSAGE` ;

CREATE TABLE IF NOT EXISTS `EMAIL_MESSAGE` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `TEMPLATE` VARCHAR(45) NOT NULL,
  `MESSAGE_TITLE` VARCHAR(125) NOT NULL,
  `TEXT` VARCHAR(500) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VISITOR`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `VISITOR` ;

CREATE TABLE IF NOT EXISTS `VISITOR` (
  `IPADDRESS` VARCHAR(45) NOT NULL,
  `TIME` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`IPADDRESS`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FEEDBACK`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FEEDBACK` ;

CREATE TABLE IF NOT EXISTS `FEEDBACK` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `NAME` VARCHAR(75) NOT NULL,
  `EMAIL` VARCHAR(75) NOT NULL,
  `FEEDBACK_TEXT` VARCHAR(1000) NOT NULL,
  `DATETIME` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ISSUE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ISSUE` ;

CREATE TABLE IF NOT EXISTS `ISSUE` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `NAME` VARCHAR(75) NOT NULL,
  `EMAIL` VARCHAR(50) NOT NULL,
  `STATUS` VARCHAR(15) NOT NULL DEFAULT 'OPEN',
  `DETAILS` VARCHAR(500) NOT NULL,
  `TIMERAISED` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NGO_LIKE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `NGO_LIKE` ;

CREATE TABLE IF NOT EXISTS `NGO_LIKE` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `NGO_ID` INT NOT NULL,
  `TIME` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ENTITY_TYPE` VARCHAR(10) NOT NULL,
  `LIKE_BY_NAME` VARCHAR(75) NOT NULL,
  `ENTITY_ID` INT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `fk_NGO_LIKE_NGO1`
    FOREIGN KEY (`NGO_ID`)
    REFERENCES `NGO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_NGO_LIKE_NGO1_idx` ON `NGO_LIKE` (`NGO_ID` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
