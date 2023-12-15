extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$State.get_node("floor").text = "安全屋"
	$State.get_node("monster_num").visible = false
	get_node("Player/weapon/wand").current_screen = $"."
	get_node("Player/PointLight2D").enabled = false
	$location_transmission.value="前往下一关"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
