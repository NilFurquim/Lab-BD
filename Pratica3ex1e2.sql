update Pleito
  set total = dbms_random.value(100000, 999999);
 -- 27 linhas atualizado.
  
GRANT INSERT (RegPesquisa, RegCandid) ON LE13INTENCAODEVOTO TO a8937204 WITH GRANT OPTION;
GRANT SELECT ON LE07PARTIDO TO a8937204 WITH GRANT OPTION;
GRANT SELECT ON LE08CANDIDATO TO a8937204 WITH GRANT OPTION;
-- Testes de permissão de user1
INSERT INTO a8937250.LE13INTENCAODEVOTO (RegPesquisa, RegCandid) VALUES (1, 7);
-- 1 linha inserido.
/*
INSERT INTO a8937250.LE13INTENCAODEVOTO (RegPesquisa, RegCandid, Total) VALUES (1, 7, 3089);
Relatório de erros -
Erro de SQL: ORA-01031: privilégios insuficientes
01031. 00000 -  "insufficient privileges"
*/
select * from a8937250.PARTIDO;
select * from a8937250.CANDIDATO;


GRANT INSERT (RegPesquisa, RegCandid) ON a8937250.L13INTENCAODEVOTO TO g8937204;
GRANT SELECT ON a8937250.LE07PARTIDO TO g8937204;
GRANT SELECT ON a8937250.LE08CANDIDATO TO g8937204;
-- Testes de permissão de user2

REVOKE INSERT ON LE13INTENCAODEVOTO FROM a8937204;
REVOKE SELECT ON LE07PARTIDO FROM a8937204;
REVOKE SELECT ON LE08CANDIDATO FROM a8937204;
--Testes de permissão de ambos

/*
Relatório de erros -
Erro de SQL: ORA-00942: a tabela ou view não existe
00942. 00000 -  "table or view does not exist"

Relatório de erros -
Erro de SQL: ORA-00942: a tabela ou view não existe
00942. 00000 -  "table or view does not exist"
*/
