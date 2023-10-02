-- Criação da Database Projeto
create database projeto;

-- Utilização da Database Projeto 
use projeto;

-- Criação das tabelas
create table funcionarios 
(
		cod_func int not null auto_increment,
        nome_func varchar(100) not null,
        end_func varchar(200) not null,
        sal_func decimal(10, 2) not null default 0,
        sexo_func char(1) not null default 'f',
        
        constraint pk_func primary key(cod_func),
        constraint ch_func_1 check(sal_func >= 0),
        constraint ch_func_2 check(sexo_func in ('f', 'm'))
);

create table dependentes
(
		cod_dep int not null auto_increment,
        cod_func int not null,
        nome_dep varchar(100) not null,
        sexo_dep char(1) not null default 'm',
        
        constraint pk_dep primary key(cod_dep),
        constraint fk_dep foreign key(cod_func) references funcionarios(cod_func),
        constraint ch_dep check(sexo_dep in ('f', 'm'))
);

create table estados
(
		sigla_est char(2) not null,
        nome_est varchar(100) not null,
        
        constraint pk_est primary key(sigla_est),
        constraint un_est unique(nome_est)
);

create table cidades
(
		cod_cid int not null auto_increment,
        sigla_est char(2) not null,
        nome_cid varchar(100) not null,
        
        constraint pk_cid primary key(cod_cid),
        constraint fk_cid foreign key(sigla_est) references estados(sigla_est)
);

create table clientes
(
		cod_cli int not null auto_increment,
        cod_cid int not null,
        nome_cli varchar(100) not null,
        end_cli varchar(100) not null,
        renda_cli decimal(10, 2) not null default 0,
        sexo_cli char(1) not null default 'f',
        
        constraint pk_cli primary key(cod_cli),
        constraint fk_cli foreign key(cod_cid) references cidades(cod_cid),
        constraint ch_cli_1 check(renda_cli >=0),
        constraint ch_cli_2 check(sexo_cli in ('f', 'm'))
);

create table conjuges
(
		cod_cli	int	not null ,
		nome_conj varchar(100)not null,
		renda_conj decimal(10, 2) not null default 0,
		sexo_conj char(1) not null default 'm',

		constraint pk_conj primary key(cod_cli),
		constraint fk_conj foreign key(cod_cli) references clientes(cod_cli),
		constraint ch_conj_1 check (renda_conj >= 0),
		constraint ch_conj_2 check(sexo_conj in ('f', 'm'))
);

create table artistas 
(
		cod_art	int	not null auto_increment,
		nome_art varchar(100) not null,

		constraint pk_art primary key (cod_art),
		constraint uq_art unique(nome_art)
);

create table gravadoras 
(
		cod_grav int not null auto_increment,
		nome_grav varchar(50) not null,

		constraint pk_grav primary key(cod_grav),
		constraint uq_grav unique(nome_grav)
);

create table categorias
(
		cod_cat	 int not null auto_increment,
		nome_cat varchar(50)	not null,

		constraint pk_cat primary key(cod_cat),
		constraint uq_cat unique(nome_cat)
) ;

create table titulos
(
		cod_tit int auto_increment,
		cod_cat int not null,
		cod_grav int not null,
		nome_cd varchar(100) not null,
		val_compra decimal(10, 2) not null,
		val_cd decimal(10, 2) not null,
		qtd_estq int not null,

		constraint pk_tit primary key(cod_tit),
		constraint uq_tit unique(nome_cd),
		constraint fk_tit_1 foreign key(cod_cat) references categorias(cod_cat),
		constraint fk_tit_2 foreign key(cod_grav) references gravadoras(cod_grav),
		constraint ch_tit_1 check(val_cd >= 0),
		constraint ch_tit_2 check(qtd_estq >= 0)
);

create table titulos_artistas
(
		cod_tit int not null auto_increment,
		cod_art int not null,

		constraint pk_titart primary key(cod_tit,cod_art),
		constraint fk_titart_1 foreign key(cod_tit) references titulos(cod_tit),
		constraint fk2_titart_2 foreign key(cod_art) references artistas(cod_art)
);

