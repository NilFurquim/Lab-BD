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