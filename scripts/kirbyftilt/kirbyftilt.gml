//Forward Tilt for Kirby
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
			anim_sprite = spr_kirby_ftilt;
			anim_speed = 0;
			anim_frame = 0;
		
			attack_frame = 5;
			return;
		}
		//Startup -> Active
		case 0:
		{
			anim_frame = 1;
			if (attack_frame == 0)
			{
				attack_phase++;
				anim_frame = 2;
				attack_frame = 6;
				create_melee(20, 5, 1, 0.4, 7, 10, 0.4, 5, 90, 4, HITBOX_SHAPE.circle, 0, FLIPPER.sakurai);
			}
			break;
		}
		//Active -> Endlag
		case 1:
		{
			if (attack_frame == 0)
			{
				attack_phase++;
				anim_frame = 3;
				attack_frame = 13;
			}
			break;
		}
		//Finish
		case 2:
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