-- Databricks notebook source
-- QUERY SP
(SELECT
  ip.idVendedor,
  v.descUF,
  count(p.idPedido) AS totalPedidos

FROM silver.olist.pedido AS p

INNER JOIN silver.olist.item_pedido AS ip
ON p.idPedido = ip.idPedido

LEFT JOIN silver.olist.vendedor AS v
ON v.idVendedor = ip.idVendedor

WHERE year(p.dtPedido) = 2017
AND v.descUF = 'SP'

GROUP BY ip.idVendedor, v.descUF

ORDER BY totalPedidos DESC

LIMIT 5)

UNION 

-- QUERY RJ
(SELECT
  ip.idVendedor,
  v.descUF,
  count(p.idPedido) AS totalPedidos

FROM silver.olist.pedido AS p

INNER JOIN silver.olist.item_pedido AS ip
ON p.idPedido = ip.idPedido

LEFT JOIN silver.olist.vendedor AS v
ON v.idVendedor = ip.idVendedor

WHERE year(p.dtPedido) = 2017
AND v.descUF = 'RJ'

GROUP BY ip.idVendedor, v.descUF

ORDER BY totalPedidos DESC

LIMIT 5)