create table pedidos
(
		num_ped int not null auto_increment,
		cod_cli  int not null,
		cod_func int not null,
		data_ped datetime not null,

		constraint pk_ped primary key(num_ped),
		constraint fk_ped_1 foreign key(cod_cli) references clientes(cod_cli),
		constraint fk_ped_2 foreign key(cod_func) references funcionarios(cod_func)
);

create table titulos_pedidos
(
		num_ped int not null,
        cod_tit int not null,
        qtd_cd int not null,
        val_cd int not null,
        
        constraint pk_titped primary key(num_ped, cod_tit),
        constraint fk_titped_3 foreign key(num_ped) references pedidos(num_ped),
        constraint fk_titped_4 foreign key(cod_tit) references titulos(cod_tit),
        constraint ch_titped_1 check(qtd_cd >= 0),
        constraint ch_titped_2 check(val_cd >= 0)
);

-- Inserção dos dados nas tabelas
insert funcionarios values
		(null,'Gabriel Butti de Souza', 'Rua a', 2500.00, 'm'),
        (null,'Giovana Santos Fontana', 'Rua b', 3000.00, 'f'),
        (null,'Fabio Dias de Souza', 'Rua c', 2800.00, 'm'),
        (null,'Gislaine Cristina Butti', 'Rua d', 3500.00, 'f'),
        (null,'Merli Toddy Mel Cotinho', 'Rua e', 5000.00, 'm');

insert dependentes values
		(null, 1, 'Theodore Butti Fontana', 'm'),
        (null, 2, 'Caitlyn Butti Fontana', 'f'),
        (null, 1, 'Thomas Butti Fontana', 'm'),
        (null, 3, 'Maria Silva', 'f'),
        (null, 3, 'José Roberto', 'm'),
        (null, 4, 'Arthur Bento', 'm');
        
insert estados values
		('SP', 'São Paulo'),
        ('RJ', 'Rio de Janeiro'),
        ('MG', 'Minas Gerais');
        
insert cidades values
		(null, 'SP', 'São Paulo'),
        (null, 'SP', 'Campinas'),
        (null, 'SP', 'Santos'),
        (null, 'SP', 'Sorocaba'),
        (null, 'SP', 'Jaú'),
        (null, 'MG', 'Belo Horizonte'),
        (null, 'RJ', 'Rio de Janeiro');

insert clientes values
		(null, 1, 'José Nogueira', 'Rua a', 1500.00, 'm'),
        (null, 1, 'Angelo Pereira', 'Rua b', 2000.00, 'm'),
        (null, 1, 'Regina Duarte', 'Rua c', 1800.00, 'f'),
        (null, 1, 'Catarina Souza', 'Rua d', 890.00, 'f'),
        (null, 1, 'Vagner Costa', 'Rua e', 950.00, 'm'),
        (null, 2, 'Antenor da Costa', 'Rua f', 1580.00, 'm'),
        (null, 2, 'Maria Amélia', 'Rua g', 1100.00, 'f'),
        (null, 2, 'Paulo Roberto', 'Rua h', 3200.00, 'm'),
        (null, 3, 'Fatima de Souza', 'Rua i', 1600.00, 'f'),
        (null, 3, 'Joel da Rocha', 'Rua j', 2000.00, 'm');
        
insert conjuges values
		(1,	'Carla Nogueira', 2500.00,	'f'),
		(2,	'Emilia Pereira', 5500.00,	'f'),
		(6,	'Aline da Costa', 3000.00, 'f'),
		(7,	'Carlos de Souza', 3200.00,	'm');
	
insert artistas values
		(null, 'Marisa Monte'),
		(null, 'Baby do Brasil'),
		(null, 'Moraes Moreira'),
		(null, 'Pepeu Gomes'),
		(null, 'Paulinho Boca de Cantor'),
		(null, 'Luiz Galvão'),
		(null, 'Alceu Vaença'),
		(null, 'Geraldo Azevedo'),
		(null, 'Elba Ramalho'),
		(null, 'Carlinhos Brown'),
		(null, 'Arnaldo Antunes'),
		(null, 'Adriana Calcanhoto'),
		(null, 'Aline Barros'),
		(null, 'Gal Costa'),
		(null, 'Chico Buarque'),
		(null, 'Rita lee'),
		(null, 'Skank'),
		(null, 'Lulu Santos'),
		(null, 'Anitta');
	
