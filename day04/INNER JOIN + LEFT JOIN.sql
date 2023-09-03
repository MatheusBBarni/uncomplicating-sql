-- Databricks notebook source
SELECT
  *

FROM silver.olist.pedido AS p

INNER JOIN silver.olist.item_pedido AS ip
ON p.idPedido = ip.idPedido

LEFT JOIN silver.olist.vendedor AS v
ON ip.idVendedor = v.idVendedor

LEFT JOIN silver.olist.cliente AS c
ON p.idCliente = c.idCliente
