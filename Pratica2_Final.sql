create sequence SEQUENCE_CIDADE minvalue 1 start with 1 increment by 1 nocycle nocache;
create sequence SEQUENCE_ZONA minvalue 1 start with 1 increment by 1 nocycle nocache;
create sequence SEQUENCE_SESSAO minvalue 1 start with 1 increment by 1 nocycle nocache;
create sequence SEQUENCE_URNA minvalue 1 start with 1 increment by 1 nocycle nocache;
create sequence SEQUENCE_CARGO minvalue 1 start with 1 increment by 1 nocycle nocache;
create sequence SEQUENCE_ELEICAO minvalue 1 start with 1 increment by 1 nocycle nocache;
create sequence SEQUENCE_PARTIDO minvalue 1 start with 1 increment by 1 nocycle nocache;
create sequence SEQUENCE_CANDIDATURA minvalue 1 start with 1 increment by 1 nocycle nocache;


create table Cidade (
  id number not null,
  nome varchar2(50) not null,
  estado char(2) not null,
  
  constraint pk_cidade primary key (id),
  constraint un_cidade unique (nome, estado)
);

create table Zona(
  id number not null,
  idCidade number not null,
  
  constraint pk_zona primary key (id, idCidade),
  constraint fk_zona_cidade foreign key (idCidade) references Cidade(id) on delete cascade
);

create table Sessao(
  id number not null,
  idZona number not null,
  idCidade number not null,
  
  constraint pk_sessao primary key (id, idZona, idCidade),
  constraint fk_sessao_zona foreign key (idZona, idCidade) references Zona(id, idCidade) on delete cascade
);

create table Bairro(
  nome varchar2(50) not null,
  idSessao number not null,
  idZona number not null,
  idCidade number not null,
  
  constraint pk_bairro primary key (nome, idSessao, idZona, idCidade),
  constraint fk_bairro_sessao foreign key (idSessao, idZona, idCidade) references Sessao(id, idZona, idCidade) on delete cascade
);

create table Urna(
  id number not null,
  
  constraint pk_urna primary key (id)
);

create table UrnaReserva(
  id number not null,
  idZona number not null,
  idCidade number not null,
  
  constraint pk_urnaRes primary key (id),
  constraint fk_urnaRes_urna foreign key (id) references Urna(id) on delete cascade,
  constraint fk_urnaRes_zona foreign key (idZona, idCidade) references Zona(id, idCidade) on delete cascade
);

create table UrnaUtilizada(
  id number not null,
  idSessao number not null,
  idZona number not null,
  idCidade number not null,
  
  constraint pk_urnaUtil primary key (id),
  constraint fk_urnaUtil_urna foreign key (id) references Urna(id) on delete cascade,
  constraint fk_urnaUtil_sessao foreign key (idSessao, idZona, idCidade) references Sessao(id, idZona, idCidade) on delete cascade
);

create table Eleicao(
  id number not null,
  ano number not null,
  turno number default 1 not null,
  
  constraint pk_eleicao primary key (id),
  constraint un_eleicao unique (ano, turno)
);

create table Cargo(
  id number not null,
  Nome varchar2(50) not null,
  PossuiVice number(1) default 0 not null,
  AnoBase number not null,
  AnosDeMandato number default 4 not null,
  NumeroDeCadeiras number not null,
  EsferaCargo varchar2(9) default 'MUNICIPAL' not null,
  
  constraint pk_cargo primary key (id),
  constraint un_cargo unique (nome),
  constraint ck_cargo_esfera check ((upper(EsferaCargo) = 'MUNICIPAL') or (upper(EsferaCargo) = 'ESTADUAL') or (upper(EsferaCargo) = 'FEDERAL'))
);

create table UrnaEleicaoCargo(
  urna number not null,
  eleicao number not null,
  cargo number not null,
  brancos number default 0 not null,
  nulos number default 0 not null,
  
  constraint pk_urnaEleCarg primary key (urna, eleicao, cargo),
  constraint fk_urnaEleCarg_urnaUtil foreign key (urna) references UrnaUtilizada(id) on delete cascade,
  constraint fk_urnaEleCarg_eleicao foreign key (eleicao) references Eleicao(id) on delete cascade,
  constraint fk_urnaEleCarg_cargo foreign key (cargo) references Cargo(id) on delete cascade
);

