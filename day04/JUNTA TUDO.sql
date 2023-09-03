-- Databricks notebook source
-- Quais são os vendedores de cada estado que tem +R$1000,00 em vendas durante o ano de 2017

SELECT
  ip.idVendedor,
  v.descUF,
  sum(ip.vlPreco) AS totalVendido

FROM silver.olist.pedido AS p

INNER JOIN silver.olist.item_pedido AS ip
ON ip.idPedido = p.idPedido

LEFT JOIN silver.olist.vendedor AS v
ON v.idVendedor = ip.idVendedor

WHERE year(p.dtPedido) = 2017

GROUP BY ip.idVendedor, v.descUF

HAVING totalVendido >= 1000

ORDER BY v.descUF, totalVendido DESC
