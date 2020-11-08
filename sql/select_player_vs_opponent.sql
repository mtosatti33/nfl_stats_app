-- INSTRUÇÃO SQL QUE RETORNA O RETROSPECTO DO JOGADOR CONTRA O OPONENTE SELECIONADO (VITÓRIAS / DERROTAS)--

select p2."name" as "Player",
count(*) as "Games",
count(g.game_won=true or null) as Won,
count(g.game_won=false or null) as Lost,
count(g.game_won=true or null)/cast(count(*) as numeric(5,2))*100 as "Win Pct",
g.opponent as "Opp"
from games g, players p2 where g.player_id =:player_id 
and p2.player_id =g.player_id 
and g.opponent =:opponent
group by p2."name", g.opponent 
order by 5 desc
