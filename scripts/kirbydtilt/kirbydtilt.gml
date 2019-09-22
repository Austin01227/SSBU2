//Down Tilt for Kirby
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
			anim_sprite = spr_kirby_dtilt;	//REPLACE
			anim_speed = 0;
			anim_frame = 0;
		
			attack_frame = 4;
			return;
		}
		//Startup -> Active
		case 0:
		{
			if(attack_frame > 0)
				anim_frame = 1;
			if (attack_frame == 0)
			{
				attack_phase++;
				anim_frame = 2;
				attack_frame = 6;
				create_melee(25, 23, 0.8, 0.3, 6, 4, 0.5, 5, 20, 3, HITBOX_SHAPE.circle, 0);
			}
			break;
		}
		//Active -> Endlag
		case 1:
		{
			if (attack_frame == 0)
			{
				attack_phase++;
				anim_frame = 1;
				attack_frame = 11;
			}
			break;
		}
		//Finish
		case 2:
		{
			if(attack_frame < 5)
				anim_frame = 0;
			if (attack_frame == 0)
			{
				attack_stop(PLAYER_STATE.crouching);
			}
			break;
		}
	}
}
//Movement
move_grounded_();