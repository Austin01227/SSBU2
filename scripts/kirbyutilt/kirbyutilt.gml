//Up Tilt for Kirby
var run = true;
var _phase = argument_count > 0 ? argument[0] : attack_phase;
//Timer
attack_frame=max(--attack_frame,0);
friction_gravity(ground_friction,grav,max_fall_speed);
//Canceling
if run && cancel_air_check() run = false;
//Phases
if (run)
{
	switch(_phase)
	{
		case PHASE.start:
		{
			//Animation
			anim_sprite = spr_kirby_utilt;
			anim_speed = 0;
			anim_frame = 0;
		
			attack_frame = 3;
			return;
		}
		//Early hit
		case 0:
		{
			if (attack_frame == 0)
			{
				attack_phase++;
				attack_frame = 5;
				create_melee(-30, 0, 0.5, 0.9, 5, 6, 0.5, 8, 100, 1, HITBOX_SHAPE.circle, 0);
			}
			break;
		}
		//Late hit
		case 1:
		{
			if(attack_frame == 4)
			{
				anim_frame = 1;
				create_melee(-18, -28, 0.4, 0.3, 5, 7, 0.5, 5, 88, 1, HITBOX_SHAPE.circle, 0);
			}
			if(attack_frame == 3)
			{
				anim_frame = 2;
				create_melee(0, -35, 0.6, 0.35, 5, 7, 0.5, 5, 88, 3, HITBOX_SHAPE.circle, 0);
			}
			if(attack_frame == 2)
				anim_frame = 3;
			if(attack_frame == 1)
				anim_frame = 4;
			if(attack_frame == 0)
			{
				attack_frame = 5;
				create_melee(20, -25, 0.4, 0.4, 5, 7, 0.5, 5, 88, 1, HITBOX_SHAPE.circle, 0);
				attack_phase++;
			}
		}
		//Active -> Endlag
		case 2:
		{
			if(attack_frame == 3)
				anim_frame = 2;
			if (attack_frame == 0)
			{
				attack_phase++;
				anim_frame = 0;
				attack_frame = 11;
			}
			break;
		}
		//Finish
		case 3:
		{
			if (attack_frame == 0)
			{
				attack_stop(PLAYER_STATE.idle);
			}
			break;
		}
	}
}
//Movement
move_grounded_();