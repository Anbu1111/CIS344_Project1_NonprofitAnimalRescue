-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema NonprofitAnimalRescue
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema NonprofitAnimalRescue
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `NonprofitAnimalRescue` ;
-- -----------------------------------------------------
-- Schema new_schema1
-- -----------------------------------------------------
USE `NonprofitAnimalRescue` ;

-- -----------------------------------------------------
-- Table `NonprofitAnimalRescue`.`Adoptor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NonprofitAnimalRescue`.`Adoptor` (
  `adoptor_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(50) NOT NULL,
  `Last_name` VARCHAR(50) NOT NULL,
  `Email` VARCHAR(100) NOT NULL,
  `phone_number` VARCHAR(20) NULL,
  PRIMARY KEY (`adoptor_id`),
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NonprofitAnimalRescue`.`Animal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NonprofitAnimalRescue`.`Animal` (
  `animal_id` INT NOT NULL AUTO_INCREMENT,
  `animal_name` VARCHAR(45) NOT NULL,
  `species` VARCHAR(45) NOT NULL,
  `adoption_fee` DECIMAL NOT NULL,
  `stock_quantity` INT NOT NULL,
  PRIMARY KEY (`animal_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NonprofitAnimalRescue`.`Adoption`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NonprofitAnimalRescue`.`Adoption` (
  `adoption_id` INT NOT NULL AUTO_INCREMENT,
  `adaptor_id` INT NOT NULL,
  `adoption_date` DATE NOT NULL,
  `adoption_status` VARCHAR(20) NOT NULL,
  `total_fee` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`adoption_id`),
  INDEX `fk_order_customer_idx` (`adaptor_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_customer`
    FOREIGN KEY (`adaptor_id`)
    REFERENCES `NonprofitAnimalRescue`.`Adoptor` (`adoptor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NonprofitAnimalRescue`.`Adoptionitem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NonprofitAnimalRescue`.`Adoptionitem` (
  `adoption_item_id` INT NOT NULL AUTO_INCREMENT,
  `adoption_id` INT NOT NULL,
  `animal_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  `unit_fee` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`adoption_item_id`),
  INDEX `fk_orderitem_order_idx` (`adoption_id` ASC) VISIBLE,
  INDEX `fk_orderitem_product_idx` (`animal_id` ASC) VISIBLE,
  CONSTRAINT `fk_orderitem_order`
    FOREIGN KEY (`adoption_id`)
    REFERENCES `NonprofitAnimalRescue`.`Adoption` (`adoption_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orderitem_product`
    FOREIGN KEY (`animal_id`)
    REFERENCES `NonprofitAnimalRescue`.`Animal` (`animal_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NonprofitAnimalRescue`.`DonationPayment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NonprofitAnimalRescue`.`DonationPayment` (
  `payment_id` INT NOT NULL AUTO_INCREMENT,
  `adoption_id` INT NOT NULL,
  `amount` DECIMAL(10,2) NOT NULL,
  `method` VARCHAR(30) NOT NULL,
  `Payment_date` DATE NOT NULL,
  PRIMARY KEY (`payment_id`),
  CONSTRAINT `fk_payments_order`
    FOREIGN KEY (`adoption_id`)
    REFERENCES `NonprofitAnimalRescue`.`Adoption` (`adoption_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