insert gravadoras values
		(null,'Phonomotor'),
		(null, 'Biscoito Fino'),
		(null, 'Som Livre'),
		(null, 'Sony Music'),
		(null, 'Universal'),
		(null, 'Emi');
	
insert categorias values
		(null, 'MPB'),
		(null, 'Trilha Sonora'),
		(null, 'Gospel'),
		(null, 'Rock Nacional');
        
insert titulos values
		(null, 1, 1, 'Tribalistas', 130.00, 150.00, 1500),
		(null, 1, 3, 'Acabou Chorare Novos Baianos se Encontram', 50.00, 200.00, 500),
		(null, 1, 4, 'O Grande Encontro', 60.00, 120.00, 1000),
		(null, 1, 2, 'Estratosferica', 50.00, 70.00, 2000),
		(null, 1, 2, 'A Caravana', 55.00, 98.00, 500),
		(null, 1, 4, 'Loucura', 230.00, 300.00, 200),
		(null, 3, 4, 'Graça Extraordinária', 200.00, 250.00, 100),
		(null, 4, 2, 'Reza', 30.00, 130.00, 300),
		(null, 1, 5, 'Recanto', 40.00, 90.00, 500),
		(null, 1, 6, 'O Que Você Quer Saber de Verdade', 130.00, 180.00, 500);
        
insert titulos_artistas values
		(1, 1),
		(1, 10),
		(1, 11),
		(2, 2),
		(2, 3),
		(2, 4),
		(2, 5),
		(2, 6),
		(3, 7),
		(3, 8),
		(3, 9),
		(4, 14),
		(5, 15),
		(6, 12),
		(7, 13),
		(8, 16),
		(9, 14),
		(10, 1);
        
insert pedidos values
		(null, 1, 2, '2022/05/02'),
		(null, 3, 4, '2022/05/02'),
		(null, 4, 5, '2022/06/02'),
		(null, 1, 4, '2023/03/02'),
		(null, 7, 5, '2023/03/02'),
		(null, 4, 4, '2023/03/02'),
		(null, 5, 5, '2023/03/02'),
		(null, 8, 2, '2023/03/02'),
		(null, 2, 2, '2023/03/02'),
		(null, 7, 1, '2023/03/02');
        
insert titulos_pedidos values
		(1, 1, 2, 150.00),
		(1, 2, 3, 200.00),
		(2, 1, 1, 150.00),
		(2, 2, 3, 200.00),
		(3, 1, 2, 150.00),
		(4, 2, 3, 200.00),
		(5, 1, 2, 150.00),
		(6, 2, 3, 200.00),
		(6, 3, 1, 120.00),
		(7, 4, 2, 70.00),
		(8, 1, 4, 150.00),
		(9, 2, 3, 200.00),
		(10, 7, 2, 250.00);
        
-- Descrições
desc funcionarios;
desc dependentes;
desc estados;
desc cidades;
desc clientes;
desc conjuges;
desc artistas;
desc gravadoras;
desc categorias;
desc titulos;
desc titulos_artistas;
desc pedidos;
desc titulos_pedidos;

-- Consultas	
select * from funcionarios;
select * from dependentes;
select * from estados;
select * from cidades;
select * from clientes;
select * from conjuges;
select * from artistas;
select * from gravadoras;
select * from categorias;
select * from titulos;
select * from titulos_artistas;
select * from pedidos;
select * from titulos_pedidos;


--
--
--

-- Exercícios com uma tabela e calculos(Tabela Titulos)

desc titulos;

-- 	01) TODOS

select * from titulos;

-- 	02) CODIGO 1, 2 OU 3

select * from titulos where cod_tit = 1 or cod_tit = 2 or cod_tit = 3;
select * from titulos where cod_tit in(1, 2, 3);

select * from titulos where cod_tit >= 1 and cod_tit <= 3;
select * from titulos where cod_tit between 1 and 3;

select * from titulos where cod_tit <= 3;
select * from titulos where cod_tit < 4;

select * from titulos order by cod_tit asc limit 3;
select * from titulos order by cod_tit asc limit 0, 3;

-- 	03) CODIGO DIFERENTE DE 2, 6, 9

select * from titulos where cod_tit <> 2 and cod_tit <> 6 and cod_tit <> 9;
select * from titulos where cod_tit not in(2, 6, 9);

