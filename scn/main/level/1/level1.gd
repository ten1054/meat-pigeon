extends Node2D
@export var player:CharacterBody2D = null
@onready var Skeleton_basic = preload("res://scn/enemy/skeleton/base/base.tscn")
@onready var Portal = preload("res://scn/public/enter_effect/location_transmission.tscn")

var had_enemy_num = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.game_difficulty.monster_num = Global.game_difficulty.level * 20
	get_node("Player/weapon/wand").current_screen = $"."
	create_enemy()


func _on_timer_timeout():
	if(Global.game_difficulty.monster_num == 0):
		var portal = Portal.instantiate()
		portal.value = "安全屋"
		portal.scn = "res://scn/save_house/save_house.tscn"
		portal.position = player.position
		portal.callback = [nextLevel]
		add_child(portal)
		$Enemys/Timer.stop()
	elif(had_enemy_num < Global.game_difficulty.level * 20):
		create_enemy()


func create_enemy():
	var a = int(floor(Global.game_difficulty.monster_num * 0.3)) 
	var b = 4
	var number = randi() % a +  b
	var left_num = Global.game_difficulty.level * 20 - had_enemy_num
	if number >= left_num:
		number = left_num
	for i in number :
		var skeleton_basic = Skeleton_basic.instantiate()
		skeleton_basic.health = Global.game_difficulty.level * 20
		skeleton_basic.damage = Global.game_difficulty.level * 20
		skeleton_basic.player = player
		skeleton_basic.position = get_random_pos()
		add_child(skeleton_basic)
		had_enemy_num += 1
		skeleton_basic.owner = $"."


func get_random_pos():
	var tilemap = $Map.get_node("TileMap") as TileMap
	var pos_list = tilemap.get_used_cells(0)
	var num = randi() % len(pos_list)
	return tilemap.map_to_local(pos_list[num])


func nextLevel():
	Global.game_difficulty.level += 1
