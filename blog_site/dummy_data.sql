-- Insert dummy data into the users table
INSERT INTO users (first_name, last_name, username, email, password)
SELECT
    CONCAT('User', id),
    CONCAT('Last', id),
    CONCAT('user', id),
    CONCAT('user', id, '@example.com'),
    MD5(CONCAT('password', id)) -- Hashed dummy password
FROM
    (SELECT n + m * 10 + 1 AS id
    FROM 
        (SELECT 0 AS n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) t,
        (SELECT 0 AS m UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) t2
    ) numbers
LIMIT 100;

-- Insert dummy data into the posts table
INSERT INTO posts (title, content, user_id)
SELECT
    CONCAT('Title', id),
    CONCAT('Content for post ', id),
    user_id
FROM
    (SELECT n + m * 10 + 1 AS id,
            user_id
    FROM 
        (SELECT 0 AS n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) t,
        (SELECT 0 AS m UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) t2,
        (SELECT user_id FROM users ORDER BY RAND() LIMIT 100) users
    ) numbers;

-- Insert dummy data into the comments table
INSERT INTO comments (content, user_id, post_id)
SELECT
    CONCAT('Comment content for post ', numbers.id),
    numbers.user_id,
    numbers.post_id
FROM
    (SELECT n + m * 10 + 1 AS id,
            users_posts.user_id,
            users_posts.post_id
    FROM 
        (SELECT 0 AS n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) t,
        (SELECT 0 AS m UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) t2,
        (SELECT posts.user_id, posts.post_id FROM users CROSS JOIN posts ORDER BY RAND() LIMIT 100) users_posts
    ) numbers;