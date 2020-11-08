-- INSTRUÇÃO SQL QUE MOSTRA A CARREIRA DO JOGADOR --

select 
g.player_id,
count(g.game_id) as "G",
-- Passing --
cast(sum(g.passing_completions) || '/' || sum(g.passing_attempts) as varchar(15)) as "C/A",
sum(g.passing_completions)/cast(nullif(sum(g.passing_attempts),0) as decimal(8,2))*100 as "Pa.Pct",
sum(g.passing_yards) as "Pa.Yds",
sum(g.passing_touchdowns) as "Pa.TD",
sum(g.passing_interceptions) as "Pa.Int",
avg(g.passing_rating) as "Rate",
sum(g.passing_sacks) as "Sckd",
-- Rushing --
sum(g.rushing_attempts) as "Rush",
sum(g.rushing_yards) as "Ru.Yds",
sum(g.rushing_yards)/cast(nullif(sum(g.rushing_attempts),0) as decimal(6,2)) as "Ru.Av",
sum(g.rushing_touchdowns) as "Ru.TD",
-- Receiving --
sum(g.receiving_targets) as "Tgt",
sum(g.receiving_receptions) as "Rec",
sum(g.receiving_yards) as "Re.Yds",
sum(g.receiving_yards)/cast(nullif(sum(g.receiving_receptions),0) as decimal(6,2)) as "Re.Av",
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
sum(g.punting_yards)/cast(nullif(sum(g.punting_attempts),0) as decimal(6,2)) as "Pu.Av",
sum(g.punting_blocked) as "Blckd",
-- Fumbles --
sum(g.fumbles) as "Fmb",
sum(g.fumbles_lost) as "Lost",
sum(g.fumbles_forced) as "FF",
sum(g.fumbles_rec) as "FR"
from games g where g.player_id =:player_id 
group by g.player_id
