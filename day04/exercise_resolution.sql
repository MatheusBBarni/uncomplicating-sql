-- Databricks notebook source
-- MAGIC %md
-- MAGIC ![Alt text](https://lwfiles.mycourse.app/633c72fac8c963ec854a3950-public/7c0c27a4b5a7870a2b9a1527bdd3a951.png "Imagem das tabelas")
-- MAGIC
-- MAGIC 1. Qual categoria tem mais produtos vendidos?
-- MAGIC 2. Qual categoria tem produtos mais caros, em média? E Mediana?
-- MAGIC 3. Qual categoria tem maiores fretes, em média?
-- MAGIC 4. Os clientes de qual estado pagam mais frete, em média?
-- MAGIC 5. Clientes de quais estados avaliam melhor, em média? Proporção de 5?
-- MAGIC 6. Vendedores de quais estados têm as piores reputações?
-- MAGIC 7. Quais estados de clientes levam mais tempo para a mercadoria chegar?
-- MAGIC 8. Qual meio de pagamento é mais utilizado por clientes do RJ?
-- MAGIC 9. Qual estado sai mais ferramentas?
-- MAGIC 10. Qual estado tem mais compras por cliente?

-- COMMAND ----------

-- 1. Qual categoria tem mais produtos vendidos?

SELECT
  p.descCategoria,
  count(*) AS qtdeCategoria
  -- count(DISTINCT ip.idPedido) AS qtdPedidos

FROM silver.olist.item_pedido AS ip

LEFT JOIN silver.olist.produto AS p
ON p.idProduto = ip.idProduto

GROUP BY p.descCategoria

ORDER BY qtdeCategoria DESC

LIMIT 1

-- COMMAND ----------

-- 2. Qual categoria tem produtos mais caros, em média? E Mediana?

SELECT
  p.descCategoria,
  avg(ip.vlPreco) AS avgPreco,
  percentile(ip.vlPreco, 0.5) AS percentilePreco

FROM silver.olist.item_pedido AS ip

LEFT JOIN silver.olist.produto AS p
ON p.idProduto = ip.idProduto

GROUP BY p.descCategoria

ORDER BY percentilePreco DESC

LIMIT 1

-- COMMAND ----------

-- 3. Qual categoria tem maiores fretes, em média?

SELECT
  p.descCategoria,
  avg(ip.vlFrete) AS avgFrete

FROM silver.olist.item_pedido AS ip

LEFT JOIN silver.olist.produto AS p
ON p.idProduto = ip.idProduto

GROUP BY p.descCategoria

ORDER BY avgFrete DESC

LIMIT 1

-- COMMAND ----------

-- 4. Os clientes de qual estado pagam mais frete, em média?

SELECT
  c.descUF,
  sum(ip.vlFrete) / count(DISTINCT ip.idPedido) AS avgFrete

FROM silver.olist.item_pedido AS ip

INNER JOIN silver.olist.pedido AS p
ON p.idPedido = ip.idPedido

LEFT JOIN silver.olist.cliente AS c
ON c.idCliente = p.idCliente

GROUP BY c.descUF

ORDER BY avgFrete DESC

-- COMMAND ----------

-- 5. Clientes de quais estados avaliam melhor, em média? Proporção de 5?

SELECT
  c.descUF,
  avg(ap.vlNota) AS avgNota,
  avg(CASE WHEN ap.vlNota = 5 THEN 1 ELSE 0 END) AS prop5

FROM silver.olist.avaliacao_pedido AS ap

INNER JOIN silver.olist.pedido AS p
ON p.idPedido = ap.idPedido

LEFT JOIN silver.olist.cliente AS c
ON c.idCliente = p.idCliente

GROUP BY c.descUF

ORDER BY prop5 DESC

-- COMMAND ----------

-- 6. Vendedores de quais estados têm as piores reputações?

SELECT
  v.descUF,
  avg(ap.vlNota) AS avgNota

FROM silver.olist.avaliacao_pedido AS ap

INNER JOIN silver.olist.item_pedido AS ip
ON ip.idPedido = ap.idPedido

LEFT JOIN silver.olist.vendedor AS v
ON v.idVendedor = ip.idVendedor

GROUP BY v.descUF

ORDER BY avgNota ASC

-- COMMAND ----------

-- 7. Quais estados de clientes levam mais tempo para a mercadoria chegar?

SELECT 
  c.descUF,
  avg(date_diff(p.dtEntregue, p.dtPedido)) AS avgQtdDias

FROM silver.olist.pedido AS p

LEFT JOIN silver.olist.cliente AS c
ON c.idCliente = p.idCliente

WHERE p.dtEntregue IS NOT NULL

GROUP BY c.descUF

ORDER BY avgQtdDias DESC

-- COMMAND ----------

-- 8. Qual meio de pagamento é mais utilizado por clientes do RJ?

SELECT
  pp.descTipoPagamento,
  count(DISTINCT pp.idPedido) AS qtdPedidos

FROM silver.olist.pagamento_pedido AS pp

INNER JOIN silver.olist.pedido AS p
ON pp.idPedido = p.idPedido

LEFT JOIN silver.olist.cliente AS c
ON c.idCliente = p.idCliente

WHERE c.descUF = 'RJ'

GROUP BY pp.descTipoPagamento

ORDER BY qtdPedidos DESC

LIMIT 1

-- COMMAND ----------

-- 9. Qual estado sai mais ferramentas?

SELECT
  v.descUF,
  count(*) AS qtdPedidos

FROM silver.olist.item_pedido AS ip

LEFT JOIN silver.olist.produto AS p
ON p.idProduto = ip.idProduto

LEFT JOIN silver.olist.vendedor AS v
ON v.idVendedor = ip.idVendedor

WHERE p.descCategoria LIKE '%ferramentas%'

GROUP BY v.descUF

ORDER BY qtdPedidos DESC

LIMIT 1

-- COMMAND ----------

-- 10. Qual estado tem mais compras por cliente?

SELECT
  c.descUF,
  count(DISTINCT p.idPedido) AS qtdPedidos,
  count(DISTINCT c.idClienteUnico) AS qtdClienteUnico,
  count(DISTINCT p.idPedido) / count(DISTINCT c.idClienteUnico) AS avgPedidoCliente

FROM silver.olist.pedido AS p

LEFT JOIN silver.olist.cliente AS c
ON c.idCliente = p.idCliente

GROUP BY c.descUF

ORDER BY avgPedidoCliente DESC
