//Up Smash for Kirby
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
			anim_sprite = spr_kirby_usmash;
			anim_frame = 0;
			anim_speed = 0;
		
			charge = 0;
		
			attack_frame = 6;
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
				anim_frame = 2;
				attack_frame = 6;
				attack_phase++;
			}
			break;
		}
		//Sweetspot
		case 1:
		{
			var _damage = calculate_smash_damage(15, charge);	//Base damage
			
			if (attack_frame == 2)
			{
				anim_frame = 3;
				create_melee(27, 20, 0.5, 0.5, _damage, 10, 1, 10, 75, 1, HITBOX_SHAPE.circle, 0);
			}
			if(attack_frame == 1)
			{
				create_melee(32, 5, 0.5, 0.5, _damage, 10, 1, 10, 75, 1, HITBOX_SHAPE.circle, 0);
			}
			if(attack_frame == 0)
			{
				attack_frame = 2;
				create_melee(25, -15, 0.5, 0.5, _damage, 10, 1, 10, 75, 1, HITBOX_SHAPE.circle, 0);
				attack_phase++;
			}
			break;
		}
		//Sourspot
		case 2:
		{
			if(attack_frame == 1)
			{
				var _damage = calculate_smash_damage(15, charge);
				create_melee(0, -33, 0.8, 0.4, _damage, 10, 1, 10, 75, 1, HITBOX_SHAPE.circle, 0);
			}
			if (attack_frame == 0)
			{
				anim_frame = 4;
				attack_frame = 3;
				var _damage = calculate_smash_damage(14, charge);	//Base damage
				create_melee(-25, -20, 0.4, 0.4, _damage, 12, 0.3, 9, 88, 1, HITBOX_SHAPE.circle, 0);
				attack_phase++;
			}
			break;
		}
		//Endlag
		case 3:
		{
			if (attack_frame == 0)
			{
				anim_frame = 5;
				attack_frame = 26;
				attack_phase++;
			}
			break;
		}
		//Finish
		case 4:
		{
			if(attack_frame == 20)
				anim_frame = 6;
			if(attack_frame == 15)
				anim_frame = 0;
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