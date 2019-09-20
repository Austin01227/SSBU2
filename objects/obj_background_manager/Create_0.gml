/// @description DEFINE BACKGROUNDS
background = 
	[
		background_define(pkmn_stadium_background,0, 0, 1.5, 0, 0, 0, 0),
		background_define(pkmn_stadium_backpart, 0, 0, 1.5, 0, 0, 0, 0),
		[back_clear],
	];
half_room_width = room_width / 2;
half_room_height = room_height/ 2;

//Special Effects
background_clear_frame = 0;
background_clear_amount = 0;
background_clear_color = c_white;
uni_black = shader_get_uniform(shd_fade, "fade_amount");

//Layer fade
layer_script_begin("Assets", Layer_Fade_Begin);
layer_script_end("Assets", Layer_Fade_End);