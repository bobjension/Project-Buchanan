/obj/item/projectile/bullet/shotgun_slug
	name = "12g shotgun slug"
	damage = 35
	sharpness = SHARP_POINTY
	wound_bonus = 22
	bare_wound_bonus = 8

/obj/item/projectile/bullet/shotgun_slug/executioner
	name = "executioner slug" // admin only, can dismember limbs
	sharpness = SHARP_EDGED
	wound_bonus = 80

/obj/item/projectile/bullet/shotgun_slug/pulverizer
	name = "pulverizer slug" // admin only, can crush bones
	sharpness = SHARP_NONE
	wound_bonus = 80

/obj/item/projectile/bullet/shotgun_beanbag
	name = "beanbag slug"
	damage = 5
	stamina = 55
	wound_bonus = 0
	sharpness = SHARP_NONE

/obj/item/projectile/incendiary/flamethrower/robot
	name = "incendiary slug"
	damage = 20

/obj/item/projectile/bullet/incendiary/shotgun
	name = "incendiary slug"
	damage = 20

/obj/item/projectile/bullet/incendiary/shotgun/dragonsbreath
	name = "dragonsbreath pellet"
	damage = 10

/obj/item/projectile/incendiary/flamethrower
	name = "FIREEEEEEEEEE!!!!!"
	icon = 'icons/effects/fire.dmi'
	icon_state = "3"
	light_range = LIGHT_RANGE_FIRE
	light_color = LIGHT_COLOR_FIRE
	damage_type = BURN
	damage = 8
	range = 10

/obj/item/projectile/incendiary/flamethrower/on_hit(atom/target)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(4)
		M.IgniteMob()

/obj/item/projectile/bullet/shotgun_stunslug
	name = "stunslug"
	damage = 5
	stamina = 30
	stutter = 5
	jitter = 20
	range = 7
	icon_state = "spark"
	color = "#FFFF00"
	var/tase_duration = 50

/obj/item/projectile/bullet/shotgun_stunslug/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(!ismob(target) || blocked >= 100) //Fully blocked by mob or collided with dense object - burst into sparks!
		do_sparks(1, TRUE, src)
	if(iscarbon(target))
		var/mob/living/carbon/C = target
		SEND_SIGNAL(C, COMSIG_ADD_MOOD_EVENT, "tased", /datum/mood_event/tased)
		SEND_SIGNAL(C, COMSIG_LIVING_MINOR_SHOCK)
		C.IgniteMob()
		if(C.dna && C.dna.check_mutation(HULK))
			C.say(pick(";RAAAAAAAARGH!", ";HNNNNNNNNNGGGGGGH!", ";GWAAAAAAAARRRHHH!", "NNNNNNNNGGGGGGGGHH!", ";AAAAAAARRRGH!" ), forced = "hulk")
		else if(tase_duration && (C.status_flags & CANKNOCKDOWN) && !HAS_TRAIT(C, TRAIT_STUNIMMUNE) && !HAS_TRAIT(C, TRAIT_TASED_RESISTANCE))
			C.electrocute_act(15, src, 1, SHOCK_NOSTUN)
			C.apply_status_effect(STATUS_EFFECT_TASED_WEAK, tase_duration)

/obj/item/projectile/bullet/shotgun_meteorslug
	name = "meteorslug"
	icon = 'icons/obj/meteor.dmi'
	icon_state = "dust"
	damage = 20
	knockdown = 80
	hitsound = 'sound/effects/meteorimpact.ogg'

/obj/item/projectile/bullet/shotgun_meteorslug/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(ismovable(target))
		var/atom/movable/M = target
		var/atom/throw_target = get_edge_target_turf(M, get_dir(src, get_step_away(M, src)))
		M.safe_throw_at(throw_target, 3, 2)

/obj/item/projectile/bullet/shotgun_meteorslug/Initialize()
	. = ..()
	SpinAnimation()

/obj/item/projectile/bullet/shotgun_frag12
	name ="frag12 slug"
	damage = 25
	knockdown = 50

/obj/item/projectile/bullet/shotgun_frag12/on_hit(atom/target, blocked = FALSE)
	..()
	explosion(target, -1, 0, 1)
	return BULLET_ACT_HIT

/obj/item/projectile/bullet/pellet
	var/tile_dropoff = 0.45
	var/tile_dropoff_s = 1.25

/obj/item/projectile/bullet/pellet/shotgun_buckshot
	name = "buckshot pellet"
	damage = 9.5
	wound_bonus = 8
	bare_wound_bonus = 8
	wound_falloff_tile = -1
	is_reflectable = TRUE

/obj/item/projectile/bullet/pellet/shotgun_rubbershot
	name = "rubbershot pellet"
	damage = 2
	stamina = 20
	sharpness = SHARP_NONE
	embedding = null
	is_reflectable = TRUE

/obj/item/projectile/bullet/pellet/Range()
	..()
	if(damage > 0)
		damage -= tile_dropoff
	if(stamina > 0)
		stamina -= tile_dropoff_s
	if(damage < 0 && stamina < 0)
		qdel(src)

/obj/item/projectile/bullet/pellet/shotgun_improvised
	damage = 8
	wound_bonus = 0
	bare_wound_bonus = 8

/obj/item/projectile/bullet/pellet/trainshot
	damage = 13
	armour_penetration = 0.2
	sharpness = SHARP_NONE

/obj/item/projectile/bullet/pellet/trainshot/on_hit(atom/target)
	. = ..()
	if(ismovable(target) && prob(8))
		var/atom/movable/M = target
		var/atom/throw_target = get_edge_target_turf(M, get_dir(src, get_step_away(M, src)))
		M.safe_throw_at(throw_target, 2, 3)

// Mech Scattershots

/obj/item/projectile/bullet/scattershot
	damage = 28
	icon_state = "mech_autocannon"
	light_range = 1.5
	light_power = 0.3
	light_color = "#FF7F01"

/obj/item/projectile/bullet/seed
	damage = 6
	stamina = 1

/obj/item/projectile/bullet/pellet/shotgun_incapacitate
	name = "incapacitating pellet"
	damage = 1
	stamina = 6

/obj/item/projectile/bullet/pellet/magnum_buckshot
	name = "magnum buckshot pellet"
	damage = 9.5
	wound_bonus = 12
	bare_wound_bonus = 12

// BETA STUFF // Obsolete
/obj/item/projectile/bullet/pellet/shotgun_buckshot/test
	name = "buckshot pellet"
	damage = 0
