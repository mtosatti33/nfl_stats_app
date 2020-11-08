-- INSTRUÇÃO SQL QUE RETORNA AS ESTATÍSTICAS DE CADA JOGADOR DO TIME POR ANO--
select 
p.player_id,
p."name" as "Player",
p."position" as "Pos",
count(g.game_id) as "G",
-- Passing --
cast(sum(g.passing_completions) || '/' || sum(g.passing_attempts) as varchar(15)) as "C/A",
sum(g.passing_completions)/cast(nullif(sum(g.passing_attempts),0) as decimal(5,2))*100 as "Pa.Pct",
sum(g.passing_yards) as "Pa.Yds",
sum(g.passing_touchdowns) as "Pa.TD",
sum(g.passing_interceptions) as "Pa.Int",
avg(g.passing_rating) as "Rate",
sum(g.passing_sacks) as "Sckd",
-- Rushing --
sum(g.rushing_attempts) as "Rush",
sum(g.rushing_yards) as "Ru.Yds",
sum(g.rushing_yards)/cast(nullif(sum(g.rushing_attempts),0) as decimal(5,2)) as "Ru.Av",
sum(g.rushing_touchdowns) as "Ru.TD",
-- Receiving --
sum(g.receiving_targets) as "Tgt",
sum(g.receiving_receptions) as "Rec",
sum(g.receiving_yards) as "Re.Yds",
sum(g.receiving_yards)/cast(nullif(sum(g.receiving_receptions),0) as decimal(5,2)) as "Re.Av",
sum(g.receiving_touchdowns) as "Re.TD",
-- Defense --
sum(g.defense_tackles)+sum(g.defense_tackle_assists) as "Comb",
cast(sum(g.defense_tackles) || '/' || sum(g.defense_tackle_assists) as varchar(15)) as "T/A",
sum(g.defense_sacks) as "Scks",
sum(defense_interceptions) as "Int",
sum(g.defense_interception_yards) as "Int.Yds",
sum(g.defense_interception_touchdowns) as "Int.TD",
sum(g.defense_safeties) as "Sft",
-- Returning --
sum(g.kick_return_attempts) as "KR",
sum(g.kick_return_yards) as "KR.Yds",
sum(g.kick_return_yards)/cast(nullif(sum(g.kick_return_attempts),0) as decimal(5,2)) as "KR.Av",
sum(g.kick_return_touchdowns) as "KR.TD",
sum(g.punt_return_attempts) as "PR",
sum(g.punt_return_yards) as "PR.Yds",
sum(g.punt_return_yards)/cast(nullif(sum(g.punt_return_attempts),0) as decimal(5,2)) as "PR.Av",
sum(g.punt_return_touchdowns) as "PR.TD",
-- Kicking --
cast(sum(g.field_goal_makes) || '/' ||sum(g.field_goal_attempts) as varchar(15)) as "FM/FA",
sum(g.field_goal_makes)/cast(nullif(sum(g.field_goal_attempts),0) as decimal(5,2))*100 as "FG.Pct",
cast(sum(g.point_after_makes) || '/' ||sum(g.point_after_attempts) as varchar(15)) as "XM/XA",
sum(g.point_after_makes)/cast(nullif(sum(g.point_after_attempts),0) as decimal(5,2))*100 as "XP.Pct",
-- Punting --
sum(g.punting_attempts) as "Punts",
sum(g.punting_yards) as "Pu.Yds",
sum(g.punting_yards)/cast(nullif(sum(g.punting_attempts),0) as decimal(5,2)) as "Pu.Av",
sum(g.punting_blocked) as "Blckd",
-- Fumbles --
sum(g.fumbles) as "Fmb",
sum(g.fumbles_lost) as "Lost",
sum(g.fumbles_forced) as "FF",
sum(g.fumbles_rec) as "FR"
from games g, players p 
where g.player_id = p.player_id 
and g.team =:team
and g."year" =:year
group by p.player_id, p."name", p."position", g."year", g.team 
having sum(g.passing_attempts) +
sum(g.rushing_attempts) +
sum(g.receiving_targets) +
sum(g.receiving_receptions) +
sum(g.defense_tackles)+
sum(g.defense_tackle_assists)+
sum(g.defense_interceptions) + 
sum(g.defense_safeties) +
sum(g.field_goal_attempts)+
sum(g.point_after_attempts)+
sum(g.punting_attempts) +
sum(g.kick_return_attempts) + 
sum(g.punt_return_attempts) <> 0
order by 
sum(g.passing_yards) desc, 
sum(g.passing_attempts) desc,
sum(g.rushing_yards) desc, 
sum(g.rushing_attempts) desc,
sum(g.receiving_yards) desc, 
sum(g.receiving_receptions) desc, 
sum(g.receiving_targets) desc,
sum(g.defense_tackles) desc, 
sum(g.defense_tackle_assists) desc,
sum(g.field_goal_attempts) desc,
sum(g.point_after_attempts) desc,
sum(g.punting_yards) desc,
sum(g.kick_return_yards) desc, 
sum(g.kick_return_attempts) desc,
sum(g.punt_return_yards), 
sum(g.punt_return_attempts) desc
