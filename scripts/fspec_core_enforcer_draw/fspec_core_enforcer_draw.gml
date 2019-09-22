//Core enforcer
if (attack_phase == 3 && attack_frame < 40)
	{
	var _frame = round((60 - attack_frame) / 5);
	var _col = palette_get_color(palette, 1);
	var _ang = 30 * facing;
	draw_sprite_ext
		(
		spr_nspec_core_enforcer_laser_rough, 
		_frame, 
		x + (32 * facing), 
		y - 20, 
		facing, 
		1, 
		_ang, 
		_col, 
		1
		);
	draw_sprite_ext
		(
		spr_nspec_core_enforcer_laser_repeat, 
		_frame, 
		x + (32 + lengthdir_x(266, 30)) * facing,
		y - 20 + lengthdir_y(266, 30),
		5 * facing,
		1,
		_ang,
		_col,
		1,
		);
	}