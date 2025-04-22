-- 5. Listar os Funcionarios que não estejam relacionados a um Pedido.

-- Funcionários sem vendas vão levar puxão de orelha.
SELECT
    staffs.*
FROM staffs
WHERE
    staffs.staff_id NOT IN (
        SELECT
            DISTINCT
                orders.staff_id
        FROM orders
    )
-- Inicialmente fiz essa com um JOIN, mas acho que fica mais claro assim.
-- Usando o JOIN e pensando em casos de uso realistas, teria de filtrar Staff que não é de vendas.
-- O otimizador de consultas consegue usar tabelas temporárias para evitar estourar a RAM.