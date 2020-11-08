-- INSTRUÇÃO SQL QUE RETORNA AS ESTATÍSTICAS DO JOGADOR CONTRA O OPONENTE SELECIONADO--

select 
g."year" as "Year", 
g.team as "Tm",
g.game_id,
g.game_number as "No",
cast(
	g.team ||
	case when g.game_location = 'H'
	then ' Vs '
	else ' At ' end ||
	g.opponent as varchar(25)) as "Team vs Opp",
cast(
	case when g.game_won = true 
	then 'W'
	when g.game_won = false 
	then 'L'
	else 'T' end || ' ' ||
	g.player_team_score || '-' || g.opponent_score as varchar(25)
) as "Score",
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
from games g where g.player_id =:player_id and g.opponent=:opponent 
order by g."year"
