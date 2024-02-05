SELECT cat.name AS categoria_nombre, COUNT(pp.product_id) AS cantidad_vendida, SUM(pr.price) AS total_ventas
    FROM purchase_product pp
    JOIN purchase p ON pp.purchase_id = p.id
    JOIN product pr ON pp.product_id = pr.id
    JOIN category cat ON pr.category_id = cat.id
    JOIN customer c ON p.customer_id = c.id
    WHERE c.branch_id = 375 AND p.status = 'pagado'
    GROUP BY cat.id
    ORDER BY total_ventas ASC
    LIMIT 5;
