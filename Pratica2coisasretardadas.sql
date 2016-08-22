ALTER TABLE Pesquisa 
ADD Instituto VARCHAR(50) DEFAULT('DATAFOLHA') NOT NULL
CONSTRAINT ck_pesquisa_instituto CHECK (Instituto != '');

ALTER TABLE Pesquisa 
ADD PartidoPatrocinador number;

ALTER TABLE Pesquisa 
ADD CONSTRAINT fk_pesquisa_patrocinador foreign key (PartidoPatrocinador) references Partido(id) on delete cascade;

alter table Pesquisa disable constraint ck_pesquisa_data;
insert into Pesquisa(DataInicio, DataFim) values (to_date('01-05-2010', 'dd-mm-yyyy'), to_date('01-01-2010', 'dd-mm-yyyy'));
alter table Pesquisa enable constraint ck_pesquisa_data;