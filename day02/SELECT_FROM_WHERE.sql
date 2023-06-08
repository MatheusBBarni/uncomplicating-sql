-- Databricks notebook source
SELECT *

FROM silver.olist.item_pedido

WHERE vlPreco >= 500

-- COMMAND ----------

SELECT *

FROM silver.olist.item_pedido

WHERE vlFrete > vlPreco

-- COMMAND ----------

SELECT 
  *

FROM silver.olist.item_pedido

WHERE 
  vlPreco >= 100
AND
  vlFrete > vlPreco

-- COMMAND ----------

SELECT 
  *

FROM silver.olist.produto

WHERE descCategoria = 'pet_shop'
OR descCategoria = 'telefonia'
OR descCategoria = 'bebes'

-- COMMAND ----------

SELECT 
  *

FROM silver.olist.produto

WHERE
  descCategoria IN ('pet_shop', 'telefonia', 'bebes')

-- COMMAND ----------

SELECT 
  idPedido,
  idCliente,
  descSituacao,
  date(dtPedido)

FROM silver.olist.pedido

WHERE date(dtPedido) >= '2017-01-01'
AND date(dtPedido) <= '2017-01-31'

-- COMMAND ----------

SELECT *

FROM silver.olist.pedido

WHERE year(dtPedido) = 2017
AND month(dtPedido) = 1

-- COMMAND ----------

SELECT *

FROM silver.olist.pedido

WHERE year(dtPedido) = 2017
AND (month(dtPedido) = 1
OR month(dtPedido) = 6)

-- COMMAND ----------

SELECT *

FROM silver.olist.pedido

WHERE year(dtPedido) = 2017
AND month(dtPedido) IN (1, 6)
