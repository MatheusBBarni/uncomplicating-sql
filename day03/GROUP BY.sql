-- Databricks notebook source
SELECT descUF, count(DISTINCT idVendedor)

FROM silver.olist.vendedor

GROUP BY descUF

ORDER BY 2 DESC

-- COMMAND ----------

SELECT descUF, count(DISTINCT idVendedor)

FROM silver.olist.vendedor

GROUP BY descUF

ORDER BY count(DISTINCT idVendedor) DESC

-- COMMAND ----------

SELECT descUF, count(DISTINCT idVendedor) AS qtdVendedores

FROM silver.olist.vendedor

GROUP BY descUF

ORDER BY qtdVendedores DESC

-- COMMAND ----------

SELECT 
  descCategoria, 
  count(DISTINCT idProduto) as qtdProdutos,

  avg(vlPesoGramas) AS avgPeso,
  percentile(vlPesoGramas, 0.5) AS medianaPeso,

  avg(vlComprimentoCm * vlAlturaCm * vlLarguraCm) AS avgVolume,
  percentile(vlComprimentoCm * vlAlturaCm * vlLarguraCm, 0.5) AS medianaVolume

FROM silver.olist.produto

GROUP BY descCategoria

ORDER BY medianaPeso DESC

-- COMMAND ----------

SELECT 
  year(dtPedido) AS anoPedido,
  count(idPedido)

FROM silver.olist.pedido

GROUP BY anoPedido

ORDER BY anoPedido

-- COMMAND ----------

SELECT 
  year(dtPedido) || '-' || month(dtPedido) AS anoMesPedido,
  count(idPedido)

FROM silver.olist.pedido

GROUP BY anoMesPedido

ORDER BY anoMesPedido

-- COMMAND ----------

SELECT 
  date(date_trunc('month', dtPedido)) AS anoMesPedido,
  count(idPedido)

FROM silver.olist.pedido

GROUP BY anoMesPedido

ORDER BY anoMesPedido
