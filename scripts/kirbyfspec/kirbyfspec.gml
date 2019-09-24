//Side Special for Kirby
var run = true;
var _phase = argument_count > 0 ? argument[0] : attack_phase;
//Timer
attack_frame = max(--attack_frame, 0);
if (on_ground())
{
	friction_gravity(ground_friction);
}
else
{
	friction_gravity(air_friction * 0.5, grav, max_fall_speed);
}
aerial_drift();
//Phases
if (run)
{
	switch(_phase)
	{
		case PHASE.start:
		{
			//Animation
			anim_sprite = spr_kirby_fspec_ground;
			anim_speed = 0;
			anim_frame = 2;
			charge = 0;
			
			attack_frame = 6;
			return;
		}
		//Ground/Air
		case 0:
		{
			if(on_ground() && attack_frame == 3)
				anim_frame = 1;
			if(attack_frame == 0)
			{
				if(on_ground())
				{
					anim_frame = 0;
					attack_frame = 8;
					attack_phase++;
				}
				else if(!on_ground())
				{
					anim_sprite = spr_kirby_fspec_air;
					anim_frame = 0;
					create_melee(-52, 5, 0.6, 0.6, 5, 6, 0.4, 10, 45, 2, HITBOX_SHAPE.circle, 0, FLIPPER.sakurai);
					attack_frame = 32;
					attack_phase = 2;
				}
			}
			break;
		}
		//Charge
		case 1:
		{
			if(attack_phase == 1)
				set_speed(stick_get_value(Lstick, DIR.horizontal) * 2, 0, false, true);
			charge++;
			if (!button_hold(INPUT.special, 1))
			{
				attack_frame = 10;
				attack_phase = 3;
			}
			break;
		}
		//Aerial Swing
		case 2:
		{
			if(on_ground())
			{
				set_speed(0, 0, false, false);
				attack_frame = attack_has_hit() ? 12:15;
				attack_phase = 5;
			}
			
			if(attack_frame == 26)
			{
				anim_frame = 1;
				create_melee(-40, -40, 0.6, 0.6, 5, 6, 0.4, 10, 45, 2, HITBOX_SHAPE.circle, 0, FLIPPER.sakurai);
			}
			if(attack_frame == 24)
			{
				anim_frame = 2;
				create_melee(-5, -52, 0.6, 0.6, 5, 6, 0.4, 10, 45, 2, HITBOX_SHAPE.circle, 0, FLIPPER.sakurai);
			}
			if(attack_frame == 22)
			{
				anim_frame = 3;
				create_melee(40, -40, 0.6, 0.6, 5, 6, 0.4, 10, 45, 2, HITBOX_SHAPE.circle, 0, FLIPPER.sakurai);
			}
			if(attack_frame == 20)
			{
				anim_frame = 4;
				create_melee(52, -5, 0.6, 0.6, 5, 6, 0.4, 10, 45, 2, HITBOX_SHAPE.circle, 0, FLIPPER.sakurai);
			}
			if(attack_frame == 18)
			{
				anim_frame = 5;
				create_melee(40, 40, 0.6, 0.6, 5, 6, 0.4, 10, 45, 2, HITBOX_SHAPE.circle, 0, FLIPPER.sakurai);
			}
			if(attack_frame == 16)
			{
				anim_frame = 6;
				create_melee(5, 52, 0.6, 0.6, 5, 6, 0.4, 10, 45, 2, HITBOX_SHAPE.circle, 0, FLIPPER.sakurai);
			}
			if(attack_frame == 14)
			{
				anim_frame = 7;
				create_melee(-40, 40, 0.6, 0.6, 5, 6, 0.4, 10, 45, 2, HITBOX_SHAPE.circle, 0, FLIPPER.sakurai);
			}
			if(attack_frame == 12)
			{
				anim_frame = 0;
				create_melee(-52, 5, 0.6, 0.6, 5, 6, 0.4, 10, 45, 2, HITBOX_SHAPE.circle, 0, FLIPPER.sakurai);
			}
			if(attack_frame == 10)
			{
				anim_frame = 1;
				create_melee(-40, -40, 0.6, 0.6, 5, 6, 0.4, 10, 45, 2, HITBOX_SHAPE.circle, 0, FLIPPER.sakurai);
			}
			if(attack_frame == 8)
			{
				anim_frame = 2;
				create_melee(-5, -52, 0.6, 0.6, 5, 6, 0.4, 10, 45, 2, HITBOX_SHAPE.circle, 0, FLIPPER.sakurai);
			}
			if(attack_frame == 4)
			{
				anim_frame = 3;
				create_melee(40, -40, 0.6, 0.6, 5, 6, 0.4, 10, 45, 2, HITBOX_SHAPE.circle, 0, FLIPPER.sakurai);
			}
			if(attack_frame == 0)
			{
				anim_frame = 4;
				create_melee(52, -5, 0.6, 0.6, 5, 6, 0.4, 10, 45, 2, HITBOX_SHAPE.circle, 0, FLIPPER.sakurai);
				attack_phase = 4;
				attack_frame = 40;
			}
			break;
		}
		//Grounded Swing
		case 3:
		{
			if(charge > 180)
				charge = 180;
				
			if(attack_frame == 8)
				anim_frame = 1;
			if(attack_frame == 5)
				anim_frame = 2;
			if(attack_frame == 2)
			{
				anim_frame = 3;
				var _damage = calculate_smash_damage(15, charge, 180, 1);
				var _hitbox = create_melee(35, 20, 0.4, 0.4, _damage, 13, 0.5, 15, 50, 3, HITBOX_SHAPE.circle, 0);
			}
			if(attack_frame == 1)
			{
				anim_frame = 4;
				var _damage = calculate_smash_damage(15, charge, 180, 1);
				var _hitbox = create_melee(57, 0, 0.8, 0.8, _damage, 13, 0.5, 15, 50, 5, HITBOX_SHAPE.circle, 0);
			}
			if(attack_frame == 0)
			{
				anim_frame = 5;
				var _damage = calculate_smash_damage(15, charge, 180, 1);
				var _hitbox = create_melee(35, -35, 0.7, 0.7, _damage, 13, 0.5, 15, 50, 4, HITBOX_SHAPE.circle, 0);
				
				attack_frame = 30;
				attack_phase = 5;
			}
			break;
		}
		//Aerial Endlag
		case 4:
		{
			if(attack_frame == 35)
			{
				anim_sprite = spr_kirby_fspec_ground;
				anim_frame = 4;
			}
			if(attack_frame == 30)
				anim_frame = 3;
			if(attack_frame == 25)
				anim_frame = 2;
			if(attack_frame == 20)
				anim_frame = 1;
			if(attack_frame == 15)
				anim_frame = 0;
			if(attack_frame == 10)
			{
				anim_sprite = spr_kirby_fall;
				anim_frame = 0;
			}
			
			if(on_ground())
			{
				attack_phase++;
				attack_frame = 15;
			}
			if(attack_frame == 0)
			{
				attack_frame = 5;
				attack_phase++;
			}
			break;
		}
		//Finish
		case 5:
		{
			if(on_ground())
			{
				anim_sprite = spr_kirby_fspec_ground;
				if(attack_frame != 0)
					set_speed(0, 0, false, false);
				if(attack_frame == 15)
					anim_frame = 0;
				if(attack_frame == 10)
					anim_frame = 1;
				if(attack_frame == 0)
					attack_stop(PLAYER_STATE.idle);
			}
			
			if(attack_frame == 0 && !on_ground())
			{
				attack_stop(PLAYER_STATE.aerial);
			}
			break;
		}
	}
}

//Movement
move_();