extends Node
var game_difficulty = {
	"level":1
}
var player_state = {
	"max_health":100,
	"gold":1,
	"health":100,
	"health_restore_value":1,
	"max_magic":100,
	"magic":100,
	"magic_restore_value":10,
	"move_speed":100,
	"attack":20,
	"armor":60,
	"basic_armor":20,
	"attack_speed":0.5,
	"vampirism_value":0,
	"attack_track":1,
	"attack_consume_magic":10,
	"is_not_improve_magic":false
}

var addition_list= [
]

func calculate_damage(damage):
	var reduce_damage = 0
	var armor_differ = Global.player_state.armor -  20
	if(armor_differ <= 30 and armor_differ >= 0):
		reduce_damage  = damage * 0.2 + armor_differ * 0.01 * damage
	elif armor_differ > 30 and  armor_differ <= 100:
		reduce_damage = damage * 0.5 +  (armor_differ - 30 ) * 0.005 * damage
	elif armor_differ > 100:
		reduce_damage = damage * 0.85
	else:
		reduce_damage = damage * Global.player_state.armor * 0.01
	return damage - reduce_damage
