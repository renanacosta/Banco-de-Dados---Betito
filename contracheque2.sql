create view salario_bruto as select vendedor.cpf, vendedor.dependentes, vendedor.salario,round(
sum(produto.preco*item.quantidade*(produto.comissao/100)):: numeric, 2) as comissao,
vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100)):: numeric, 2) as bruto
from vendedor, produto, item, venda
where vendedor.cpf = venda.vendedor and
venda.codigo = item.venda and
item.produto = produto.codigo and
venda.dia between '2000-02-01' and '2000-02-29'
group by 1;


select * from salario_bruto;





-------------------------------------------------

DROP VIEW contracheque;

create view contracheque as select vendedor.cpf, vendedor.dependentes, vendedor.salario,round(
sum(produto.preco*item.quantidade*(produto.comissao/100)):: numeric, 2) as comissao,
vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100)):: numeric, 2) as bruto,
case 
when (vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100)))) < 1693.72 then
  (vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100))))*8/100
when (vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100)))) <= 2822.90 then
  (vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100))))*9/100
when (vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100)))) <= 5645.80 then
  (vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100))))*11/100
when (vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100)))) > 5645.80	then
  (vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100))))*11/100
end as inss, 
vendedor.salario - vendedor.dependentes*189.59 + 
round(sum(produto.preco*item.quantidade*(produto.comissao/100)-produto.preco*item.quantidade*(produto.comissao/100))) -
case
when (vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100)))) < 1693.72 then
  (vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100))))*8/100
when (vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100)))) <= 2822.90 then
  (vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100))))*9/100
when (vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100)))) <= 5645.80 then
  (vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100))))*11/100
when (vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100)))) > 5645.80	then
  (vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100))))*11/100
end as liquido,
case 
when (vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100)))) < 1903.98 then
  ((vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100))))*(0/100)-(0))
when (vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100)))) <= 2826.65 then
  ((vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100))))*(7.5/100)-(142.80))
when (vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100)))) <= 3751.05 then
  ((vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100))))*(15/100)-(354.80))
when (vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100)))) <= 4664.68	then
  ((vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100))))*(22.5/100)-(636.13))
when (vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100)))) < 4664.68  then
  ((vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100))))*(27.5/100)-(869.36))
end as irrf
from vendedor, produto, item, venda
where vendedor.cpf = venda.vendedor and
venda.codigo = item.venda and
item.produto = produto.codigo and
venda.dia between '2000-02-01' and '2000-02-29'
group by 1;



------------------------------------------------------------------------------------


-- solução Edson

select vendedor.cpf, vendedor.dependentes, vendedor.salario,round(
sum(produto.preco*item.quantidade*(produto.comissao/100)):: numeric, 2) as comissao,
vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100)):: numeric, 2) as bruto,
case
when (vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100)))) < 1693.72 then
  (vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100))))*8/100
when (vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100)))) <= 2822.90 then
  (vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100))))*9/100
when (vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100)))) <= 5645.80 then
  (vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100))))*11/100
when (vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100)))) > 5645.80	then
  (vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100))))*11/100
end as inss, 
case 
when (vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100)))) < 1903.98 then
  ((vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100))))*(0/100)-(0))
when (vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100)))) <= 2826.65 then
  ((vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100))))*(7.5/100)-(142.80))
when (vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100)))) <= 3751.05 then
  ((vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100))))*(15/100)-(354.80))
when (vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100)))) <= 4664.68	then
  ((vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100))))*(22.5/100)-(636.13))
when (vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100)))) < 4664.68  then
  ((vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100))))*(27.5/100)-(869.36))
end as irrf, 
vendedor.salario - vendedor.dependentes*189.59 +
round(sum(produto.preco*item.quantidade*(produto.comissao/100)-produto.preco*item.quantidade*(produto.comissao/100))) -
case 
when (vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100)))) < 1693.72 then
  (vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100))))*8/100
when (vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100)))) <= 2822.90 then
  (vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100))))*9/100
when (vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100)))) <= 5645.80 then
  (vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100))))*11/100
when (vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100)))) > 5645.80	then
  (vendedor.salario + round(sum(produto.preco*item.quantidade*(produto.comissao/100))))*11/100
end as liquido 
from vendedor, produto, item, venda
where vendedor.cpf = venda.vendedor and
venda.codigo = item.venda and
item.produto = produto.codigo and
venda.dia between '2000-02-01' and '2000-02-29'
group by 1;




-----------------------------------------------------------------------------------------------------------------------

-- CODIGO SALVADOR

select tmp1.cpf, tmp1.dependentes, tmp1.salario, tmp1.comissao, tmp1.bruto,
case
when tmp1.bruto <= 1693.72 then (tmp1.bruto*8/100)::decimal(10,2)
when tmp1.bruto <= 2822.90 then (tmp1.bruto*9/100)::decimal(10,2)
when tmp1.bruto <= 5645.80 then (tmp1.bruto*11/100)::decimal(10,2)
when tmp1.bruto <= 5645.80 then (5645.80*11/100)::decimal(10,2) end as inss
from
(select vendedor.cpf, vendedor.dependentes, vendedor.salario,
sum(item.quantidade*produto.preco*produto.comissao/100)::decimal(10,2) as comissao,
(sum(item.quantidade*produto.preco*produto.comissao/100) + vendedor.salario)::decimal(10,2) as bruto
from item
join produto on produto.codigo = item.produto
join venda on item.venda = venda.codigo
join vendedor on vendedor.cpf = venda.vendedor
where venda.dia between '2000-02-01' and '2000-02-29'
group by 1,2,3 order by 1) as tmp1
group by 1,2,3,4,5 order by 1;



