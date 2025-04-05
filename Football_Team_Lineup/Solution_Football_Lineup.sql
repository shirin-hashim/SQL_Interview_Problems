/* SUPPORT QUERY */

CREATE TABLE teams (
    team_id INT PRIMARY KEY,
    team_name VARCHAR(50) NOT NULL
);

CREATE TABLE matches (
    match_id INT PRIMARY KEY,
    host_team INT,
    guest_team INT,
    host_goals INT,
    guest_goals INT
);
INSERT INTO teams (team_id, team_name)
VALUES(10, 'Give'),
    (20, 'Never'),
    (30, 'You'),
    (40, 'Up'),
    (50, 'Gonna');
    
INSERT INTO matches (match_id, host_team, guest_team, host_goals, guest_goals)
VALUES(1, 30, 20, 1, 0),
(2, 10, 20, 1, 2),
(3, 20, 50, 2, 2),
(4, 10, 30, 1, 0),
(5, 30, 50, 0, 1);

/* ANSWER QUERY */

WITH score_board AS (
    SELECT *,
        CASE
            WHEN host_goals > guest_goals THEN 3
            WHEN host_goals < guest_goals THEN 0
            ELSE 1
        END AS host_score,
        CASE
            WHEN host_goals > guest_goals THEN 0
            WHEN host_goals < guest_goals THEN 3
            ELSE 1
        END AS guest_score
    FROM matches
),
host_score AS (
    SELECT host_team,
        SUM(host_score) AS total_host_score
    FROM score_board
    GROUP BY host_team
),
guest_score AS (
    SELECT guest_team,
        SUM(guest_score) AS total_guest_score
    FROM score_board
    GROUP BY guest_team
),
points_table AS (
    SELECT *
    FROM host_score
    UNION ALL
    SELECT *
    FROM guest_score
),
merged_points_table AS (
    SELECT host_team AS team_id,
        SUM(total_host_score) AS score
    FROM points_table
    GROUP BY host_team
)
SELECT t.team_id,
    t.team_name,
    COALESCE(score, 0) AS num_points
FROM teams t
    LEFT JOIN merged_points_table m ON t.team_id = m.team_id
ORDER BY num_points DESC,
    team_id ASC;

