-- INSTRUÇÃO SQL QUE RETORNA O CALENDÁRIO DO TIME--
select distinct g."year", g.game_id, g."date" as "Dt", g.team as "Tm", g.opponent as "Opp", g.player_team_score as "T.Score", g.opponent_score as "O.Score", g.game_won as "Won?"
from games g
where g.team = :team
and g."year" =:year