---------------------------- passo 2

select *,(tmp2.bruto - tmp2.inss - (tmp2.dependentes*189.59)) as base
from
(select tmp1.cpf, tmp1.dependentes, tmp1.salario, tmp1.comissao, tmp1.bruto,
case
when tmp1.bruto <= 1693.72 then (tmp1.bruto*8/100)::decimal(10,2)
when tmp1.bruto <= 2822.90 then (tmp1.bruto*9/100)::decimal(10,2)
when tmp1.bruto <= 5645.80 then (tmp1.bruto*11/100)::decimal(10,2)
when tmp1.bruto <= 5645.80 then (5645.80*11/100)::decimal(10,2) end as inss
from
(select vendedor.cpf, vendedor.dependentes, vendedor.salario,
sum(item.quantidade*produto.preco*produto.comissao/100)::decimal(10,2) as comissao,
(sum(item.quantidade*produto.preco*produto.comissao/100) + vendedor.salario)::decimal(10,2) as bruto
from item
join produto on produto.codigo = item.produto
join venda on item.venda = venda.codigo
join vendedor on vendedor.cpf = venda.vendedor
where venda.dia between '2000-02-01' and '2000-02-29'
group by 1,2,3 order by 1) as tmp1) as tmp2;



------------------------- passo 3
select tmp4.cpf, tmp4.dependentes, tmp4.salario, tmp4.comissao, tmp4.bruto, tmp4.inss, tmp4.irrf,
(tmp4.bruto - tmp4.inss - tmp4.irrf) as liquido
from
(select *, 
(case
when tmp3.base <= 1903.98 then (tmp3.base*0)::decimal(10,2)
when tmp3.base <= 2826.65 then ((tmp3.base*0.075)-142.80)::decimal(10,2)
when tmp3.base <= 3751.05 then ((tmp3.base*0.15)-354.80)::decimal(10,2)
when tmp3.base <= 4664.68 then ((tmp3.base*0.225)-636.13)::decimal(10,2)
when tmp3.base > 4664.68 then ((tmp3.base*0.275)-869.36)::decimal(10,2) end) as irrf
from
(select *,(tmp2.bruto - tmp2.inss - (tmp2.dependentes*189.59)) as base
from
(select tmp1.cpf, tmp1.dependentes, tmp1.salario, tmp1.comissao, tmp1.bruto,
case
when tmp1.bruto <= 1693.72 then (tmp1.bruto*8/100)::decimal(10,2)
when tmp1.bruto <= 2822.90 then (tmp1.bruto*9/100)::decimal(10,2)
when tmp1.bruto <= 5645.80 then (tmp1.bruto*11/100)::decimal(10,2)
when tmp1.bruto <= 5645.80 then (5645.80*11/100)::decimal(10,2) end as inss
from
(select vendedor.cpf, vendedor.dependentes, vendedor.salario,
sum(item.quantidade*produto.preco*produto.comissao/100)::decimal(10,2) as comissao,
(sum(item.quantidade*produto.preco*produto.comissao/100) + vendedor.salario)::decimal(10,2) as bruto
from item
join produto on produto.codigo = item.produto
join venda on item.venda = venda.codigo
join vendedor on vendedor.cpf = venda.vendedor
where venda.dia between '2000-02-01' and '2000-02-29'
group by 1,2,3 order by 1) as tmp1) as tmp2) as tmp3) as tmp4;



-------------------------------------------- minha GAMBIARRA

drop view contracheque2;

create view contracheque2 as
select tmp4.cpf, tmp4.dependentes, tmp4.salario, tmp4.comissao, tmp4.bruto, tmp4.inss, tmp4.irrf,
(tmp4.bruto - tmp4.inss - tmp4.irrf) as liquido
from
(select *, 
round(case
when tmp3.base < 1903.98 then (tmp3.base*0/100)
when tmp3.base <= 2826.65 then ((tmp3.base*7.5/100))
when tmp3.base <= 3751.05 then ((tmp3.base*1.5/100))
when tmp3.base <= 4664.68 then ((tmp3.base*22.5/100))
when tmp3.base < 4664.68 then ((tmp3.base*27.5/100)) end) as irrf
from
(select *, round(tmp2.bruto - tmp2.inss - (tmp2.dependentes*189.59)) as base
from
(select tmp1.cpf, tmp1.dependentes, tmp1.salario, tmp1.comissao, tmp1.bruto,
case
when tmp1.bruto < 1693.72 then (tmp1.bruto*8/100)
when tmp1.bruto <= 2822.90 then (tmp1.bruto*9/100)
when tmp1.bruto <= 5645.80 then (tmp1.bruto*11/100)
when tmp1.bruto > 5645.80 then (5645.80*11/100) end as inss
from
(select vendedor.cpf, vendedor.dependentes, vendedor.salario,
round(sum(item.quantidade*produto.preco*produto.comissao/100)) as comissao,
round(sum(item.quantidade*produto.preco*produto.comissao/100) + vendedor.salario) as bruto
from item
join produto on produto.codigo = item.produto
join venda on item.venda = venda.codigo
join vendedor on vendedor.cpf = venda.vendedor
where venda.dia between '2000-02-01' and '2000-02-29'
group by 1) as tmp1) as tmp2) as tmp3) as tmp4;











