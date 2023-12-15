extends Node
var playe_state = {
	"gold":0,
	"max_health":100,
	"health":100,
	"health_restore_value":1,
	"max_magic":100,
	"magic":100,
	"magic_restore_value":5,
	"invincible":false,
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

var addition_list = [
	{
		"text":'普通攻击不再消耗魔法值但最大魔法值不能超过100',
		"fun":[attack_no_magic_but] 
	},
	{
		"text":'普通攻击耗蓝减少50%',
		"fun": [attack_magic_half,0.5]
	},
]


# 普通攻击不再消耗魔法值但最大魔法值不能超过100
func attack_no_magic_but():
	Global.player_state.attack_consume_magic = 0
	Global.player_state.is_not_improve_magic = true
	Global.player_state.max_magic = 100


#改变攻击消耗魔法值
func attack_magic_half(num):
	Global.player_state.attack_consume_magic *= (1 + num)
