extends Node

# 改变最大生命值
func change_max_health(num):
	Global.player_state.max_health *= (1 + num)
	Global.player_state.health *= (1 + num)

##改变攻击力
func change_attack(num):
	Global.player_state.attack *= (1 + num)


#改变护甲
func change_armor(num):
	Global.player_state.armor *= (1 + num)


#改变攻速
func change_attack_speed(num):
	Global.player_state.attack_speed *= (1 + num)


#改变最大魔法值
func change_magic_max_value(num):
	Global.player_state.max_magic *= (1 + num)


#消灭怪物后恢复生命值和魔法值
func destory_monster_get_recover(num):
	Global.player_state.health *= (1 + num)
	Global.player_state.magic *= (1 + num)


#改变吸血
func change_vampirism_value(num):
	Global.player_state.vampirism_value *= (1 + num)


#改变生命值恢复
func change_health_recover(num):
	Global.player_state.health_restore_value *= (1 + num)


#改变魔法值恢复
func change_magic_recover(num):
	Global.player_state.magic_restore_value *= (1 + num)


#改变移动速度
func change_move_speed(num):
	Global.player_state.move_speed *= (1 + num)


#每有一点护甲，增加0.5攻击
func armor_to_attack():
	Global.player_state.attack += (Global.player_state.armor * 0.5)


var addition_list = [
	{
		"text":'最大生命值加10%',
		"value":0.1,
		"fun": [change_max_health,0.1]
	},
	{
		"text":'攻击力加10%',
		"value":0.1,
		"fun":[change_attack,0.1] 
	},
	{
		"text":'护甲加10%',
		"value":0.1,
		"fun":[change_armor,0.1]
	},
	{
		"text":'攻速加10%',
		"value":0.1,
		"fun":[change_attack_speed,0.1]
	},
	{
		"text":'最大魔法增加10%',
		"fun": [change_magic_max_value,0.1]
	},
	{
		"text":'增加每秒恢复10%耗蓝量',
		"fun": [change_magic_recover,0.1]
	},
	{
		"text":'消灭怪物后恢复5%生命值和魔法值',
		"fun": [destory_monster_get_recover,0.1]
	},
	{
		"text":'获得5%吸血',
		"fun": [change_vampirism_value,0.05]
	},
	{
		"text":'生命值恢复增加10%',
		"fun": [change_health_recover,0.1]
	},
	{
		"text":'移动速度增加10%',
		"fun": [change_move_speed,0.1]
	},
	{
		"text":'当前每有一点护甲，便增加0.5攻击',
		"fun": [armor_to_attack] 
	},
]


