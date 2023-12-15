extends Node2D

signal enter
@export var value = "下一层"
@export var scn = "res://scn/main/main.tscn"
@export var callback = []

# Called when the node enters the scene tree for the first time.
var show = true
func _ready():
	$Area2D/Label.text = value

func _process(delta):
	if(Input.is_action_just_pressed("interaction") and show):
		callback and callback[0].call()
		get_tree().change_scene_to_file(scn)


func _on_area_2d_body_entered(body):
	if(body.get_collision_layer_value(1)):
		$Area2D/AnimationPlayer.play("enter")
		show = true


func _on_area_2d_body_exited(body):
	if(body.get_collision_layer_value(1)):
		$Area2D/AnimationPlayer.play("leave")
		show = false