create table Partido(
  id number not null,
  Nome varchar2(50) not null,
  
  constraint pk_partido primary key (id),
  constraint un_partido unique (nome)
);

create table Candidato(
  cpf varchar2(11) not null,
  nome varchar2(50) not null,
  partido number not null,
  
  constraint pk_candidato primary key (cpf),
  constraint fk_candidato_partido foreign key (partido) references Partido(id) on delete cascade
);

create table Candidatura(
  id number not null,
  eleicao number not null,
  cargo number not null,
  candidato varchar2(11) not null,
  vice varchar2(11),
  
  constraint pk_candidatura primary key(id),
  constraint un_candidatura_candElei unique (eleicao, candidato),
  constraint un_candidatura_eleiCarCand unique (eleicao, cargo, candidato),
  constraint fk_candidatura_eleicao foreign key (eleicao) references Eleicao(id) on delete cascade,
  constraint fk_candidatura_cargo foreign key (cargo) references Cargo(id) on delete cascade,
  constraint fk_candidatura_candidato foreign key (candidato) references Candidato(cpf) on delete cascade,
  constraint fk_candidatura_vice foreign key (vice) references Candidato(cpf) on delete cascade,
  constraint ck_candidatura_eqViceCand check (candidato != vice)
);

create table pleito(
  urna number not null,
  candidatura number not null,
  quantidade number not null,
  
  constraint pk_pleito primary key (urna, candidatura),
  constraint fk_pleito_urnaUtil foreign key (urna) references UrnaUtilizada(id) on delete cascade,
  constraint fk_pleito_candidatura foreign key (candidatura) references Candidatura(id) on delete cascade
);

create table Pesquisa(
  DataInicio date not null,
  DataFim date not null,
  
  constraint pk_pesquisa primary key (DataInicio, DataFim),
  constraint ck_pesquisa_data check (DataInicio < DataFim) 
);

create table Intencao(
  candidatura number not null,
  DataInicio date not null,
  DataFim date not null,
  quantidade number default 0 not null,
  
  constraint pk_intencao primary key (candidatura, dataInicio, dataFim),
  constraint fk_intencao_candidatura foreign key (candidatura) references Candidatura(id) on delete cascade,
  constraint fk_intencao_pesquisa foreign key (DataInicio, DataFim) references Pesquisa(DataInicio, DataFim) on delete cascade
);

