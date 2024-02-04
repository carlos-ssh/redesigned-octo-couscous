CREATE VIEW MostSellingProductByBranch AS
SELECT b.id AS branch_id, b.name AS branch_name, YEAR(p.created_at) AS year, MONTH(p.created_at) AS month, pp.product_id, pr.name AS product_name, COUNT(pp.product_id) AS cantidad_vendida
FROM purchase_product pp
JOIN purchase p ON pp.purchase_id = p.id
JOIN product pr ON pp.product_id = pr.id
JOIN customer c ON p.customer_id = c.id
JOIN branch b ON c.branch_id = b.id
WHERE p.status = 'pagado'
GROUP BY branch_id, year, month, pp.product_id
ORDER BY cantidad_vendida DESC;
