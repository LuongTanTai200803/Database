/* CREATE TABLE authors(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(55) NOT NULL
);
 */
 
CREATE TABLE books (
    id INT AUTO_INCREMENT PRIMARY KEY,
    author_id INT,
    title VARCHAR(55) NOT NULL,
    FOREIGN KEY (author_id) REFERENCES authors(id)
);