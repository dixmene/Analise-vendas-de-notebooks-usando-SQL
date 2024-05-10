-- Databricks notebook source
-- MAGIC %md
-- MAGIC 1.Criação da View vw_notbook_vendidos

-- COMMAND ----------

ALTER VIEW vw_notbook_vendidos
AS
SELECT *,
    (latest_price * 0.063) AS real_latest_price,
    (old_price * 0.063) AS real_old_price,
(discount/100) as desconto
FROM notbook_vendidos;


-- COMMAND ----------

select * from vw_notbook_vendidos

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Nesta parte, eu criei uma view chamada vw_notbook_vendidos. Esta view é criada a partir da tabela notbook_vendidos. Três novas colunas são adicionadas à view: real_latest_price, que é o preço mais recente ajustado; real_old_price, que é o preço antigo ajustado para a moeda local (real); e desconto, que é o desconto aplicado ao produto.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC                     

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 2.Consulta para Análise de Marcas

-- COMMAND ----------

select 

case when marca= 'lenovo' then 'Lenovo' 
     else marca 
end as marca_ajust,
avg(real_latest_price)as real_latest_price
from vw_notbook_vendidos
group by 
case when marca= 'lenovo' then 'Lenovo' 
     else marca 
end
order by 2 desc

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Naquela consulta, estou agrupando os dados por marca (marca_ajust) e calculando a média dos preços mais recentes ajustados (real_latest_price). Utilizei a função CASE para ajustar a marca 'lenovo' para 'Lenovo'. Os resultados são ordenados pela média dos preços mais recentes ajustados em ordem decrescente.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC                 

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 3.Consulta para Análise de Tipos de Memória RAM e Média de Preços

-- COMMAND ----------

-- MAGIC %md
-- MAGIC            

-- COMMAND ----------

select 
case when ram_type ='LPDDR3'then 'DDR3'
     when ram_type in('LPDDR4','LPDDR4X')then 'DDR4'
else ram_type end as tipo_memoria_ajust,
avg(real_latest_price)as real_latest_price
from vw_notbook_vendidos
group by case when ram_type ='LPDDR3'then 'DDR3'
     when ram_type in('LPDDR4','LPDDR4X')then 'DDR4'
else ram_type end
order by 2 desc

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Nesta consulta, estou agrupando os dados por tipo de memória RAM (tipo_memoria_ajust) e calculando a média dos preços mais recentes ajustados (real_latest_price). Utilizei a função CASE para ajustar os tipos de memória RAM 'LPDDR3' para 'DDR3' e 'LPDDR4' ou 'LPDDR4X' para 'DDR4'. Os resultados são ordenados pela média dos preços mais recentes ajustados em ordem decrescente.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC       

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 4.Consulta para Análise de Tipos de Memória RAM e Soma de Preços 

-- COMMAND ----------

select 
case when ram_type ='LPDDR3'then 'DDR3'
     when ram_type in('LPDDR4','LPDDR4X')then 'DDR4'
else ram_type end as tipo_memoria_ajust,
sum(real_latest_price)as real_latest_price
from vw_notbook_vendidos
group by case when ram_type ='LPDDR3'then 'DDR3'
     when ram_type in('LPDDR4','LPDDR4X')then 'DDR4'
else ram_type end
order by 2 desc

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Nesta consulta, estou agrupando os dados por tipo de memória RAM (tipo_memoria_ajust) e calculando a soma dos preços mais recentes ajustados (real_latest_price). Utilizei a função CASE para ajustar os tipos de memória RAM 'LPDDR3' para 'DDR3' e 'LPDDR4' ou 'LPDDR4X' para 'DDR4'. Os resultados são ordenados pela soma dos preços mais recentes ajustados em ordem decrescente.
-- MAGIC
-- MAGIC Em resumo, criei uma view para agregar e ajustar os dados da tabela original. Em seguida, realizei análises sobre esses dados, calculando médias e somas agrupadas por marcas e tipos de memória RAM. As consultas resultantes fornecem informações úteis para entender melhor as vendas de notebooks em relação a diferentes marcas e tipos de hardware.