insert into Cidade (id, nome, estado) values (sequence_cidade.nextVal, 'Sao Paulo', 'SP'); 
insert into Cidade (id, nome, estado) values (sequence_cidade.nextVal, 'Taubate', 'SP'); 
insert into Zona (id, idCidade) values (sequence_zona.nextVal, 1); 
insert into Zona (id, idCidade) values (sequence_zona.nextVal, 2); 
insert into Sessao (id, idZona, idCidade) values (sequence_sessao.nextVal, 1, 1); 
insert into Sessao (id, idZona, idCidade) values (sequence_sessao.nextVal, 2, 2); 
insert into Bairro (nome, idSessao, idZona, idCidade) values ('Vila Mariana', 1, 1, 1); 
insert into Bairro (nome, idSessao, idZona, idCidade) values ('Morumbi', 2, 2, 2); 
insert into Urna (id) values (sequence_urna.nextVal); 
insert into Urna (id) values (sequence_urna.nextVal); 
insert into Urna (id) values (sequence_urna.nextVal); 
insert into Urna (id) values (sequence_urna.nextVal); 
insert into UrnaReserva (id, idZona, idCidade) values (1, 1, 1); 
insert into UrnaReserva (id, idZona, idCidade) values (2, 2, 2); 
insert into UrnaUtilizada (id, idSessao, idZona, idCidade) values (3, 1, 1, 1); 
insert into UrnaUtilizada (id, idSessao, idZona, idCidade) values (4, 2, 2, 2); 
insert into Eleicao (id, ano, turno) values (sequence_eleicao.nextVal, 2010, 1); 
insert into Eleicao (id, ano, turno) values (sequence_eleicao.nextVal, 2014, 1); 
insert into Cargo (id, nome, possuiVice, anoBase, anosDeMandato, numeroDeCadeiras, esferaCargo) values (sequence_cargo.nextVal, 'Prefeito de Sao Paulo', 0, 2010, 4, 2, 'MUNICIPAL'); 
insert into Cargo (id, nome, possuiVice, anoBase, anosDeMandato, numeroDeCadeiras, esferaCargo) values (sequence_cargo.nextVal, 'Prefeito de Taubate', DEFAULT, 2010, 4, 2, 'MUNICIPAL'); 
insert into Cargo (id, nome, possuiVice, anoBase, anosDeMandato, numeroDeCadeiras, esferaCargo) values (sequence_cargo.nextVal, 'Vereador de Sao Paulo', 0, 2010, 4, 2, 'MUNICIPAL'); 
insert into UrnaEleicaoCargo (urna, eleicao, cargo, brancos, nulos) values (3, 1, 1, 1000, 50); 
insert into UrnaEleicaoCargo (urna, eleicao, cargo, brancos, nulos) values (4, 2, 2, 20000, 700); 
insert into Partido (id, nome) values (sequence_partido.nextVal, 'Partido dos Trabalhadores');
insert into Partido (id, nome) values (sequence_partido.nextVal, 'Partido Partido Socialismo e Liberdade');
insert into Candidato (cpf, nome, partido) values ('32390989001', 'Gabriel Scalet Bicalho', 1);
insert into Candidato (cpf, nome, partido) values ('02360223008', 'Guilherme Zanardo', 2);
insert into Candidato (cpf, nome, partido) values ('39845687388', 'Danilo Pitu', 2);
insert into Candidatura (id, eleicao, cargo, candidato, vice) values (sequence_candidatura.nextVal, 1, 1, '02360223008', '32390989001');
insert into Candidatura (id, eleicao, cargo, candidato, vice) values (sequence_candidatura.nextVal, 1, 3, '39845687388', null);
insert into Candidatura (id, eleicao, cargo, candidato, vice) values (sequence_candidatura.nextVal, 2, 2, '32390989001', '02360223008');
insert into Pleito (urna, candidatura, quantidade) values (3, 1, 666);
insert into Pleito (urna, candidatura, quantidade) values (4, 2, 999);
insert into Pesquisa (DataInicio, DataFim) values (TO_DATE('01-01-2010', 'dd-mm-yyyy'), TO_DATE('01-05-2010', 'dd-mm-yyyy'));
insert into Pesquisa (DataInicio, DataFim) values (TO_DATE('01-01-2014', 'dd-mm-yyyy'), TO_DATE('01-05-2014', 'dd-mm-yyyy'));
insert into Pesquisa (DataInicio, DataFim) values (TO_DATE('02-01-2014', 'dd-mm-yyyy'), TO_DATE('02-05-2014', 'dd-mm-yyyy'));
insert into Intencao (candidatura, DataInicio, DataFim, quantidade) values (1, TO_DATE('01-01-2014', 'dd-mm-yyyy'), TO_DATE('01-05-2014', 'dd-mm-yyyy'), 50);
insert into Intencao (candidatura, DataInicio, DataFim, quantidade) values (2, TO_DATE('02-01-2014', 'dd-mm-yyyy'), TO_DATE('02-05-2014', 'dd-mm-yyyy'), 3000);

-- 3 c)
update cargo
	set numeroDeCadeiras = 10, possuiVice = 1
	where upper(nome) like 'PREFEITO%';

delete from Cidade where Nome = 'Taubate';


-- 4 a)
ALTER TABLE Pesquisa 
ADD Instituto VARCHAR(50) DEFAULT('DATAFOLHA') NOT NULL
CONSTRAINT ck_pesquisa_instituto CHECK (Instituto != '');

-- 4 b)
ALTER TABLE Pesquisa 
ADD PartidoPatrocinador number;
ALTER TABLE Pesquisa 
ADD CONSTRAINT fk_pesquisa_patrocinador foreign key (PartidoPatrocinador) references Partido(id) on delete cascade;

-- 4 d)
alter table Pesquisa disable constraint ck_pesquisa_data;
insert into Pesquisa(DataInicio, DataFim) values (to_date('01-05-2010', 'dd-mm-yyyy'), to_date('01-01-2010', 'dd-mm-yyyy'));
alter table Pesquisa enable constraint ck_pesquisa_data;