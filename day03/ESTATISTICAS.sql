-- Databricks notebook source
SELECT 
  avg(vlPreco),
  min(vlPreco),
  percentile(vlPreco, 0.25),

  max(vlFrete),
  std(vlFrete),
  percentile(vlFrete, 0.5),
  avg(vlFrete)
FROM silver.olist.item_pedido
