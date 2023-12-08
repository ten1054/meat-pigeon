extends Node2D

@onready var wizard = preload("res://script/role/wizard.gd").new()
@onready var Add = preload("res://script/addition.gd").new()
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.player_state = wizard.playe_state
	Add.addition_list.append_array(wizard.addition_list)
	Global.addition_list =  Add.addition_list

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	get_tree().change_scene_to_file("res://scn/main/main.tscn")
