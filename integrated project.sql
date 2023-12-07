SELECT 
  *
FROM
visits
LIMIT 5;

/*Viewing the vists table*/
SELECT 
  *
FROM
visits
LIMIT 5;

/* Viewing the water souce table*/
SELECT 
  *
FROM
water_source
LIMIT 5;

/*Querrying the data dictionary*/
SELECT
  *
FROM
data_dictionary;


/* Identifying all the unique water sources*/
SELECT DISTINCT
  type_of_water_source
FROM
water_source;

/* Query that retrieves all the records from the visits table*/
SELECT
  *
FROM
  visits
WHERE
time_in_queue > 500;

/* Querrying for sources with the longest wait time*/
SELECT
  *
FROM
  water_source
WHERE
  source_id = 'AkKi00881224'
  OR source_id = 'SoRu37635224'
  OR source_id = 'SoRu36096224';

/*Water sources with zero minutes queue time*/
SELECT 
  *
FROM
  water_source
WHERE
  source_id = 'HaZa21742224'
  OR source_id = 'HaRu17502224';
  
/* Query to find records where the subject quality score is 10 and the source was visited more than once*/

SELECT
 *
FROM
 water_quality 
WHERE
 subjective_quality_score = 10
 AND
 visit_count > 1;
 
 /*Retrieving the first few entries of the pollution table*/
 
SELECT
   *
FROM
   well_pollution
LIMIT 5;

/*query that checks if the results is Clean but the biological column is > 0.01.*/
SELECT
  *
FROM
 well_pollution 
WHERE 
 results = 'Clean'
AND
biological > 0.01;

/* Query to identify the records that mistakenly have the word Clean in the description*/
SELECT
  *
FROM
 well_pollution 
WHERE 
 results = 'Clean'
AND
 description like 'Clean%'
AND
biological > 0.01 ;
/*Case 1a: Update descriptions that mistakenly mention `Clean Bacteria: E. coli` to `Bacteria: E. coli`*/

UPDATE md_water_services.well_pollution
SET description = 'Bacteria: E. coli'
WHERE description = 'Clean Bacteria: E. coli';

/*Case 1b: Update the descriptions that mistakenly mention `Clean Bacteria: Giardia Lamblia` to `Bacteria: Giardia Lamblia*/

UPDATE md_water_services.well_pollution
SET description = 'Bacteria: Giardia Lamblia'
WHERE description = 'Clean Bacteria: Giardia Lamblia';
/*Case 2: Update the `result` to `Contaminated: Biological` where `biological` is greater than 0.01 plus current results is `Clean`*/

UPDATE md_water_services.well_pollution
SET results = 'Contaminated: Biological'
WHERE biological > 0.01;
/* Creating a copy of the well pollution table*/
CREATE TABLE
md_water_services.well_pollution_copy
AS (
SELECT
*
FROM
md_water_services.well_pollution
);

UPDATE
well_pollution_copy
SET
description = 'Bacteria:E.coli'
WHERE
description = 'Clean Bacteria:E.coli';
UPDATE
well_pollution_copy
SET
description = 'Bacteria:Giardia Lamblia'
WHERE
description = 'Clean Bacteria:Giardia Lamblia';
UPDATE
well_pollution_copy
SET
results = 'Contaminated: Biological'
WHERE
biological > 0.01 AND results = 'Clean';

SELECT
*
FROM
well_pollution_copy
WHERE
description LIKE "Clean_%"
OR (results = "Clean" AND biological > 0.01);

UPDATE
well_pollution_copy
SET
description = 'Bacteria: E. coli'
WHERE
description = 'Clean Bacteria: E. coli';
UPDATE
well_pollution_copy
SET
description = 'Bacteria: Giardia Lamblia'
WHERE
description = 'Clean Bacteria: Giardia Lamblia';
UPDATE
well_pollution_copy
SET
results = 'Contaminated: Biological'
WHERE
biological > 0.01 AND results = 'Clean';
DROP TABLE
md_water_services.well_pollution_copy;


