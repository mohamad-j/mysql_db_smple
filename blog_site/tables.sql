-- Create the blog database schema
CREATE SCHEMA IF NOT EXISTS blog_site;
USE blog_site;

-- Create the users table for storing user information
CREATE TABLE IF NOT EXISTS users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    username VARCHAR(50) UNIQUE,
    email VARCHAR(100) UNIQUE,
    password VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the posts table for storing post information
CREATE TABLE IF NOT EXISTS posts (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    content TEXT,
    published_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Create the comments table for storing comments on posts
CREATE TABLE IF NOT EXISTS comments (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    content TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_id INT,
    post_id INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (post_id) REFERENCES posts(post_id)
);