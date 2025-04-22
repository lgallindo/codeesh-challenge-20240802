-- 4. Agrupar a quantidade de vendas que uma determinada Marca por Loja. 

SELECT
    orders.store_id
    ,stores.store_name
    ,products.brand_id
    ,brands.brand_name
    ,SUM(order_items.quantity) AS quantity
FROM order_items
LEFT JOIN orders -- Vários outros tipos de JOIN poderiam ser usados aqui, o LEFT é útil pra capturar falhas em bancos NoSQL
    ON
        order_items.order_id = orders.order_id
LEFT JOIN stores -- Mesmo racional do JOIN anterior
    ON
        orders.store_id = stores.store_id
LEFT JOIN products -- Mesmo racional do JOIN anterior
    ON
        order_items.product_id = products.product_id
LEFT JOIN brands -- Mesmo racional do JOIN anterior
    ON
        products.brand_id = brands.brand_id
GROUP BY
    orders.store_id
    ,stores.store_name
    ,products.brand_id
    ,brands.brand_name

-- Em um dashboard com drill-down/roll-up, uma query melhor seria:
SELECT
    orders.store_id
    ,stores.store_name
    ,stores.city
    ,stores.state
    ,stores.zip_code
    ,products.brand_id
    ,brands.brand_name
    ,SUM(order_items.quantity) AS quantity
FROM order_items
LEFT JOIN orders -- Vários outros tipos de JOIN poderiam ser usados aqui, o LEFT é útil pra capturar falhas em bancos NoSQL
    ON
        order_items.order_id = orders.order_id
LEFT JOIN stores -- Mesmo racional do JOIN anterior
    ON
        orders.store_id = stores.store_id
LEFT JOIN products -- Mesmo racional do JOIN anterior
    ON
        order_items.product_id = products.product_id
LEFT JOIN brands -- Mesmo racional do JOIN anterior
    ON
        products.brand_id = brands.brand_id
GROUP BY
    orders.store_id
    ,stores.store_name
    ,stores.city
    ,stores.state
    ,stores.zip_code
    ,products.brand_id
    ,brands.brand_name