SELECT * FROM public.elections_v2
LIMIT 100;

SELECT * FROM public.elections_v2
WHERE year = 2013
ORDER BY na_value
LIMIT 100
;

CREATE TEMP TABLE total_seats AS
SELECT a.party, a.year, count(DISTINCT na_value) as contested_seats, won_seats, runnerup_seats
FROM public.elections_v2 a
LEFT JOIN (SELECT party, year, count(DISTINCT na_value) as won_seats 
           FROM public.elections_v2 WHERE year = 2013 AND rvotes = 1
          GROUP BY party, year) b
          ON a.party = b.party AND a.year = b.year
LEFT JOIN (SELECT party, year, count(DISTINCT na_value) as runnerup_seats
          FROM public.elections_v2 WHERE year = 2013 AND rvotes = 2
          GROUP BY party, year) c
          ON a.party = c.party AND a.year = c.year
WHERE a.year = 2013
GROUP BY a.party, a.year, won_seats, runnerup_seats
ORDER BY contested_seats DESC
;
-- 109 records

CREATE TEMP TABLE seats_by_province AS
SELECT a.party, a.year, a.prov, count(DISTINCT na_value) as contested_seats, won_seats, runnerup_seats
FROM public.elections_v2 a
LEFT JOIN (SELECT party, year, prov, count(DISTINCT na_value) as won_seats 
           FROM public.elections_v2 WHERE year = 2013 AND rvotes = 1
          GROUP BY party, year, prov) b
          ON a.party = b.party AND a.year = b.year AND a.prov = b.prov
LEFT JOIN (SELECT party, year, prov, count(DISTINCT na_value) as runnerup_seats
          FROM public.elections_v2 WHERE year = 2013 AND rvotes = 2
          GROUP BY party, year, prov) c
          ON a.party = c.party AND a.year = c.year AND a.prov = c.prov
WHERE a.year = 2013
GROUP BY a.party, a.year, a.prov, won_seats, runnerup_seats
ORDER BY contested_seats DESC
;
-- 189 records

SELECT DISTINCT na_name, prov 
FROM public.elections_v2
LIMIT 200;

SELECT * FROM public.elections_v2
LIMIT 100;


