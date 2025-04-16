-- Lấy toàn bộ thông tin người dùng
-- SELECT * FROM users;

-- Lấy tên và giá của tất cả sản phẩm có giá > 500
/* SELECT name, price
FROM products
WHERE price > 500; */

-- Lấy các đơn hàng (orders) được đặt sau ngày 2025-04-11
/* SELECT * 
FROM orders
WHERE order_date > '2025-04-11'; */

-- Tìm người dùng có tuổi > 23
/* SELECT *
FROM users
WHERE age > 23; */

-- Tìm sản phẩm có giá từ 500 đến 1000
/* SELECT *
FROM products
WHERE price > 500 AND price < 1000; */

-- Sắp xếp người dùng theo tuổi giảm dần
/* SELECT *
FROM users
ORDER BY age DESC;  */

-- Lấy danh sách đơn hàng kèm tên người mua và tên sản phẩm
/* SELECT u.name AS user_name, p.name, o.*
FROM orders o
JOIN users u ON o.user_id = u.id
JOIN products p ON o.product_id = p.id
ORDER BY o.id ASC; */

-- Lấy tên sản phẩm và tổng số lượng đã bán ra kể cả sản phẩm chưa từng bán
/* SELECT p.name AS product, COUNT(o.product_id) AS soluong
FROM orders o
RIGHT JOIN products p ON o.product_id = p.id
GROUP BY p.id -- lấy bảng bên chuẩn nghĩa là bảng products
 */

-- Đếm số lượng đơn hàng theo từng người dùng
/* SELECT u.*, COUNT(o.user_id) AS soluong_donhang
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
GROUP BY u.id;
 */

-- Lấy người dùng đã đặt hơn 1 đơn hàng
/* SELECT u.*, COUNT(o.user_id) AS soluong_donhang
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
GROUP BY u.id
HAVING COUNT(o.user_id) > 1;  */

-- Tìm người dùng có tổng giá trị đơn hàng cao nhất
/* SELECT u.id, u.name, SUM(price*quantity) AS tonggiatri
FROM orders o
JOIN users u ON o.user_id = u.id
JOIN products p ON o.product_id = p.id
GROUP BY u.id, u.name
ORDER BY SUM(price*quantity) DESC
LIMIT 1; 
WITH tmp AS (
  SELECT u.id, u.name, SUM(price*quantity) AS tonggiatri
  FROM orders o
  JOIN users u ON o.user_id = u.id
  JOIN products p ON o.product_id = p.id
  GROUP BY u.id, u.name
  
),
xep_hang AS(
  SELECT *, RANK() OVER (ORDER BY tonggiatri DESC) AS hang
  FROM tmp
)

SELECT *
FROM xep_hang
WHERE hang = 1; */

-- Lấy danh sách người dùng chưa từng mua hàng
/* SELECT *
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
WHERE o.id IS NULL */

--  Với mỗi người dùng, liệt kê tổng số tiền họ đã chi, sắp xếp theo số tiền giảm dần

/* SELECT u.id, u.name, SUM(p.price * o.quantity) AS tonggiatri
FROM orders o
JOIN users u ON o.user_id = u.id
JOIN products p ON o.product_id = p.id
GROUP BY u.id, u.name
ORDER BY tonggiatri DESC;
 */

-- Với mỗi sản phẩm, liệt kê: tên sản phẩm, tổng số lần bán, tổng số lượng bán, tổng doanh thu

/* SELECT p.id, p.name, COUNT(o.product_id) AS solanban, SUM(o.quantity) AS soluongban, SUM(p.price * o.quantity) AS tongdoanhthu
FROM orders o
LEFT JOIN products p ON o.product_id = p.id
GROUP BY p.id */

-- Lấy đơn hàng có giá trị cao nhất của mỗi người dùng

/* SELECT u.name, o.product_id, tonggiatri
FROM (
  SELECT o.*, (p.price * o.quantity) AS tonggiatri,
    RANK() OVER (PARTITION BY o.user_id ORDER BY (p.price * o.quantity) DESC) AS rnk
  FROM orders o
  LEFT JOIN products p ON o.product_id = p.id
) o
JOIN users u ON o.user_id = u.id
WHERE o.rnk = 1;
 */

-- Lấy tên người dùng và xếp hạng họ theo tổng chi tiêu

/* SELECT *
FROM (
  SELECT   
    u.name,
    SUM(p.price * o.quantity) AS tongchitieu, 
    RANK() OVER (ORDER BY SUM(p.price * o.quantity) DESC) AS hang
  FROM orders o
  LEFT JOIN users u ON o.user_id = u.id
  LEFT JOIN products p ON o.product_id = p.id
  GROUP BY o.user_id
) AS tmp;
 */

--  Với mỗi đơn hàng, hiển thị thêm cột "loại" phân loại theo giá trị đơn hàng

/* SELECT 
  o.*,
  (p.price * o.quantity) AS tonggiatri,
  CASE
      WHEN (p.price * o.quantity) < 1000 THEN "Nhỏ"
      WHEN (p.price * o.quantity) BETWEEN 1000 AND 3000 THEN "Trung bình"
      WHEN (p.price * o.quantity) > 3000 THEN "Lớn"
  END AS loai
FROM orders o
JOIN products p ON o.product_id = p.id

 */
