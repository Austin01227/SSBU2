//Forward Smash for Kirby
var run = true;
var _phase = argument_count > 0 ? argument[0] : attack_phase;
//Timer
attack_frame=max(--attack_frame,0);
friction_gravity(slide_friction,grav,max_fall_speed);
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
			anim_sprite = spr_kirby_fsmash;
			anim_frame = 0;
			anim_speed = 0;
		
			charge = 0;
		
			attack_frame = 5;
			return;
		}
		//Charging
		case 0:
		{
			if (charge % 8 == 0)
			{
				if (anim_frame == 0)
				{
					anim_frame = 1;
				}
				else
				{
					anim_frame = 0;
				}
			}
			
			charge++;
			if ((charge >= smash_attack_max_charge || !button_hold(INPUT.smash, 1)) && attack_frame == 0)
			{
				attack_frame = 8;
				attack_phase++;
			}
			break;
		}
		//Sweetspot
		case 1:
		{
			if(attack_frame == 8)
				anim_frame = 2;
			if(attack_frame == 5)
				anim_frame = 3;
			if(attack_frame == 3)
				anim_frame = 4;
			if (attack_frame == 0)
			{
				set_speed(facing * 8, 0, false, false);
				attack_frame = 3;
				anim_frame = 5;
				var _damage = calculate_smash_damage(15, charge);	//Base damage
				create_melee(20, 7, 0.7, 0.5, _damage, 12, 0.5, 10, 45, 3, HITBOX_SHAPE.circle, 0, FLIPPER.sakurai);
				attack_phase++;
			}
			break;
		}
		//Sourspot
		case 2:
		{
			//if(attack_frame > 0)
			//{
				//set_speed(facing * -0.5, 0, true, false);
			//}
			if (attack_frame == 0)
			{
				set_speed(facing * -0.5, 0, true, false);
				attack_frame = 4;
				var _damage = calculate_smash_damage(11, charge);	//Base damage
				create_melee(20, 7, 0.7, 0.5, _damage, 8, 0.4, 6, 60, 4, HITBOX_SHAPE.circle, 0);
				attack_phase++;
			}
			break;
		}
		//Endlag
		case 3:
		{
			if (attack_frame == 0)
			{
				attack_frame = 28;
				attack_phase++;
			}
			break;
		}
		//Finish
		case 4:
		{
			if(attack_frame == 17)
				anim_frame = 6;
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