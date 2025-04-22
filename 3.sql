-- 3. Listar os Produtos sem Estoque;

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
        SUM(quantity) = 0
)

-- Usando um INNER JOIN para variar
SELECT
    *
FROM products
INNER JOIN (
    SELECT
        product_id
    FROM stocks
    GROUP BY
        product_id
    HAVING
        SUM(quantity) = 0
) AS estoque
    ON
        products.product_id = estoque.product_id
-- Novamente, lojas não foram mencionadas então desconsiderei.

-- Considerando cada loja como um estoque separado, a query ficaria assim:
SELECT
    estoque.store_id
    ,stores.store_name
    ,estoque.product_id
    ,products.product_name
    ,products.brand_id
    ,brands.brand_name
FROM (
    SELECT
        stocks.store_id
        ,stocks.product_id
    FROM stocks
    GROUP BY
        stocks.store_id
        ,product_id
    HAVING
        SUM(quantity) = 0
) AS estoque
INNER JOIN products
    ON
        products.product_id = estoque.product_id
INNER JOIN brands
    ON
        products.brand_id = brands.brand_id
INNER JOIN stores
    ON
        estoque.store_id = stores.store_id;