-- 	04) PRECO DE VENDA ENTRE 100 e 150

select * from titulos where val_cd between 100 and 150;
select * from titulos where val_cd >= 100 and val_cd <= 150;

-- 	05) PRECO DE CUSTO MENOR QUE 100

select * from titulos where val_compra < 100;

-- 	06) NOME COMEÇADO POR CONSOANTE

select * from titulos where nome_cd not like 'a%' and nome_cd not like 'e%'and nome_cd not like 'i%'and nome_cd not like 'o%'and nome_cd not like 'u%';

select * from titulos where nome_cd regexp'^[bcdfghjklmnpqrstvwxyz]';
select * from titulos where nome_cd regexp '^[^aeiou]';
select * from titulos where nome_cd not regexp '^[aeiou]';

select * from titulos where nome_cd rlike'^[bcdfghjklmnpqrstvwxyz]';
select * from titulos where nome_cd rlike '^[^aeiou]';
select * from titulos where nome_cd not rlike '^[aeiou]';

--  07) NOME QUE CONTENHA O TEXTO 'saber'

select * from titulos where nome_cd like '%saber%';

-- 	08) NOME INICIADO COM 'Acabou'	

select * from titulos where nome_cd like 'Acabou%';

-- 	09) LUCRO MAIOR QUE 50%

select 	
		nome_cd as 'Titulo',
		val_compra as 'Valor de Compra',
		val_cd as 'Valor de Venda',
        val_cd - val_compra as 'Lucro em R$',
        round((val_cd - val_compra) * 100 / val_cd, 1) as 'Lucro em %'
        
        from titulos;

select * from titulos where val_cd > val_compra * 1.5;

-- 	10) LUCRO MENOR QUE 100%

select * from titulos where val_cd < val_compra * 2;

-- 	11) LUCRO MAIOR QUE R$ 100.00

select * from titulos where (val_cd - val_compra) > 100;

--
--
--

-- Exercícios com agregação e INNER JOIN 
        
-- 12) Qtos titulos existem cadastrados no sistema?

select count(cod_tit) from titulos;

-- 13) Liste todos os titulos no sistema, trazendo a Categoria e a gravadora do mesmo.

select 
		nome_cd as 'Titulo',
        nome_cat as 'Categoria',
        nome_grav as 'Gravadora'
        
		from titulos t
        join categorias ct on t.cod_cat = ct.cod_cat
        join gravadoras gr on t.cod_grav = gr.cod_grav
        order by nome_cat, nome_cd;

-- 14) Qual a categoria e valor do titulo mais caro que nós já compramos ?

select 
		nome_cd as 'Titulo',
        nome_cat as 'Categoria',
        val_compra as 'Valor de Compra'
        
		from titulos t
        join categorias ct on t.cod_cat = ct.cod_cat
        where val_compra = (select max(val_compra) from titulos);

-- 15) Qual a Categoria,a gravadora e valor do titulo mais caro que nós já compramos? 

select 
		nome_cd as 'Titulo',
        nome_cat as 'Categoria',
        nome_grav as 'Gravadora',
        val_compra as 'Valor de Compra'
        
		from titulos t
        join categorias ct on t.cod_cat = ct.cod_cat
        join gravadoras gr on t.cod_grav = gr. cod_grav
        where val_compra = (select max(val_compra) from titulos);

-- 16) Qtos clientes do estado de São Paulo estão cadastrados no sistema? PS: Monte a query de busca pelo nome do estado; e não pelo ID do estado. 

select 
        count(nome_cli) as 'Qtd Clientes'
        
        from clientes cl
        join cidades ci on cl.cod_cid = ci.cod_cid
        join estados es on ci.sigla_est = es.sigla_est
        where nome_est = 'São Paulo';
       
-- 17) Qto cada funcionario recebeu de comissão em cada venda ? A comissão é de 50% do lucro

select
		nome_func as 'Nome Funcionário', 
		pd.num_ped as 'Número Pedido',
        group_concat(nome_cd) as 'Títulos',
		sum(round(qtd_cd * (tp.val_cd - val_compra) / 2, 2)) as 'Comissão'
        
		from funcionarios fun
		join pedidos pd on fun.cod_func = pd.cod_func
		join titulos_pedidos tp on pd.num_ped = tp.num_ped
		join titulos ti on tp.cod_tit = ti.cod_tit
        group by pd.num_ped;

