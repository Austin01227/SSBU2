/// @description
//Reduced stun
base_hitlag = max(base_hitlag - 2, 0);
base_knockback = max(base_knockback - 0.1, 0);
fx_create(spr_mario_projectile_trail, 1, 0, 28, x, y, 2, irandom(360), "FX_Layer_Below");
//event_inherited();

/// @description
//Overlay Sprite
overlay_frame = (overlay_frame + overlay_speed) % sprite_get_number(overlay_sprite);
//Friction and Gravity
hsp = approach(hsp, 0, fric);
vsp += grav;
//Move
x += hsp;
y += vsp;
//Collide with walls
if (place_meeting(x, y, obj_solid))
{
	//move_bounce_all(true);
	instance_destroy();
	exit;
}
//Collisions

//Check for a collision with any hurtboxes
var _num = instance_place_list(x, y, obj_hurtbox, list, false);
if (_num > 0)
{
	//Loop through all hit players, an execute a script for each
	for(var i = 0; i < _num; i++)
	{
		Projectile_Collide(list[| i]);
	}
}
//Clear the DS
ds_list_clear(list);
if (destroy_on_hit && destroy)
{
	instance_destroy();
	exit;
}
//Timer
lifetime--;
if (lifetime < 0)
{
	instance_destroy();
	exit;
}