-- Databricks notebook source
SELECT 
  count(*),
  count(1)
FROM silver.olist.pedido

-- COMMAND ----------

SELECT 
  count(descSituacao),
  count(DISTINCT descSituacao)
FROM silver.olist.pedido

-- COMMAND ----------

SELECT 
  count(idPedido)
FROM silver.olist.pedido
