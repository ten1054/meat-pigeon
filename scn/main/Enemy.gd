extends Node2D

@onready var Skeleton_basic = preload("res://scn/enemy/skeleton/base/base.tscn")
var had_enemy_num = 0
var global_enemy_num = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	global_enemy_num = Global.game_difficulty.level * 20
	create_enemy()


func _on_timer_timeout():
	if(had_enemy_num >= global_enemy_num):
		print("结束了")
		return
	else:
		create_enemy()



func create_enemy():
	var a = int(floor(global_enemy_num * 0.3)) 
	var b = 4
	var number = randi() % a +  b
	var left_num = global_enemy_num - had_enemy_num
	if number >= left_num:
		number = left_num
	for i in number :
		var skeleton_basic = Skeleton_basic.instantiate()
		skeleton_basic.health = Global.game_difficulty.level * 20
		skeleton_basic.damage = Global.game_difficulty.level * 20
		skeleton_basic.player = $"../Player"
		skeleton_basic.position = $"../Player".position + Vector2(randi() % 400 + 100,randi() % 200 + 100)
		add_child(skeleton_basic)
		had_enemy_num += 1
		skeleton_basic.owner = $"."
		

