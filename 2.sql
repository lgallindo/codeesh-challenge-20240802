-- 2. Listar os Produtos que não tenham sido comprados

-- Dá pra copiar toda a lógica da query 1
SELECT
    *
FROM products
WHERE product_id NOT IN (
    SELECT
        DISTINCT
            product_id
    FROM order_items
);
-- Essa query retorna todos os produtos que não tiveram compras

-- Ou por "não foram comprados" você entende produto que ainda tem estoque?
-- Se for isso, a query seria:
SELECT
    *
FROM products
WHERE product_id IN (
    SELECT
        product_id
    FROM stocks
    GROUP BY
        product_id
    HAVING
        SUM(quantity) > 0
)

-- Um terceiro possível entendimento é que você quer listar os produtos nos quais o estoque sobra após a entrega das compras
-- Se for isso, a query seria:
SELECT
    *
FROM products
WHERE product_id IN (
    SELECT
        product_id
    FROM (
        SELECT
            product_id
            ,SUM(quantity) AS quantity
        FROM order_items
        GROUP BY product_id
    ) AS vendas
    INNER JOIN (
        SELECT
            product_id
            ,SUM(quantity) AS quantity
        FROM stocks
        GROUP BY product_id
    ) AS estoque
        ON
            vendas.product_id = stocks.product_id
        WHERE
            estoque.quantity - vendas.quantity > 0
            AND
            estoque.quantity > 0
)
-- Desconsiderei lojas aqui.