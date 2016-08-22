-- 3 a)
select C.Esfera, SUM(C.NRODECADEIRAS) from Cargo C group by C.Esfera;

-- 3 b)
select distinct S.NROSESSAO, S.NROZONA, S.NSERIAL from SESSAO S, BAIRRO B, CIDADE C
  where S.NROZONA = B.NROZONA and 
        B.NOMECIDADE = C.NOME and 
        B.SIGLAESTADO = C.SIGLAESTADO and
        C.POPULACAO > 100000
        order by S.NROSESSAO;
        
-- 3 c)
select distinct P.NOME, P.SIGLA from PARTIDO P, CANDIDATO, CANDIDATURA, CARGO
where P.SIGLA = CANDIDATO.SIGLAPARTIDO and 
      CANDIDATO.NROCAND = CANDIDATURA.NROCAND and
      CANDIDATURA.CODCARGO = CARGO.CODCARGO and
      CARGO.ESFERA = 'E'
      order by P.NOME;
      
-- 3 d)
select distinct Candidato.NOME, 
                Candidato.NROCAND,
                Cargo.NOMEDESCRITIVO, 
                Cargo.NOMECIDADE, 
                Cargo.SIGLAESTADO, 
                SUM(Pleito.TOTAL) as NUM_VOTOS from Candidato, Candidatura, Pleito, Cargo
where Candidato.NROCAND = Candidatura.NROCAND and
      Candidatura.ANO = 2014 and
      Candidatura.CODCARGO = Cargo.CODCARGO and
      Candidatura.NROCAND = Pleito.NROCAND and
      Candidato.NOME <> 'Nulo' and
      Candidato.NOME <> 'Branco'
      group by Candidato.NOME, Candidato.NROCAND, Cargo.NOMEDESCRITIVO, Cargo.NOMECIDADE, Cargo.SIGLAESTADO
      order by Cargo.NOMEDESCRITIVO, NUM_VOTOS;   
      
-- 3 e)
select P.REGPESQUISA, P.PERIODOINICIO, P.PERIODOFIM, P.ORGAOPESQUISA from Pesquisa P
where P.PERIODOFIM - P.PERIODOINICIO > 30;

-- 3 f)
select Candidato.NROCAND, Candidato.NOME, SUM(Pleito.TOTAL)/COUNT(Candidatura.ANO) from Candidato, Candidatura, Pleito
where Candidato.NROCAND = Candidatura.NROCAND and
      Candidatura.NROCAND = Pleito.NROCAND and
      Candidato.NROCAND > 0
      group by Candidato.NROCAND, Candidato.NOME
      order by Candidato.NROCAND;
    
-- 4 a)
select Candidato.NROCAND, 
       Candidato.TIPO, 
       Candidato.CPF, 
       Candidato.NOME, 
       Candidato.IDADE, 
       Candidato.APELIDO, 
       Candidato.SIGLAPARTIDO 
from Candidato, Candidatura, Cargo
where Candidato.NROCAND = Candidatura.NROCAND and
      Candidatura.CODCARGO = Cargo.CODCARGO and
      Cargo.POSSUIVICE = 1 and 
      Candidato.NROCAND > 0
      order by Candidato.NROCAND;
      
-- 4 b)
select Candidato.NROCAND, 
       Candidato.TIPO, 
       Candidato.CPF, 
       Candidato.NOME, 
       Candidato.IDADE, 
       Candidato.APELIDO, 
       Candidato.SIGLAPARTIDO 
from Candidato 
where NROCAND > 0 and
exists (
  select Candidatura.NROCAND from Candidatura
  where Candidato.NROCAND = Candidatura.NROCAND and
  exists (
    select Cargo.CODCARGO from Cargo 
    where Candidatura.CODCARGO = Cargo.CODCARGO and
          Cargo.POSSUIVICE = 1
  )
)
order by NROCAND;

-- 4 c)
select Candidato.NROCAND, 
       Candidato.TIPO, 
       Candidato.CPF, 
       Candidato.NOME, 
       Candidato.IDADE, 
       Candidato.APELIDO, 
       Candidato.SIGLAPARTIDO 
from Candidato 
where NROCAND > 0 and
NROCAND in (
  select Candidatura.NROCAND from Candidatura
  where Candidato.NROCAND = Candidatura.NROCAND and
  Candidatura.CodCargo in (
    select Cargo.CODCARGO from Cargo 
    where Candidatura.CODCARGO = Cargo.CODCARGO and
          Cargo.POSSUIVICE = 1
  )
)
order by NROCAND;