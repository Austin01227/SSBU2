//Up Special for character0
var run = true;
var _phase = argument_count > 0 ? argument[0] : attack_phase;
//Timer
attack_frame=max(--attack_frame,0);
//Phases
if (run)
{
	switch(_phase)
	{
		case PHASE.start:
		{
			//Animation
			anim_frame = 0;
			anim_sprite = spr_uspec0;
			anim_speed = 0;
			
			parry_stun_time = 60;
			landing_lag = 15;
			set_speed(0, 0, false, false);
			audio_play_sound(snd_mario_s_up, 1, false);
			attack_frame = 4;
			return;
		}
		//Startup -> Active
		case 0:
		{
			//Animation
			if (attack_frame == 1)
				anim_frame = 1;
				
			if (attack_frame == 0)
			{
				//Animation
				anim_frame = 2;
				
				set_speed(4*facing, -18, false, false);
				attack_phase++;
				attack_frame = 8;
				var _hitbox = create_magnetbox(20, 0, 0.6, 0.6, 5, 4, 32, -72, 8, 1, HITBOX_SHAPE.circle, 0);
				set_hitbox_property(_hitbox, HITBOX_PROPERTY.hit_fx_style, HIT_FX.normal_weak);
				//set_invulnerable(INV.superarmor, 8);
			}
			break;
		}
		//Active -> Endlag
		case 1:
		{
			//Animation
			if (attack_frame == 6)
				anim_frame = 3;
			if (attack_frame == 3)
				anim_frame = 4;
			//Grab ledges
			if !stick_tilted(Lstick, DIR.down) && check_ledge_grab() return;
			//Drift while rising
			if (stick_tilted(Lstick,DIR.horizontal))
			{
				hsp += 1 * stick_get_value(Lstick,DIR.horizontal);
			}
			if (facing == 1)
			{
				hsp = clamp(hsp, 1, 4);
			}
			else
			{
				hsp = clamp(hsp, -4, -1);
			}
			//Looping hitboxes
			if (attack_frame % 2 == 0)
			{
				reset_hitbox_group(collided, 1);
				var _hitbox = create_magnetbox(10, -10, 0.6, 0.6, 1, 4, 32, -72, 8, 2, HITBOX_SHAPE.circle, 1);
				set_hitbox_property(_hitbox, HITBOX_PROPERTY.hit_fx_style, HIT_FX.normal_weak);
			}
			//Final hitbox
			if (attack_frame == 0)
			{
				//Animation
				anim_frame = 5;
				
				if (vsp < 0)
				{
					set_speed(-0.5*facing, 8, true, true);
				}
				attack_phase++;
				attack_frame = 15;
				var _hitbox = create_melee(10, -20, 0.4, 0.4, 3, 13.5, 0.3, 20, 75, 3, HITBOX_SHAPE.circle, 2);
				set_hitbox_property(_hitbox, HITBOX_PROPERTY.hit_fx_style, HIT_FX.normal_strong);
				set_hitbox_property(_hitbox, HITBOX_PROPERTY.hit_sfx, snd_hit_strong);
			}
			break;
		}
		//Finish
		case 2:
		{
			//Gravity
			friction_gravity(air_friction * 0.5, grav, max_fall_speed);
			//Grab ledges
			if (!stick_tilted(Lstick, DIR.down) && check_ledge_grab()) return;
			//Animation
			if (attack_frame == 8)
				anim_frame = 6;
			
			if (attack_frame == 0)
			{
				attack_stop(PLAYER_STATE.helpless);
			}
			break;
		}
	}
}

//Movement
move_();