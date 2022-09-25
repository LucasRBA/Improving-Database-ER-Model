SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Client` (
  `idClient` INT NOT NULL AUTO_INCREMENT,
  `Person_idPerson` INT NOT NULL,
  PRIMARY KEY (`idClient`),
  UNIQUE INDEX `idClient_UNIQUE` (`idClient` ASC)  ,
  INDEX `fk_Client_Person2_idx` (`Person_idPerson` ASC)  ,
  CONSTRAINT `fk_Client_Person2`
    FOREIGN KEY (`Person_idPerson`)
    REFERENCES `mydb`.`Person` (`idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Disponibility`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Disponibility` (
  `Supllier_idSupllier` INT NOT NULL,
  `Product_idProduct` INT NOT NULL,
  PRIMARY KEY (`Supllier_idSupllier`, `Product_idProduct`),
  INDEX `fk_Supllier_has_Product_Product1_idx` (`Product_idProduct` ASC)  ,
  INDEX `fk_Supllier_has_Product_Supllier1_idx` (`Supllier_idSupllier` ASC)  ,
  CONSTRAINT `fk_Supllier_has_Product_Supllier1`
    FOREIGN KEY (`Supllier_idSupllier`)
    REFERENCES `mydb`.`Supllier` (`idSupllier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Supllier_has_Product_Product1`
    FOREIGN KEY (`Product_idProduct`)
    REFERENCES `mydb`.`Product` (`idProduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Order` (
  `idOrder` INT NOT NULL AUTO_INCREMENT,
  `Status` ENUM('In Progress', 'In Transit', 'Delivered') NOT NULL,
  `Client_idClient` INT NOT NULL,
  `Total_Cost` FLOAT NOT NULL,
  `ShippingInfo_idShippingInfo` INT NOT NULL,
  `Count` INT NOT NULL,
  `Payment_idPayment` INT NOT NULL,
  PRIMARY KEY (`idOrder`),
  UNIQUE INDEX `idOrder_UNIQUE` (`idOrder` ASC)  ,
  INDEX `fk_Order_Client1_idx` (`Client_idClient` ASC)  ,
  INDEX `fk_Order_ShippingInfo1_idx` (`ShippingInfo_idShippingInfo` ASC)  ,
  INDEX `fk_Order_Payment1_idx` (`Payment_idPayment` ASC)  ,
  CONSTRAINT `fk_Order_Client1`
    FOREIGN KEY (`Client_idClient`)
    REFERENCES `mydb`.`Client` (`idClient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_ShippingInfo1`
    FOREIGN KEY (`ShippingInfo_idShippingInfo`)
    REFERENCES `mydb`.`ShippingInfo` (`idShippingInfo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_Payment1`
    FOREIGN KEY (`Payment_idPayment`)
    REFERENCES `mydb`.`Payment` (`idPayment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Person`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Person` (
  `idPerson` INT NOT NULL AUTO_INCREMENT,
  `Fname` VARCHAR(25) NOT NULL,
  `Lname` VARCHAR(25) NOT NULL,
  `Phone` CHAR(10) NOT NULL,
  `Birth_date` DATE NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `SSN` CHAR(9) NOT NULL,
  `Type` ENUM('Client', 'Seller') NOT NULL,
  `Address` VARCHAR(120) NOT NULL,
  PRIMARY KEY (`idPerson`),
  UNIQUE INDEX `idClient_UNIQUE` (`idPerson` ASC)  ,
  UNIQUE INDEX `Document_UNIQUE` (`SSN` ASC)  )
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Payment` (
  `idPayment` INT NOT NULL AUTO_INCREMENT,
  `Payment_type` ENUM('Credit', 'Debit', 'Check') NOT NULL,
  PRIMARY KEY (`idPayment`),
  UNIQUE INDEX `idPayment_UNIQUE` (`idPayment` ASC)  )
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Product` (
  `idProduct` INT NOT NULL AUTO_INCREMENT,
  `Category` ENUM('Toys', 'Electronics', 'Food', 'Furniture') NOT NULL,
  `Cost` FLOAT NOT NULL,
  `Description` VARCHAR(45) NULL,
  PRIMARY KEY (`idProduct`),
  UNIQUE INDEX `idProduct_UNIQUE` (`idProduct` ASC)  )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Product_In_Stock`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Product_In_Stock` (
  `Product_idProduct` INT NOT NULL,
  `Stock_idStock` INT NOT NULL,
  `Quantity` INT NOT NULL,
  PRIMARY KEY (`Product_idProduct`, `Stock_idStock`),
  INDEX `fk_Product_has_Stock_Stock1_idx` (`Stock_idStock` ASC)  ,
  INDEX `fk_Product_has_Stock_Product1_idx` (`Product_idProduct` ASC)  ,
  CONSTRAINT `fk_Product_has_Stock_Product1`
    FOREIGN KEY (`Product_idProduct`)
    REFERENCES `mydb`.`Product` (`idProduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Product_has_Stock_Stock1`
    FOREIGN KEY (`Stock_idStock`)
    REFERENCES `mydb`.`Stock` (`idStock`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Products_per_Order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Products_per_Order` (
  `Product_idProduct` INT NOT NULL,
  `Order_idOrder` INT NOT NULL,
  `Quantity` INT NOT NULL,
  PRIMARY KEY (`Product_idProduct`, `Order_idOrder`),
  INDEX `fk_Product_has_Order_Order1_idx` (`Order_idOrder` ASC)  ,
  INDEX `fk_Product_has_Order_Product1_idx` (`Product_idProduct` ASC)  ,
  CONSTRAINT `fk_Product_has_Order_Product1`
    FOREIGN KEY (`Product_idProduct`)
    REFERENCES `mydb`.`Product` (`idProduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Product_has_Order_Order1`
    FOREIGN KEY (`Order_idOrder`)
    REFERENCES `mydb`.`Order` (`idOrder`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Seller`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Seller` (
  `idSeller` INT NOT NULL AUTO_INCREMENT,
  `Person_idPerson` INT NOT NULL,
  PRIMARY KEY (`idSeller`),
  UNIQUE INDEX `idSeller_UNIQUE` (`idSeller` ASC)  ,
  INDEX `fk_Seller_Person1_idx` (`Person_idPerson` ASC)  ,
  CONSTRAINT `fk_Seller_Person1`
    FOREIGN KEY (`Person_idPerson`)
    REFERENCES `mydb`.` Person` (`idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Seller_has_Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Seller_has_Product` (
  `Seller_idSeller` INT NOT NULL,
  `Product_idProduct` INT NOT NULL,
  `Quantity` INT NOT NULL,
  PRIMARY KEY (`Seller_idSeller`, `Product_idProduct`),
  INDEX `fk_Seller_has_Product_Product1_idx` (`Product_idProduct` ASC)  ,
  INDEX `fk_Seller_has_Product_Seller1_idx` (`Seller_idSeller` ASC)  ,
  CONSTRAINT `fk_Seller_has_Product_Seller1`
    FOREIGN KEY (`Seller_idSeller`)
    REFERENCES `mydb`.`Seller` (`idSeller`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Seller_has_Product_Product1`
    FOREIGN KEY (`Product_idProduct`)
    REFERENCES `mydb`.`Product` (`idProduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ShippingInfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ShippingInfo` (
  `idShippingInfo` INT NOT NULL AUTO_INCREMENT,
  `Shipping_Status` VARCHAR(45) NOT NULL,
  `Shipping_Tracking` VARCHAR(45) NOT NULL,
  `Shipping_Cost` FLOAT NOT NULL,
  PRIMARY KEY (`idShippingInfo`),
  UNIQUE INDEX `idShippingInfo_UNIQUE` (`idShippingInfo` ASC)  )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Stock`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Stock` (
  `idStock` INT NOT NULL,
  `Warehouse_Location` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idStock`),
  UNIQUE INDEX `idStock_UNIQUE` (`idStock` ASC)  )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Supllier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Supllier` (
  `idSupllier` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idSupllier`),
  UNIQUE INDEX `idSupllier_UNIQUE` (`idSupllier` ASC)  )
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



