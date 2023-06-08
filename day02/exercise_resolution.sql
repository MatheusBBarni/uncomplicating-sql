-- Databricks notebook source
-- DBTITLE 1,1
SELECT *

FROM silver.olist.cliente

WHERE descCidade = 'sao paulo'

-- COMMAND ----------

-- DBTITLE 1,2
SELECT *

FROM silver.olist.cliente

WHERE descUF = 'SP'

-- COMMAND ----------

-- DBTITLE 1,3
SELECT *

FROM silver.olist.vendedor

WHERE descUF = 'SP'
OR descCidade = 'rio de janeiro'

-- COMMAND ----------

-- DBTITLE 1,4
SELECT *

FROM silver.olist.produto

WHERE
  descCategoria IN ('perfumaria', 'bebes')
  AND vlAlturaCm > 5

-- COMMAND ----------

-- DBTITLE 1,5
SELECT *

FROM silver.olist.item_pedido

WHERE idPedidoItem >= 2

-- COMMAND ----------

-- DBTITLE 1,6
SELECT *

FROM silver.olist.item_pedido

WHERE
  vlFrete > vlPreco

-- COMMAND ----------

-- DBTITLE 1,7
SELECT *

FROM silver.olist.pedido

WHERE
  dtEnvio IS NULL

-- COMMAND ----------

-- DBTITLE 1,8
SELECT *

FROM silver.olist.pedido

WHERE
  date(dtEntregue) > date(dtEstimativaEntrega)

-- COMMAND ----------

-- DBTITLE 1,9
SELECT *

FROM silver.olist.pedido

WHERE
  datediff(date(dtEstimativaEntrega), date(dtEntregue)) = 2

-- COMMAND ----------

-- DBTITLE 1,10
SELECT *

FROM silver.olist.pedido

WHERE
  year(dtPedido) = 2017
  AND month(dtPedido) = 12
  AND date(dtEntregue) > date(dtEstimativaEntrega)

-- COMMAND ----------

-- DBTITLE 1,11
SELECT *

FROM silver.olist.avaliacao_pedido

WHERE
  vlNota >= 4

-- COMMAND ----------

-- DBTITLE 1,12
SELECT *

FROM silver.olist.pagamento_pedido

WHERE
  descTipoPagamento = 'credit_card'
  AND nrParcelas >= 2
  AND vlPagamento / nrParcelas < 40
