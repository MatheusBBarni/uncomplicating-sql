-- Databricks notebook source
-- MAGIC %md
-- MAGIC ![Alt text](https://lwfiles.mycourse.app/633c72fac8c963ec854a3950-public/7c0c27a4b5a7870a2b9a1527bdd3a951.png "Imagem das tabelas")
-- MAGIC
-- MAGIC 1. Qual pedido com maior valor de frete? E o menor?
-- MAGIC 2. Qual vendedor tem mais pedidos?
-- MAGIC 3. Qual vendedor tem mais itens vendidos? E o com menos?
-- MAGIC 4. Qual dia tivemos mais pedidos?
-- MAGIC 5. Quantos vendedores são do estado de São Paulo?
-- MAGIC 6. Quantos vendedores são de Presidente Prudente?
-- MAGIC 7. Quantos clientes são do estado do Rio de Janeiro?
-- MAGIC 8. Quantos produtos são de construção?
-- MAGIC 9. Qual o valor médio de um pedido? E do frete?
-- MAGIC 10. Em média os pedidos são de quantas parcelas de cartão? E o valor médio por parcela?
-- MAGIC 11. Quanto tempo em média demora para um pedido chegar depois de aprovado?
-- MAGIC 12. Qual estado tem mais vendedores?
-- MAGIC 13. Qual cidade tem mais clientes?
-- MAGIC 14. Qual categoria tem mais itens?
-- MAGIC 15. Qual categoria tem maior peso médio de produto?
-- MAGIC 16. Qual a série histórica de pedidos por dia?
-- MAGIC 17. Qual produto é o campeão de vendas? Em receita? Em quantidade?

-- COMMAND ----------

-- 1. Qual pedido com maior valor de frete? E o menor?

SELECT 
  idPedido,
  sum(vlFrete) AS totalFrete

FROM silver.olist.item_pedido

GROUP BY idPedido

ORDER BY totalFrete DESC

-- COMMAND ----------

-- 2. Qual vendedor tem mais pedidos?

SELECT
  idVendedor,
  count(DISTINCT idPedido) AS qtdPedido

FROM silver.olist.item_pedido

GROUP BY idVendedor

ORDER BY qtdPedido DESC

LIMIT 1

-- COMMAND ----------

-- 3. Qual vendedor tem mais itens vendidos? E o com menos?

SELECT
  idVendedor,
  count(idProduto) AS qtdItems

FROM silver.olist.item_pedido

GROUP BY idVendedor

ORDER BY qtdItems DESC

-- COMMAND ----------

-- 4. Qual dia tivemos mais pedidos?

SELECT 
  date(dtPedido) AS diaPedido,
  count(DISTINCT idPedido) AS qtdPedido

FROM silver.olist.pedido

GROUP BY diaPedido

ORDER BY qtdPedido DESC

-- COMMAND ----------

-- 5. Quantos vendedores são do estado de São Paulo?

SELECT
  descUF,
  count(DISTINCT idVendedor)

FROM silver.olist.vendedor

WHERE descUF = 'SP'

GROUP BY descUF

-- COMMAND ----------

-- 6. Quantos vendedores são de Presidente Prudente?

SELECT
  count(DISTINCT idVendedor) AS qtdVendedores

FROM silver.olist.vendedor

WHERE descCidade = 'presidente prudente'

-- COMMAND ----------

-- 7. Quantos clientes são do estado do Rio de Janeiro?

SELECT 
  count(DISTINCT idCliente) AS qtdClientes

FROM silver.olist.cliente

WHERE descUF = 'RJ'

-- COMMAND ----------

-- 8. Quantos produtos são de construção?

SELECT 
  count(DISTINCT idProduto)

FROM silver.olist.produto

WHERE descCategoria LIKE '%construcao%'

-- COMMAND ----------

-- 9. Qual o valor médio de um pedido? E do frete?

SELECT 
  sum(vlPreco) / count(DISTINCT idPedido) AS valorMedioPedido,
  sum(vlFrete) / count(DISTINCT idPedido) AS valorMedioFrete

FROM silver.olist.item_pedido


-- COMMAND ----------

-- 10. Em média os pedidos são de quantas parcelas de cartão? E o valor médio por parcela?

SELECT
  avg(nrParcelas) AS avgQtdParcelas,
  avg(vlPagamento / nrParcelas) AS avgvalorParcelas

FROM silver.olist.pagamento_pedido

WHERE descTipoPagamento = 'credit_card'

-- COMMAND ----------

-- 11. Quanto tempo em média demora para um pedido chegar depois de aprovado?

SELECT 
  avg(datediff(dtEntregue, dtAprovado)) AS avgQtdDias

FROM silver.olist.pedido

WHERE descSituacao = 'delivered'

-- COMMAND ----------

-- 12. Qual estado tem mais vendedores?

SELECT 
  descUF,
  count(DISTINCT idVendedor) AS qtdVendedores

FROM silver.olist.vendedor

GROUP BY descUF

ORDER BY qtdVendedores DESC

-- COMMAND ----------

-- 13. Qual cidade tem mais clientes?

SELECT 
  descCidade,
  count(DISTINCT idCliente) AS qtdClientes,
  count(DISTINCT idClienteUnico) AS qtdClienteUnico

FROM silver.olist.cliente

GROUP BY descCidade

ORDER BY qtdClientes DESC

-- COMMAND ----------

-- 14. Qual categoria tem mais itens?

SELECT
  descCategoria,
  count(DISTINCT idProduto) AS qtdProdutos

FROM silver.olist.produto

GROUP BY descCategoria

ORDER BY qtdProdutos DESC

-- COMMAND ----------

-- 15. Qual categoria tem maior peso médio de produto?

SELECT
  descCategoria,
  avg(vlPesoGramas) AS avgPeso

FROM silver.olist.produto

GROUP BY descCategoria

ORDER BY avgPeso DESC

-- COMMAND ----------

-- 16. Qual a série histórica de pedidos por dia?

SELECT
  date(dtPedido) AS diaPedido,
  count(DISTINCT idPedido) AS qtdPedido

FROM silver.olist.pedido

GROUP BY diaPedido

ORDER BY diaPedido

-- COMMAND ----------

-- 17. Qual produto é o campeão de vendas? Em receita? Em quantidade?

SELECT
  idProduto,
  count(*) AS qtdVenda,
  sum(vlPreco) as vlReceita

FROM silver.olist.item_pedido

GROUP BY idProduto

ORDER BY qtdVenda DESC