-- 18) Qto cada funcionario recebeu ao total ?

select
		nome_func as 'Nome Funcionário', 
		group_concat(distinct pd.num_ped) as 'Número Pedido',
        group_concat(nome_cd) as 'Títulos',
		sum(round(qtd_cd * (tp.val_cd - val_compra) / 2, 2)) as 'Comissão'
        
		from funcionarios fun
		join pedidos pd on fun.cod_func = pd.cod_func
		join titulos_pedidos tp on pd.num_ped = tp.num_ped
		join titulos ti on tp.cod_tit = ti.cod_tit
        group by nome_func
        with rollup;
        
select case 
			when nome_func is not null then nome_func
            else 'Total de comissões'
		end as 'Nome Funcionário',
        case 
			when nome_func is not null then group_concat(distinct pd.num_ped) 
            else '  '
        end	as 'Número Pedidos',        
		sum(round(qtd_cd * (tp.val_cd - val_compra) / 2, 2)) as 'Comissão'
        
		from funcionarios fun
		join pedidos pd on fun.cod_func = pd.cod_func
		join titulos_pedidos tp on pd.num_ped = tp.num_ped
		join titulos ti on tp.cod_tit = ti.cod_tit
        group by nome_func
        with rollup;
     
--
--
--

-- Exercícios com JOIN de varias tabelas e OUTER JOIN

-- 	19)	pedidos de funcionario sem filho

select	
		num_ped as 'Pedido',
		nome_func as 'Funcionario',
		nome_dep as 'Dependente'
        
		from pedidos pd
		join funcionarios fn on pd.cod_func = fn.cod_func
		left join dependentes dp on fn.cod_func = dp.cod_func
		where cod_dep is null
		order by num_ped;

-- 	20)	pedidos de cliente solteiro

select 	
		num_ped as 'Pedido',
		nome_cli as 'Cliente',
		nome_conj as 'Conjuge'
        
		from conjuges cj 
		right join clientes cl on cj.cod_cli = cl.cod_cli
		join pedidos pd on c.cod_cli = pd.cod_cli
		where nome_conj is null;
        
-- 	21)	pedidos de cliente solteiro que comprou 'marisa monte';

select
		p.num_ped as 'Pedido',
		nome_cli as 'Cliente',
		nome_conj as 'Conjuge',
		nome_art as 'Artista',
		nome_cd as 'Titulo'
        
		from conjuges cj 
		right join clientes cL on cj.cod_cli = cL.cod_cli
		join pedidos pD on cL.cod_cli = pD.cod_cli
		join titulos_pedidos tp on pD.num_ped = tp.num_ped
		Join titulos tt on tp.cod_tit = tt.cod_tit
		join titulos_artistas ta on tt.cod_tit = ta.cod_tit
		Join artistas ar on ta.cod_art = ar.cod_art
		where nome_conj is null
		and nome_art = 'Marisa Monte';
            
-- 	22)	pedidos de 'marisa monte', com nome do funcionario e nome do cliente

select
		p.num_ped as 'Pedido',
		nome_cli as 'Cliente',
		nome_func as 'Funcionario',
		nome_art as 'Artista',
		nome_cd as 'Titulo'       
        
		from pedidos pd 
		join clientes c on  c.cod_cli = pd.cod_cli
		join funcionarios fn on pd.cod_func = fn.cod_func 
		join titulos_pedidos tp on pd.num_ped = tp.num_ped
		join titulos tt on tp.cod_tit = tt.cod_tit
		join titulos_artistas ta on t.cod_tit = ta.cod_tit
		join artistas ar on ta.cod_art = ar.cod_art
		where nome_art = 'Marisa Monte';
            
-- 	23)	pedidos de mpb, exceto titulo começado com vogal, com nome do funcionario e nome do cliente e com o nome do conjuge e filhos, (se existirem)

