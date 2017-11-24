
-- TEST 2a: UPDATE FIRST_NAME `DOUGY` TO `DOUGLAS`, CREATED = NOW()
UPDATE `eca1`.`employee` SET `first_name`='Douglas', `created` = NOW() WHERE user_id = 'DOUGY.SNOXILL.1';
SELECT * FROM `eca1`.`employee` WHERE user_id = 'DOUGY.SNOXILL.1';