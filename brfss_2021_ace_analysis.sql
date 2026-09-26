-- ============================================================
-- Childhood exposure to substance use and mental illness
-- CDC BRFSS 2021 (438,693 responses, 303 columns)
-- Shiloh Ayala · SQL · DB Browser for SQLite
-- Data: https://www.cdc.gov/brfss/annual_data/annual_2021.html
-- Note: all figures are unweighted sample proportions.
-- ============================================================


-- ------------------------------------------------------------
-- 1. CLEANING
-- Recode placeholder values, convert alcohol frequency to
-- days per month, separate missing answers from skipped
-- optional modules.
-- ------------------------------------------------------------

-- [Paste your cleaning queries here, from DB Browser:
--  View > SQL Log > "Submitted by User"]


-- ------------------------------------------------------------
-- 2. ADVERSE CHILDHOOD EXPERIENCES (ACE module)
-- Share of respondents who recalled alcohol use disorder,
-- mental illness or depression, and illegal drug use in the
-- home. Excludes 7 (don't know) and 9 (refused).
-- Result: 23.5% alcohol, 17.9% mental illness, 9.3% drugs
-- (n = 56,655)
-- ------------------------------------------------------------

SELECT
    COUNT(CASE WHEN acedrink = '1' THEN 1 END) AS acedrink_yes,
    COUNT(CASE WHEN acedeprs = '1' THEN 1 END) AS acedeprs_yes,
    COUNT(CASE WHEN acedrugs = '1' THEN 1 END) AS acedrugs_yes,
    COUNT(*) AS valid_total,
    COUNT(CASE WHEN acedrink = '1' THEN 1 END) * 100.0 / COUNT(*) AS acedrink_pct,
    COUNT(CASE WHEN acedeprs = '1' THEN 1 END) * 100.0 / COUNT(*) AS acedeprs_pct,
    COUNT(CASE WHEN acedrugs = '1' THEN 1 END) * 100.0 / COUNT(*) AS acedrugs_pct
FROM healthdata
WHERE acedrink IS NOT NULL
  AND acedeprs IS NOT NULL
  AND acedrugs IS NOT NULL
  AND acedrink NOT IN ('7', '9')
  AND acedeprs NOT IN ('7', '9')
  AND acedrugs NOT IN ('7', '9');


-- ------------------------------------------------------------
-- 3. DRINKING DAYS BY DEPRESSION DIAGNOSIS
-- Average drinking days per month for respondents with
-- (addepev3 = 1) and without (addepev3 = 2) a diagnosed
-- depressive disorder. Excludes 777 (don't know) and
-- 999 (refused). Assumes alcday5 was already converted to
-- days per month in step 1.
-- Result: 4.5 days (diagnosed) vs 5.0 days (not diagnosed)
-- ------------------------------------------------------------

SELECT
    addepev3,
    AVG(CAST(alcday5 AS FLOAT)) AS avg_drinking_days
FROM healthdata
WHERE addepev3 IN ('1', '2')
  AND alcday5 IS NOT NULL
  AND alcday5 NOT IN ('777', '999')
GROUP BY addepev3;
