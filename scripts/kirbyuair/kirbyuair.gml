  
//Up Air for Kirby
var run = true;
var _phase = argument_count > 0 ? argument[0] : attack_phase;
//Timer
attack_frame=max(--attack_frame,0);
friction_gravity(air_friction,grav,max_fall_speed);
fastfall_attack_try();
allow_hitfall();
aerial_drift();
//Canceling
if run && cancel_ground_check() run = false;

//Phases
if (run)
{
	switch(_phase)
	{
		case PHASE.start:
		{
			//Animation
			anim_sprite = spr_kirby_uair;
			anim_speed = 0;
			anim_frame = 0;
		
			attack_frame = 13;
			set_speed(0, -1, true, true);
			landing_lag = 7;
			return;
		}
		//Active
		case 0:
		{
			if(attack_frame == 8)
				anim_frame = 1;
			if(attack_frame == 5)
			{
				anim_frame = 2;
				create_melee(22, 23, 0.45, 0.45, 8, 8, 0.5, 6, 55, 1, HITBOX_SHAPE.circle, 0);
			}
			if(attack_frame == 4)
				create_melee(30, 1, 0.45, 0.45, 8, 8, 0.5, 6, 55, 1, HITBOX_SHAPE.circle, 0);
			if(attack_frame == 3)
				create_melee(26, -16, 0.45, 0.45, 8, 8, 0.5, 6, 55, 1, HITBOX_SHAPE.circle, 0);
			if(attack_frame == 2)
			{
				anim_frame = 3;
				create_melee(7, -28, 0.45, 0.45, 8, 8, 0.5, 6, 55, 1, HITBOX_SHAPE.circle, 0);
			}
			if(attack_frame == 1)
				create_melee(-11, -28, 0.45, 0.45, 8, 8, 0.3, 6, 115, 1, HITBOX_SHAPE.circle, 0);
			if (attack_frame == 0)
			{
				attack_phase++;
				attack_frame = 6;
				anim_frame = 4;
				create_melee(-26, -18, 0.45, 0.45, 8, 8, 0.3, 6, 115, 1, HITBOX_SHAPE.circle, 0);
			}
			break;
		}
		//Endlag
		case 1:
		{
			if (attack_frame == 0)
			{
				attack_phase++;
				anim_frame = 5;
				attack_frame = 13;
			}
		}
		//Finish
		case 2:
		{
			if (attack_frame == 0)
			{
				set_state(PLAYER_STATE.aerial);
			}
			break;
		}
	}
}

//Movement
move_();