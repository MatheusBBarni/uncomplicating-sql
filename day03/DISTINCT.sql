-- Databricks notebook source
SELECT DISTINCT descUf 
FROM silver.olist.vendedor
ORDER BY descUf

-- COMMAND ----------

SELECT DISTINCT descCidade, descUf 
FROM silver.olist.vendedor
ORDER BY descUf, descCidade

-- COMMAND ----------

SELECT DISTINCT * 
FROM silver.olist.vendedor
