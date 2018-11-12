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