/* SELECT * FROM books; */

-- Cập nhật dữ liệu sách theo cách trường hợp CASE
/* UPDATE books
SET author_id = CASE
    WHEN title = 'Harry Potter' THEN 1
    WHEN title = 'Kafka on the Shore' THEN 2
    WHEN title = '1984' THEN 3
    ELSE author_id
END
WHERE title IN ('Harry Potter','Kafka on the Shore','1984'); 
*/

-- Xóa sách có tiêu đề '1984'
--DELETE FROM books WHERE title = '1984';

-- Thêm cột vào bảng đã tạo
 /* ALTER TABLE books
ADD (
    price INT,
    published_year INT
)
 */

 -- Cập nhật thêm dữ liệu trong bảng có sẵn bằng cách tạo bảng tạm
/* UPDATE books AS b
JOIN (
  SELECT 'Harry Potter' AS title, 150000 AS price, 2001 AS published_year
  UNION ALL
  SELECT 'Kafka on the Shore', 120000, 2005
) AS tmp
ON b.title = tmp.title
SET
  b.price = tmp.price,
  b.published_year = tmp.published_year; 
SELECT * FROM books WHERE price BETWEEN 100000 ANd 150000; */

-- Lấy sách có 'Harry' trong tiêu đề
--SELECT * FROM books WHERE title LIKE '%Harry%'

-- Lấy sách có giá thấp nhất
--SELECT * FROM books ORDER BY price DESC LIMIT 1;

-- Lấy sách có năm xuất bản nhỏ hơn 1990 hoặc giá nhỏ hơn 130000
SELECT * FROM books WHERE published_year < 1990 OR price < 130000;