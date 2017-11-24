CREATE SCHEMA IF NOT EXISTS `eca1` DEFAULT CHARACTER SET latin1 ;
USE `eca1` ;

-- -----------------------------------------------------
-- Table `eca1`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eca1`.`employee` (
  `first_name` VARCHAR(32) NOT NULL,
  `last_name` VARCHAR(32) NOT NULL,
  `email` VARCHAR(80) NULL DEFAULT NULL,
  `created` DATETIME NOT NULL,
  `user_id` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `eca1`.`user_prefix_count`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eca1`.`user_prefix_count` (
  `prefix` VARCHAR(65) NOT NULL,
  `max_value` INT(11) NOT NULL,
  PRIMARY KEY (`prefix`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

USE `eca1`;

DELIMITER $$
USE `eca1`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `eca1`.`employee_BEFORE_INSERT`
BEFORE INSERT ON `eca1`.`employee`
FOR EACH ROW
BEGIN
	DECLARE old_count INT;
    DECLARE prefix VARCHAR(65);
    DECLARE prefix_exists BOOL;
    
    -- PREFIX = FIRST_NAME.LAST_NAME
    SET prefix = CONCAT(UPPER(NEW.first_name), '.', UPPER(NEW.last_name));

	-- CHECK IF PREFIX EXISTS
    SET prefix_exists = EXISTS(SELECT max_value FROM user_prefix_count WHERE user_prefix_count.prefix = prefix);
    
    -- IF EXISTS, GET THE OLD COUNT FROM THE TABLE
    If prefix_exists THEN
		SET old_count = (SELECT max_value FROM user_prefix_count WHERE user_prefix_count.prefix = prefix);
        
		-- UPDATE THE user_prefix_count
		UPDATE user_prefix_count SET max_value = old_count + 1 WHERE user_prefix_count.prefix = prefix;
	ELSE
		-- IF PREFIX DOESN'T EXIST, THIS IS THE FIRST USER
		SET old_count = 0;
        
        -- INSERT THE NEW USER
        INSERT INTO user_prefix_count(prefix,max_value) VALUES(prefix, old_count + 1);
    END IF;
    
    -- SET THE NEW USER ID
    SET NEW.user_id = CONCAT(prefix, '.', old_count + 1);
    
    -- SET THE CURRENT DATE & TIME
    SET NEW.created = NOW();
    
    
END$$

USE `eca1`$$
CREATE DEFINER = CURRENT_USER TRIGGER `eca1`.`employee_BEFORE_UPDATE` BEFORE UPDATE ON `employee` FOR EACH ROW
BEGIN
		-- IF ATTEMPTING TO CHANGE USER_ID, THROW ERROR
        IF NEW.user_id <> OLD.user_id THEN
			SIGNAL SQLSTATE '02222' SET MESSAGE_TEXT = 'Can\'t change user_id. It is immutable!';
        END IF;
	
		-- IF ATTEMPTING TO CHANGE THE `CREATED` TIMESTAMP, IGNORE IT => SET IT TO THE OLD VALUE
		IF NEW.created <> OLD.created THEN
			SET NEW.created = OLD.created;
        END IF;
		
END$$


DELIMITER ;