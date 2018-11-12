select tmp2.codigo, tmp2.subtotal, tmp2.acumulado, 
round(((tmp2.acumulado*100)/MAX(tmp2.acumulado) 
  over
(order by tmp2.acumulado desc rows between 
  unbounded preceding and current row)),2) || ' %'
as "acumulado%",
(case
when ((tmp2.acumulado*100)/max(tmp2.acumulado) 
  over
(order by tmp2.acumulado desc rows between
unbounded preceding and current row)) <= 65 then 'A'
when ((tmp2.acumulado*100)/max(tmp2.acumulado) 
  over
(order by tmp2.acumulado desc rows between
unbounded preceding and current row)) <= 90 then 'B'
when ((tmp2.acumulado*100)/max(tmp2.acumulado) 
  over
(order by tmp2.acumulado desc rows between
unbounded preceding and current row)) <= 100 then 'C'
end) as categoria
from
(select tmp1.codigo, 
  round((tmp1.subtotal)::numeric, 2) as subtotal, 
  round(sum(tmp1.subtotal) 
  over
(order by 1 desc rows between 
unbounded preceding and current row)::numeric,2) as acumulado
from
(select produto.codigo, 
  sum(produto.preco*item.quantidade) as subtotal
  from produto
  join item on item.produto = produto.codigo
  join venda on venda.codigo = item.venda
  group by produto.codigo 
  order by subtotal desc) as tmp1
join produto on produto.codigo=tmp1.codigo
group by tmp1.codigo, tmp1.subtotal 
order by tmp1.subtotal desc) as tmp2
group by 1, 2, 3 
order by 2 desc;



-- usando view

drop view curvaABC2;

create view curvaABC2 as
select tmp2.codigo, tmp2.subtotal, tmp2.acumulado, 
round(((tmp2.acumulado*100)/MAX(tmp2.acumulado) 
  over
(order by tmp2.acumulado desc rows between 
  unbounded preceding and current row)),2) || ' %'
as "acumulado%",
(case
when ((tmp2.acumulado*100)/max(tmp2.acumulado) 
  over
(order by tmp2.acumulado desc rows between
unbounded preceding and current row)) <= 65 then 'A'
when ((tmp2.acumulado*100)/max(tmp2.acumulado) 
  over
(order by tmp2.acumulado desc rows between
unbounded preceding and current row)) <= 90 then 'B'
when ((tmp2.acumulado*100)/max(tmp2.acumulado) 
  over
(order by tmp2.acumulado desc rows between
unbounded preceding and current row)) <= 100 then 'C'
end) as categoria
from
(select tmp1.codigo, 
  round((tmp1.subtotal)::numeric, 2) as subtotal, 
  round(sum(tmp1.subtotal) 
  over
(order by 1 desc rows between 
unbounded preceding and current row)::numeric,2) as acumulado
from
(select produto.codigo, 
  sum(produto.preco*item.quantidade) as subtotal
  from produto
  join item on item.produto = produto.codigo
  join venda on venda.codigo = item.venda
  group by produto.codigo 
  order by subtotal desc) as tmp1
join produto on produto.codigo=tmp1.codigo
group by tmp1.codigo, tmp1.subtotal 
order by tmp1.subtotal desc) as tmp2
group by 1, 2, 3 
order by 2 desc;