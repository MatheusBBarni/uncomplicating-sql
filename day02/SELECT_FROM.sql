-- Databricks notebook source
-- DBTITLE 1,Consultado tabelas
SELECT * 
FROM silver.olist.pedido
LIMIT 10

-- COMMAND ----------

SELECT *,
       vlPreco + vlFrete AS valor_total

FROM silver.olist.item_pedido

-- COMMAND ----------

SELECT 
  idPedido,
  idProduto,
  vlFrete,
  vlPreco,
  (vlPreco + vlFrete) as vlTotal

FROM silver.olist.item_pedido
