//Down Smash for Kirby
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
			anim_sprite = spr_kirby_dsmash;
			anim_frame = 0;
			anim_speed = 0;
		
			charge = 0;
		
			attack_frame = 7;
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
				attack_frame = 3;
				anim_frame = 2;
				attack_phase++;
			}
			break;
		}
		//Sweetspot
		case 1:
		{
			if (attack_frame == 0)
			{
				attack_frame = 5;
				anim_frame = 3;
				var _damage = calculate_smash_damage(15);	//Base damage
				create_melee(0, 25, 1.5, 0.5, _damage, 8, 0.5, 10, 29, 5, HITBOX_SHAPE.circle, 0, FLIPPER.from_player_center_horizontal);
				attack_phase++;
			}
			break;
		}
		//Sourspot
		case 2:
		{
			if(attack_frame == 2)
				anim_frame = 4;
			if (attack_frame == 0)
			{
				attack_frame = 8;
				anim_frame = 5;
				var _damage = calculate_smash_damage(10);	//Base damage
				create_melee(0, 25, 1.3, 0.4, _damage, 7, 0.5, 9, 29, 8, HITBOX_SHAPE.circle, 0, FLIPPER.from_player_center_horizontal);
				attack_phase++;
			}
			break;
		}
		//Endlag
		case 3:
		{
			if(attack_frame = 4)
				anim_frame = 6;
			if (attack_frame == 0)
			{
				anim_frame = 3;
				attack_frame = 27;	//Endlag
				attack_phase++;
			}
			break;
		}
		//Finish
		case 4:
		{
			if(attack_frame == 20)
			{
				anim_sprite = spr_kirby_crouch;
				anim_frame = 0;
			}
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