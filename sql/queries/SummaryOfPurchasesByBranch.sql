DELIMITER //
CREATE PROCEDURE SummaryOfPurchasesByBranch(IN _branch_id INT)
BEGIN
    SELECT c.name, c.age, c.email,
    SUM(p.status = 'pagado') AS 'compras_pagadas',
    SUM(CASE WHEN p.status = 'pagado' THEN p.total ELSE 0 END) AS 'total_pagado',
    SUM(p.status = 'cancelado') AS 'compras_canceladas',
    SUM(CASE WHEN p.status = 'cancelado' THEN p.total ELSE 0 END) AS 'total_cancelado',
    IF(SUM(p.status = 'pagado') > SUM(p.status = 'cancelado'), 'Sí', 'No') AS 'excelente_comprador'
    FROM purchase p
    JOIN customer c ON p.customer_id = c.id
    WHERE c.branch_id = _branch_id
    GROUP BY c.id;
END //
DELIMITER ;

