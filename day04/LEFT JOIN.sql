-- Databricks notebook source
SELECT
  ip.idPedido,
  ip.idPedidoItem,
  ip.idPedidoItem,
  ip.vlPreco,
  ip.vlFrete,
  p.descCategoria

FROM silver.olist.item_pedido AS ip

LEFT JOIN silver.olist.produto AS p
ON p.idProduto = ip.idProduto

-- COMMAND ----------

SELECT
  ip.*,
  v.descUF

FROM silver.olist.item_pedido AS ip

LEFT JOIN silver.olist.vendedor AS v
ON ip.idVendedor = v.idVendedor

-- COMMAND ----------

SELECT
  ip.idPedido,
  v.descUF,
  p.descCategoria,
  p.vlPesoGramas

FROM silver.olist.item_pedido AS ip

LEFT JOIN silver.olist.vendedor AS v
ON ip.idVendedor = v.idVendedor

LEFT JOIN silver.olist.produto AS p
ON ip.idProduto = p.idProduto

WHERE v.descUF = 'SP'
