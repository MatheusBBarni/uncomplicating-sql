-- Databricks notebook source
SELECT 
  descCategoria,
  count(DISTINCT idProduto) AS qtdProduto,

  avg(vlPesoGramas) AS avgPeso

FROM silver.olist.produto

WHERE descCategoria IN ('bebes', 'perfumaria')
OR descCategoria LIKE '%moveis%'

GROUP BY descCategoria

HAVING qtdProduto > 100
AND avgPeso > 1000

ORDER BY avgPeso DESC
