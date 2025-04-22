-- 1. Listar todos Clientes que não tenham realizado uma compra;

SELECT * FROM customers
WHERE customer_id NOT IN (SELECT DISTINCT customer_id FROM orders);

-- Em alguns dialetos SQL, o operador NOT EXISTS pode ser mais eficiente do que NOT IN, especialmente quando a subconsulta retorna um grande número de linhas.
-- Em outros (estou olhando para você, Spark SQL), pode ser necessário remover o ;