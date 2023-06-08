-- Databricks notebook source
SELECT *,
       CASE 
         WHEN vlPreco <= 100 THEN '0 -> 100'
         WHEN vlPreco <= 200 THEN '100 -> 200'
         ELSE '+200'
       END AS fxPreco

FROM silver.olist.item_pedido

-- COMMAND ----------

SELECT *,
       CASE 
         WHEN vlFrete / (vlPreco + vlFrete) = 0 THEN 'Frete Gratuito'
         WHEN vlFrete / (vlPreco + vlFrete) <= 0.2 THEN 'Frete Baixo'
         WHEN vlFrete / (vlPreco + vlFrete) <= 0.4 THEN 'Frete Medio'
         ELSE 'Frete Alto'
       END AS descFrete

FROM silver.olist.item_pedido

-- COMMAND ----------

SELECT *,
       CASE
         WHEN descUF IN ('SC', 'PR', 'RS') THEN 'Sul'
         WHEN descUF IN ('SP', 'RJ', 'MG', 'ES') THEN 'Sudeste'
         WHEN descUF IN ('MS', 'MT', 'GO', 'DF') THEN 'Centro-Oeste'
         WHEN descUF IN ('AC', 'RO', 'AM', 'RR', 'PA', 'AP', 'TO') THEN 'Norte'
         ELSE 'Nordeste'
       END AS descRegiao

FROM silver.olist.cliente