select	p.num_ped as 'Pedido',
			nome_func as 'Funcionario',
            nome_dep as 'Dependente',
            nome_cli as 'Cliente',
            nome_conj as 'Conjuge',
            nome_cd as 'Titulo'

			from pedidos pd 
            
            join funcionarios fn on pd.cod_func = fn.cod_func
            left join dependentes d on f.cod_func = d.cod_func
            
            join clientes cl on pd.cod_cli = cl.cod_cli
            left join conjuges cj on cl.cod_cli = cj.cod_cli
            
			join titulos_pedidos tp on pd.num_ped = tp.num_ped
            join titulos tt on tp.cod_tit = tt.cod_tit
            join categorias ct on tt.cod_cat = ct.cod_cat
            
            where nome_cat = 'MPB'
            and nome_cd regexp '^[^aeiou]';
            
--
--
--

-- Exercícios com SUB SELECT

-- 26) Apresente todos os clientes Solteiros 

select * from clientes where cod_cli not in(select cod_cli from conjuges);

-- 27) Apresente todos os Clientes Casados 

select * from clientes where cod_cli in(select cod_cli from conjuges);

select 	
		nome_cli as 'Cliente', 
		'Solteiro' as 'Estado Civil' 
		from clientes where cod_cli not in(select cod_cli from conjuges)
		union 
		select 	nome_cli ,  
		'Casado' 
            
		from clientes where cod_cli in(select cod_cli from conjuges)
            
		order by Cliente;
            
-- 28) Apresente todas as categorias que estão sem CD 

select * from categorias where cod_cat not in(select distinct cod_cat from titulos);

-- 29) Apresente	apenas os funcionários que tem dependentes e que nunca atenderam a nenhum pedido

select 	
		* 
		from funcionarios
		where cod_func in(select distinct cod_func from dependentes)
		and cod_func not in(select distinct cod_func from pedidos);
            
-- 30) Mostre todos os funcionários que atenderam a pedidos de clientes casados

select 
		* from funcionarios where cod_func in(
		select distinct cod_func from pedidos where cod_cli in
		(select cod_cli from conjuges));
        
-- 31) Apresente os dados dos CDs Mais Caros 

select * from titulos order by val_cd desc limit 1;

select * from titulos where val_cd = (select max(val_cd) from titulos);

--
--
--

-- Exercícios com GROUP BY

-- 32) Quantos títulos possui cada artista no catálogo ? 

select 	
		nome_art as 'Arista',
		count(nome_cd) as 'Qtd_Titulos',
		group_concat(nome_cd) as 'Titulos'
        
		from artistas ar
		left join titulos_artistas ta on ar.cod_art = ta.cod_art
		left join titulos tt on ta.cod_tit = tt.cod_tit
		group by nome_art
		having count(nome_cd) < 2
		order by Qtd_Titulos;
        
-- 33) Quantos artistas possui cada Gravadora em nosso catálogo ? 

select	
		nome_grav as 'Gravadora',
		count(nome_art) as 'Qtd Artista',
		group_concat(nome_art) as 'Artsita'
        
		from gravadoras gr
		join titulos tt on gr.cod_grav = tt.cod_grav
		join titulos_artistas ta on tt.cod_tit = ta.cod_tit
		join artistas ar on ta.cod_art = ar.cod_art
		group by nome_grav;
        
-- 34) Quantos artistas possui cada Gravadora em nosso catálogo e qual o total de artistas ? 

select	
		nome_grav as 'Gravadora',
		count(nome_art) as 'Qtd Artista',
		group_concat(nome_art) as 'Artsita'
		from gravadoras gr
		join titulos tt on gr.cod_grav = tt.cod_grav
		join titulos_artistas ta on tt.cod_tit = ta.cod_tit
		join artistas ar on ta.cod_art = ar.cod_art
		group by nome_grav
		with rollup;
        
-- 35) Liste todos os pedidos feitos no ano de 2023 e qual o total faturado no ano ? 

select 
		p.num_ped as 'Pedido',
		qtd_cd * val_cd as 'Valor Pedido'
        
		from pedidos pd
		join titulos_pedidos tp on pd.num_ped = tp.num_ped 
		where year(data_ped) = 2022;
 
 select 	
		case
			when p.num_ped is not null then p.num_ped 
		else 'Total Faturado no Ano'
			end   as 'Pedido',
		sum(qtd_cd * val_cd) as 'Valor Pedido'
        
		from pedidos p
		join titulos_pedidos tp on pd.num_ped = tp.num_ped 
		where year(data_ped) = 2022
		group by pd.num_ped
		with rollup;
            
 select 	
		p.num_ped as 'Pedido',
		sum(qtd_cd * val_cd) as 'Valor Pedido'
        
		from pedidos pd
		join titulos_pedidos tp on pd.num_ped = tp.num_ped 
		where year(data_ped) = 2023
		group by pd.num_ped
		having sum(qtd_cd * val_cd) > 500
	union
