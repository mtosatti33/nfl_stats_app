create  table public.games(
player_id 						int4,
"year"							int,
game_id							varchar(25),
"date"							varchar(16),
game_number						smallint,
"age"							smallint,
team							varchar(6),
game_location					varchar(2),
opponent						varchar(6),
game_won 						boolean,
player_team_score				smallint,
opponent_score					smallint,
passing_attempts				smallint,	
passing_completions				smallint,	
passing_yards					smallint,	
passing_rating					float,
passing_touchdowns				smallint,
passing_interceptions			smallint,
passing_sacks					smallint,
passing_sacks_yards_lost		smallint,
rushing_attempts				smallint,
rushing_yards					smallint,
rushing_touchdowns				smallint,
receiving_targets				smallint,
receiving_receptions			smallint,
receiving_yards					smallint,
receiving_touchdowns			smallint,
kick_return_attempts			smallint,
kick_return_yards				smallint,
kick_return_touchdowns			smallint,
punt_return_attempts			smallint,
punt_return_yards				smallint,
punt_return_touchdowns			smallint,
defense_sacks					float,
defense_tackles					smallint,
defense_tackle_assists			smallint,
defense_interceptions			smallint,
defense_interception_yards		smallint,
defense_interception_touchdowns	smallint,
defense_safeties				smallint,
point_after_attemps				smallint,
point_after_makes				smallint,
field_goal_attempts				smallint,
field_goal_makes				smallint,
punting_attempts				smallint,
punting_yards					smallint,
punting_blocked					smallint,
fumbles							smallint,
fumbles_lost					smallint,
fumbles_forced					smallint,
fumbles_rec						smallint
);

CREATE INDEX games_player_id_idx ON public.games (player_id,"year",game_id,team,opponent);
ALTER TABLE public.games ADD CONSTRAINT games_fk FOREIGN KEY (player_id) REFERENCES public.players(player_id);