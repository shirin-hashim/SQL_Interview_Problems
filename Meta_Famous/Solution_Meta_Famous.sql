/* SUPPORT QUERY */
CREATE TABLE famous (user_id BIGINT, follower_id BIGINT);

INSERT INTO famous
VALUES(1, 2),
    (1, 3),
    (2, 4),
    (5, 1),
    (5, 3),
    (6, 4),
    (6, 2),
    (8, 5);

/* ANSWER QUERY */
WITH rn AS (
    SELECT user_id,
        follower_id,
        ROW_NUMBER() OVER (PARTITION BY user_id) AS RowNumber
    FROM famous
),
cnt AS (
    SELECT user_id,
        COUNT(RowNumber) AS num_followers
    FROM rn
    GROUP BY user_id
),
total_users AS (
    SELECT COUNT(DISTINCT user_id) AS t_users
    FROM cnt
)
SELECT *,
    ROUND(f.num_followers * 100 / t.t_users, 2) AS famous_percentage
FROM cnt f
    CROSS JOIN total_users t;

