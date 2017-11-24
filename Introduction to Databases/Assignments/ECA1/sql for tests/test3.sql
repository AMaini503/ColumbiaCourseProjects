-- TEST 3: UPDATE DOUGLAS' user_id FAILS
UPDATE `eca1`.`employee` SET user_id='DOGE.SNOXILL.729' WHERE user_id='DOUGY.SNOXILL.1';
UPDATE `eca1`.`employee` SET user_id='DOGE.SNOXILL.729' WHERE first_name='Douglas' and last_name='Snoxill';
SELECT * FROM `eca1`.`employee`;