select
		'Total',
		sum(qtd_cd * val_cd) 
		from pedidos pd
		join titulos_pedidos tp on pd.num_ped = tp.num_ped 
		where year(data_ped) = 2013
		having sum(qtd_cd * val_cd) > 500;    

            
-- 36) Liste todos os funcionarios e quantos dependentes cada um deles possui. 

select	
		nome_func as 'Funcionarios',
		count(nome_dep) as 'No Dependentes',
		group_concat(nome_dep) as 'Nome Dependentes'
        
		from funcionarios fn
		left join dependentes dp on fn.cod_func = dp.cod_func
		group by nome_func
		order by 2;
        
--
--
--

-- UNION

-- 37) Todos os pedidos com funcionarios e clientes. 
-- Trazer conjuges e dependentes se existirirem.
-- trazer funcionarios e clientes que nunca fizeram um pedido.

select	
		num_ped,
		nome_func,
		nome_dep,
		nome_cli,
		nome_conj
        
		from pedidos pd
		right join funcionarios fn on pd.cod_func = fn.cod_func
		left join dependentes dp on fn.cod_func = dp.cod_func
		left join clientes cl on pd.cod_cli = cl.cod_cli
		left  join conjuges cj on cl.cod_cli = cj.cod_cli;

select	
		num_ped,
		nome_func,
		nome_dep,
		nome_cli,
		nome_conj
		from pedidos pd
		right join funcionarios fn on pd.cod_func = fn.cod_func
		left join dependentes dp on fn.cod_func = dp.cod_func
		right join clientes cl on pd.cod_cli = cl.cod_cli
		left  join conjuges cj on cl.cod_cli = cj.cod_cli;

select	
		num_ped,
		nome_func,
		nome_dep,
		nome_cli,
		nome_conj
        
		from pedidos pd
		right join funcionarios fn on pd.cod_func = fn.cod_func
		left join dependentes dp on fn.cod_func = dp.cod_func
		LEFT join clientes cl on pd.cod_cli = cl.cod_cli 
		left  join conjuges cj on cl.cod_cli = cj.cod_cli
	union
select	
		num_ped,
		nome_func,
		nome_dep,
		nome_cli,
		nome_conj
        
		from pedidos pd
		right join funcionarios fn on pd.cod_func = fn.cod_func
		left join dependentes dp on fn.cod_func = dp.cod_func
		right join clientes cl on pd.cod_cli = cl.cod_cli
		left  join conjuges cj on cl.cod_cli = cj.cod_cli;

--
--
--

-- view

-- 38) Criar view com a consulta anterior 

create or replace view mostraTudo as
	select	
			num_ped,
			nome_func,
            nome_dep,
            nome_cli,
            nome_conj
			from pedidos pd
            right join funcionarios fn on pd.cod_func = fn.cod_func
            left join dependentes dp on fn.cod_func = dp.cod_func
            LEFT join clientes cl on pd.cod_cli = cl.cod_cli
           left  join conjuges cj on cl.cod_cli = cj.cod_cli
		union
	select	num_ped,
			nome_func,
            nome_dep,
            nome_cli,
            nome_conj
			from pedidos pd
            right join funcionarios fn on pd.cod_func = fn.cod_func
            left join dependentes dp on fn.cod_func = dp.cod_func
            RIGHT join clientes cl on pd.cod_cli = cl.cod_cli
           left  join conjuges cj on cl.cod_cli = cj.cod_cli;

--
--
--

-- tabela temporaria

-- 39)Criar tabela temporaria view com o resultado da consulta utilizando a view criada na questão anterior.


	create temporary table temp_mostraTudo as select * from mostratudo; 
	desc temp_mostraTudo;
	select * from  temp_mostraTudo;

	select * from temp_mostratudo
				where num_ped is null
				and nome_conj is not null;


            

