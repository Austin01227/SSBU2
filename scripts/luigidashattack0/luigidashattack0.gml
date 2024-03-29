//Dash Attack for character0
var run = true;
var _phase = argument_count > 0 ? argument[0] : attack_phase;
//Timer
attack_frame=max(--attack_frame,0);
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
			anim_sprite = spr_luigidashattack0;
			anim_speed = 0;
			anim_frame = 0;

			attack_frame = 12;
			return;
		}
		//Startup
		case 0:
		{
			//Animation
			if (attack_frame == 8)
				anim_frame = 1;
			if (attack_frame == 6)
				anim_frame = 2;
			if (attack_frame == 4)
				anim_frame = 3;
			if (attack_frame == 2)
				anim_frame = 4;
			if (attack_frame == 0)
			{
				//Animation
				anim_frame = 5;

				attack_phase++;
				attack_frame = 24;
			}
			break;
		}
		//Active
		case 1:
		{
			//Animation
			if (attack_frame % 3 == 0)
				anim_frame++;
			if (anim_frame > 6)
				anim_frame = 4;

			//Speed
			set_speed(sign(facing)*4, 0, false, false);

			//Hitbox - every 4 frames
			if (attack_frame % 4 == 0 && attack_frame != 0)
			{
				//Reset the group, so it can hit multiple times despite being in the same hitbox group
				reset_hitbox_group(collided, 0);
				create_magnetbox(20, 0, 0.7, 0.3, 1, 4, 32, -5, 15, 2, HITBOX_SHAPE.circle, 0);
			}
			if (attack_frame == 0)
			{
				//Animation
				anim_frame = 14;

				attack_phase++;
				attack_frame = 16;
			}
			break;
		}
		//Final hit
		case 2:
		{
			//Friction
			friction_gravity(0.7);

			//Animation
			if (attack_frame == 11)
				anim_frame = 9;

			if (attack_frame == 8)
			{
				//Animation
				anim_frame = 10;
			}

			if (attack_frame = 8)
			{
				anim_frame = 11;
				create_melee(30, 0, 0.9, 0.45, 6, 10, 0.6, 8, 45, 4, HITBOX_SHAPE.circle, 1);

				attack_phase++;
				attack_frame = attack_has_hit() ? 5 : 14;
			}

			break;
		}
		//Finish
		case 3:
		{
			if(attack_frame == 9)
				anim_frame = 12;
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