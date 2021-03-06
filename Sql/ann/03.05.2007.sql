CREATE VIEW S_RELEASE(
    DATERELEASE,
    RELEASE_ID,
    PUBLISHING_ID)
AS
SELECT MAX(R.DATERELEASE) AS DATERELEASE,
       MAX(R.RELEASE_ID) AS RELEASE_ID,
       R.PUBLISHING_ID
FROM RELEASE R
GROUP BY R.PUBLISHING_ID;
