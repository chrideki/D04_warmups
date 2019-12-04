WITH january_comment AS(
    SELECT
        user_id,
        COUNT(*) AS number_of_comment_january19
    FROM user_comments
    GROUP BY user_id, created_at
    HAVING EXTRACT(YEAR FROM created_at ) = 2019 AND
        EXTRACT(MONTH FROM created_at ) = 1
)
SELECT
    number_of_comment_january19,
    COUNT(*)
FROM january_comment
GROUP BY number_of_comment_january19;


-- changing the width of the bin

WITH january_comment AS(
    SELECT
        user_id,
        COUNT(*) AS number_of_comment_january19
    FROM user_comments
    GROUP BY user_id, created_at
    HAVING EXTRACT(YEAR FROM created_at ) = 2019 AND
        EXTRACT(MONTH FROM created_at ) = 1
), january_comment_frequency AS(
SELECT
    number_of_comment_january19,
    COUNT(*) AS frequency
FROM january_comment
GROUP BY number_of_comment_january19
), new_january_comment_frequency AS(
SELECT
    *,
    LEAD(frequency,1) OVER (ORDER BY number_of_comment_january19) freq_next_bin,
    number_of_comment_january19 || '-' || LEAD(number_of_comment_january19,1) OVER (ORDER BY number_of_comment_january19) new_bin_width,
    frequency + LEAD(frequency,1) OVER (ORDER BY number_of_comment_january19) freq_new_bin
FROM january_comment_frequency
)
SELECT
    *
FROM new_january_comment_frequency 
WHERE number_of_comment_january19 % 2 <> 0;




-- try with northwind dataset


WITH january_ship AS(
    SELECT
        customer_id,
        COUNT(*) AS number_of_comment_january19
    FROM orders
    GROUP BY customer_id, shipped_date
    HAVING EXTRACT(YEAR FROM shipped_date ) = 1996 
), frequency AS(
SELECT
    number_of_comment_january19,
    COUNT(*) AS frequency
FROM january_ship
GROUP BY number_of_comment_january19
), new_frequency AS(
SELECT
    *,
    LEAD(frequency,1) OVER (ORDER BY number_of_comment_january19) freq_next_bin,
    number_of_comment_january19 || '-' || LEAD(number_of_comment_january19,1) OVER (ORDER BY number_of_comment_january19) new_bin_width,
    frequency + LEAD(frequency,1) OVER (ORDER BY number_of_comment_january19) freq_new_bin
FROM frequency
)
SELECT
    *
FROM new_frequency
WHERE number_of_comment_january19 % 2 <> 0;