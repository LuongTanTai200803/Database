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
-- DELETE FROM books WHERE title = '1984';

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
-- SELECT * FROM books WHERE title LIKE '%Harry%'

-- Lấy sách có giá thấp/cao DECS/ASC limit là số lượng lấy 
-- SELECT * FROM books ORDER BY price DESC LIMIT 1;

-- Lấy sách có năm xuất bản nhỏ hơn 1990 hoặc giá nhỏ hơn 130000
-- SELECT * FROM books WHERE published_year < 1990 OR price < 130000;

-- Đếm tổng số sách trong thư viện tạo cột total_books để đếm
-- SELECT COUNT(*) AS total_books FROM books;

-- Tính tổng giá trị tất cả sách
-- SELECT SUM(price) AS total_price FROM books;

-- Tính giá trung bình của sách, round để làm tròn tùy ý
/* SELECT ROUND(AVG(price), 0) AS avg_price 
FROM books; */

-- Tìm sách có giá cao nhất và thấp nhất
/* SELECT max(price) AS max_price, min(price) AS min_price 
FROM books; */

-- Lấy sách có giá thấp nhất và số lượng sách có giá đó
/* SELECT min(price) AS min_price,
       count(*) AS so_luong
FROM books
WHERE price = (SELECT min(price) AS min_price FROM books);
 */
-- Nhóm các sách có cùng author_id rồi trả về author_id và tổng giá tiền sách
/* SELECT author_id, SUM(price) AS tong_tien
FROM books
GROUP BY author_id;
 */
-- Nhóm các sách có cùng 1 tác giả rồi đếm số lượng sách của mỗi tác giả
/* 
SELECT author_id, COUNT(*) AS total
FROM books
GROUP BY author_id; */
-- Nhóm các sách cùng 1 tác giả và đếm số lượng lấy ra tác giả có số lượng sách lớn hơn 2
/* SELECT author_id, COUNT(*) total
FROM books
GROUP BY author_id
HAVING total >= 2
 */
/* SELECT author_id, COUNT(*) AS total
FROM books
WHERE price > 100 -- Điều kiện với dữ liệu gốc
GROUP BY author_id -- Gom nhóm theo author_id
HAVING total >= 2 -- Điều kiện sau nhóm
ORDER BY total DESC -- Sắp xếp giảm dần
LIMIT 3; -- Lấy top 3 */