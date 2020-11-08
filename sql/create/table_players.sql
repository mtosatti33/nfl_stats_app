create table public.players(
	player_id 			int,
	name				varchar(75),
	position 			varchar(15),
	height 				varchar(5),
	height_meters 		int,
	weight 				smallint,
	weight_kilograms 	smallint,
	current_team 		varchar(75),
	birth_date 			varchar(16),
	birth_place 		varchar(75),
	death_date 			varchar(16),	
	college 			varchar(75),
	high_school 		varchar(75),
	draft_team 			varchar(75),
	draft_round 		smallint,
	draft_position 		smallint,
	draft_year 			int,
	current_salary 		float,
	hof_induction_year 	int
)

ALTER TABLE public.players ADD CONSTRAINT players_pk PRIMARY KEY (player_id);
CREATE INDEX players_player_id_idx ON public.players (player_id,name,"position",college);