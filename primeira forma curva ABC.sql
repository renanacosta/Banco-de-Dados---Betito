-- testes

--questao 1 trabalho 
select tmp3.codigo, tmp3.subtotal, tmp3.acumulado, 
round(tmp3.acumulado*100/max(tmp4.acumulado)::numeric,2) || ' %' as "acumulado %",
(case 
when
 (round(tmp3.acumulado*100/max(tmp4.acumulado)::numeric,2)) <=65 then 'A'
 when
 (round(tmp3.acumulado*100/max(tmp4.acumulado)::numeric,2)) <=90 then 'B'
 when
 (round(tmp3.acumulado*100/max(tmp4.acumulado)::numeric,2)) <=100 then 'C'  
end) as categoria
from
  (select tmp1.codigo, round(tmp1.subtotal::numeric, 2) as subtotal,
    round(sum(tmp2.subtotal)::numeric, 2) as acumulado from

      (select produto.codigo as codigo, sum(produto.preco*item.quantidade) as subtotal from produto
        join item on item.produto = produto.codigo
        join venda on item.venda = venda.codigo
          group by produto.codigo
          order by subtotal desc) as tmp1,

      (select produto.codigo as codigo, sum(produto.preco*item.quantidade) as subtotal from produto
        join item on item.produto = produto.codigo
        join venda on item.venda = venda.codigo
          group by produto.codigo order by subtotal desc) as tmp2

    where tmp1.subtotal between tmp1.subtotal and tmp2.subtotal
    group by 1, 2
    order by 2 desc) as tmp3,
    (select tmp1.codigo, round(tmp1.subtotal::numeric, 2) as subtotal,
      round(sum(tmp2.subtotal)::numeric, 2) as acumulado from

        (select produto.codigo as codigo, sum(produto.preco*item.quantidade) as subtotal from produto
          join item on item.produto = produto.codigo
          join venda on item.venda = venda.codigo
            group by produto.codigo
            order by subtotal desc) as tmp1,

        (select produto.codigo as codigo, sum(produto.preco*item.quantidade) as subtotal from produto
          join item on item.produto = produto.codigo
          join venda on item.venda = venda.codigo
            group by produto.codigo order by subtotal desc) as tmp2

      where tmp1.subtotal between tmp1.subtotal and tmp2.subtotal
      group by 1, 2
      order by 2 desc) as tmp4
      where tmp3.acumulado between tmp3.acumulado and tmp4.acumulado
      group by 1, 2, 3
      order by 2 desc;




--------------------------------------------------------------------------------------------------------------


-- usando view

drop view curvaABC;

create view curvaABC as 
select tmp3.codigo, tmp3.subtotal, tmp3.acumulado, 
round(tmp3.acumulado*100/max(tmp4.acumulado)::numeric,2) || ' %' as "acumulado %",
(case 
when
 (round(tmp3.acumulado*100/max(tmp4.acumulado)::numeric,2)) <=65 then 'A'
 when
 (round(tmp3.acumulado*100/max(tmp4.acumulado)::numeric,2)) <=90 then 'B'
 when
 (round(tmp3.acumulado*100/max(tmp4.acumulado)::numeric,2)) <=100 then 'C'  
end) as categoria
from
  (select tmp1.codigo, round(tmp1.subtotal::numeric, 2) as subtotal,
    round(sum(tmp2.subtotal)::numeric, 2) as acumulado from

      (select produto.codigo as codigo, sum(produto.preco*item.quantidade) as subtotal from produto
        join item on item.produto = produto.codigo
        join venda on item.venda = venda.codigo
          group by produto.codigo
          order by subtotal desc) as tmp1,

      (select produto.codigo as codigo, sum(produto.preco*item.quantidade) as subtotal from produto
        join item on item.produto = produto.codigo
        join venda on item.venda = venda.codigo
          group by produto.codigo order by subtotal desc) as tmp2

    where tmp1.subtotal between tmp1.subtotal and tmp2.subtotal
    group by 1, 2
    order by 2 desc) as tmp3,
    (select tmp1.codigo, round(tmp1.subtotal::numeric, 2) as subtotal,
      round(sum(tmp2.subtotal)::numeric, 2) as acumulado from

        (select produto.codigo as codigo, sum(produto.preco*item.quantidade) as subtotal from produto
          join item on item.produto = produto.codigo
          join venda on item.venda = venda.codigo
            group by produto.codigo
            order by subtotal desc) as tmp1,

        (select produto.codigo as codigo, sum(produto.preco*item.quantidade) as subtotal from produto
          join item on item.produto = produto.codigo
          join venda on item.venda = venda.codigo
            group by produto.codigo order by subtotal desc) as tmp2

      where tmp1.subtotal between tmp1.subtotal and tmp2.subtotal
      group by 1, 2
      order by 2 desc) as tmp4
      where tmp3.acumulado between tmp3.acumulado and tmp4.acumulado
      group by 1, 2, 3
      order by 2 desc;



