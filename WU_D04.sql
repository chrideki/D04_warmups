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


