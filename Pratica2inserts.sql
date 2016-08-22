insert into Cidade (id, nome, estado) values (sequence_cidade.nextVal, 'Sao Paulo', SP); 
insert into Cidade (id, nome, estado) values (sequence_cidade.nextVal, 'Taubate', SP); 
insert into Zona (id, idCidade) values (sequence_zona.nextVal, ALGUM NUMERO COMU FAZ ISSU); 
insert into Zona (id, idCidade) values (sequence_zona.nextVal, ALGUM NUMERO COMU FAZ ISSU); 
insert into Sessao (id, idZona, idCidade) values (sequence_zona.nextVal, ALGUM NUMERO COMU FAZ ISSU, ALGUM NUMERO COMU FAZ ISSU); 
insert into Sessao (id, idZona, idCidade) values (sequence_zona.nextVal, ALGUM NUMERO COMU FAZ ISSU, ALGUM NUMERO COMU FAZ ISSU); 
insert into Bairro (nome, idSessao, idZona, idCidade) values ('Vila Mariana', ALGUMNUMERO, ALGUMNUMERO); 
insert into Bairro (nome, idSessao, idZona, idCidade) values ('Morumbi', ALGUMNUMERO, ALGUMNUMERO); 
insert into Urna (id) values (sequence_urna.nextVal); 
insert into Urna (id) values (sequence_urna.nextVal); 
insert into UrnaReserva (id, idZona, idCidade) values (sequence_zona.nextVal, ALGUM NUMERO COMU FAZ ISSU, ALGUM NUMERO COMU FAZ ISSU); 
insert into UrnaReserva (id, idZona, idCidade) values (sequence_zona.nextVal, ALGUM NUMERO COMU FAZ ISSU, ALGUM NUMERO COMU FAZ ISSU); 
insert into Eleicao (id, ano, turno) values (sequence_urna.nextVal, 2010, 1); 
insert into Eleicao (id, ano, turno) values (sequence_urna.nextVal, 2014, 1); 
insert into Cargo (id, nome, possuiVice, anoBase, anosDeMandato, numeroDeCadeiras, esferaCargo) values (sequence_cargo.nextVal, 'Prefeito de Sao Paulo', 0, 2010, 4, 2, 'MUNICIPAL'); 
insert into Cargo (id, nome, possuiVice, anoBase, anosDeMandato, numeroDeCadeiras, esferaCargo) values (sequence_cargo.nextVal, 'Prefeito de Tauate', 0, 2010, 4, 2, 'MUNICIPAL'); 
insert into UrnaEleicaoCargo (urna, eleicao, cargo, brancos, nulos) values (IDDAURNACOMUFAZ, IDELEICAOPLS, EIDDUCARGO, 1000, 50); 
insert into UrnaEleicaoCargo (urna, eleicao, cargo, brancos, nulos) values (IDDAURNACOMUFAZ, IDELEICAOPLS, EIDDUCARGO, 20000, 700); 
insert into Partido (id, nome) values (sequence_partido.nextVal, 'Partido dos Trabalhadores');
insert into Partido (id, nome) values (sequence_partido.nextVal, 'Partido Partido Socialismo e Liberdade');
insert into Candidato (cpf, nome, partido) values ('3239098900', 'Gabriel Scalet Bicalho', IDDOPTPLMRDDEUS);
insert into Candidato (cpf, nome, partido) values ('0236022308', 'Guilherme Zanardo', IDDOPSOLPLMRDDEUS);
insert into Pleito (urna, candidatura, quantidade) values (IDdiURNA, IDdacandidaturaMUDAISSU, 666);
insert into Pleito (urna, candidatura, quantidade) values (IDdiURNA, IDdacandidaturaMUDAISSU, 999);
insert into Pesquisa (DataInicio, DataFim) values (TODATE('01-01-2010', 'dd-mm-yyyy', TODATE('01-05-2010', 'dd-mm-yyyy'));
insert into Pesquisa (DataInicio, DataFim) values (TODATE('01-01-2014', 'dd-mm-yyyy', TODATE('01-05-2014', 'dd-mm-yyyy'));
insert into Intencao (candidatura, DataInicio, DataFim, quantidade) values (idCandidaturaARRUMACARAI, TODATE('01-01-2014', 'dd-mm-yyyy', TODATE('01-05-2014', 'dd-mm-yyyy'), 50);
insert into Intencao (candidatura, DataInicio, DataFim, quantidade) values (idCandidaturaARRUMACARAI, TODATE('02-01-2014', 'dd-mm-yyyy', TODATE('01-05-2014', 'dd-mm-yyyy'), 3000);

update cargo
	set numeroDeCadeiras = 10, possuiVice = 1
	where upper(nome) like 'PREFEITO%'

