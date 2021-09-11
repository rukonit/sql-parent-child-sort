DECLARE @Counter INTDECLARE @Count   INTSET @Counter=0SET @Count =
(
       SELECT Count(*)
       FROM   zpxpa048_org) -1SELECT *
INTO   #s
FROM   zpxpa048_org
WHERE  parent_unit_primary_code = 50000025SELECT *
INTO   #t
FROM   zpxpa048_org
WHERE  parent_unit_primary_code = 50000025SET @Counter =
(
       SELECT Count(*)
       FROM   #s)SELECT *
FROM   #sWHILE ( @Counter < @Count)
BEGIN
  DROP TABLE
  if exists #u;
  SELECT *
  INTO   #u
  FROM   zpxpa048_org
  WHERE  parent_unit_primary_code IN
         (
                SELECT primary_code
                FROM   #s)
  DELETE
  FROM   #u
  WHERE  primary_code IN
         (
                SELECT primary_code
                FROM   #s)
  SELECT *
  FROM   #u
  TRUNCATE TABLE #s
  INSERT INTO #s
  SELECT *
  FROM   #u
  INSERT INTO #t
  SELECT *
  FROM   #u
  SET @Counter = @Counter +
  (
         SELECT Count(*)
         FROM   #u)
  PRINT @Counter
ENDDROP TABLE #sSELECT *
FROM   #t
