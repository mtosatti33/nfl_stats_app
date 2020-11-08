-- INSTRUÇÃO SQL QUE RETORNA O RETROSPECTO DO JOGADOR CONTRA TODOS OS OPONENTES (VITÓRIAS / DERROTAS)--
select p2."name",
count(*) as "Games",
count(g.game_won=true or null) as won,
count(g.game_won=false or null) as lost,
count(g.game_won=true or null)/cast(count(*) as numeric(5,2))*100 as "Win Pct",
g.opponent 
from games g, players p2 where g.player_id =:player_id 
and p2.player_id =g.player_id 
and g.opponent in (select distinct g2.team from games g2)
group by p2."name", g.opponent 
order by 5 desc