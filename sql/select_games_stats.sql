-- INSTRUÇÃO SQL QUE MOSTRA AS ESTATÍSTICAS DO JOGO POR TIME--

select 
p."name" as "Player",
p."position" as "Pos",
g.team as "Team",
-- Passing --
cast(g.passing_completions || '/' || g.passing_attempts as varchar(15)) as "C/A",
g.passing_completions/cast(nullif(g.passing_attempts,0) as decimal(5,2))*100 as "Pa.Pct",
g.passing_yards as "Pa.Yds",
g.passing_touchdowns as "Pa.TD",
g.passing_interceptions as "Pa.Int",
g.passing_rating as "Rate",
g.passing_sacks as "Sckd",
-- Rushing --
g.rushing_attempts as "Rush",
g.rushing_yards as "Ru.Yds",
g.rushing_yards/cast(nullif(g.rushing_attempts,0) as decimal(5,2)) as "Ru.Av",
g.rushing_touchdowns as "Ru.TD",
-- Receiving --
g.receiving_targets as "Tgt",
g.receiving_receptions as "Rec",
g.receiving_yards as "Re.Yds",
g.receiving_yards/cast(nullif(g.receiving_receptions,0) as decimal(5,2)) as "Re.Av",
g.receiving_touchdowns as "Re.TD",
-- Defense --
g.defense_tackles+g.defense_tackle_assists as "Comb",
cast(g.defense_tackles || '/' || g.defense_tackle_assists as varchar(15)) as "T/A",
g.defense_sacks as "Scks",
defense_interceptions as "Int",
g.defense_interception_yards as "Int.Yds",
g.defense_interception_touchdowns as "Int.TD",
g.defense_safeties as "Sft",
-- Returning --
g.kick_return_attempts as "KR",
g.kick_return_yards as "KR.Yds",
g.kick_return_yards/cast(nullif(g.kick_return_attempts,0) as decimal(5,2)) as "KR.Av",
g.kick_return_touchdowns as "KR.TD",
g.punt_return_attempts as "PR",
g.punt_return_yards as "PR.Yds",
g.punt_return_yards/cast(nullif(g.punt_return_attempts,0) as decimal(5,2)) as "PR.Av",
g.punt_return_touchdowns as "PR.TD",
-- Kicking --
cast(g.field_goal_makes || '/' ||g.field_goal_attempts as varchar(15)) as "FM/FA",
g.field_goal_makes/cast(nullif(g.field_goal_attempts,0) as decimal(5,2))*100 as "FG.Pct",
cast(g.point_after_makes || '/' ||g.point_after_attempts as varchar(15)) as "XM/XA",
g.point_after_makes/cast(nullif(g.point_after_attempts,0) as decimal(5,2))*100 as "XP.Pct",
-- Punting --
g.punting_attempts as "Punts",
g.punting_yards as "Pu.Yds",
g.punting_yards/cast(nullif(g.punting_attempts,0) as decimal(5,2)) as "Pu.Av",
g.punting_blocked as "Blckd",
-- Fumbles --
g.fumbles as "Fmb",
g.fumbles_lost as "Lost",
g.fumbles_forced as "FF",
g.fumbles_rec as "FR"
from games g, players p where 
p.player_id=g.player_id and
g.game_id=:game_id and
g.team=:team
and g.passing_attempts +
g.rushing_attempts +
g.receiving_targets +
g.defense_tackles+
g.defense_tackle_assists+
g.defense_interceptions + 
g.defense_safeties +
g.field_goal_attempts+
g.point_after_attempts+
g.punting_attempts +
g.kick_return_attempts + 
g.punt_return_attempts +
g.fumbles_forced +
g.fumbles_rec <> 0
order by 
g.passing_yards desc, g.passing_attempts desc,
g.rushing_yards desc, g.rushing_attempts desc,
g.receiving_yards desc, g.receiving_receptions desc, g.receiving_targets desc,
g.defense_tackles desc, g.defense_tackle_assists desc,
g.field_goal_attempts desc,
g.point_after_attempts desc,
g.punting_yards desc,
g.kick_return_yards desc, g.kick_return_attempts desc,
g.punt_return_yards, g.punt_return_attempts desc


