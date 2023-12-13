extends Node2D
@onready var attack_particles = preload("res://scn/public/attack_effect/fire_ball/attack_particles.tscn")
var is_cool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	look_at(get_global_mouse_position())
	var is_could_attack = Global.player_state.magic -  Global.player_state.attack_consume_magic >= 0
	if(Input.is_action_pressed("attack") and !is_cool and is_could_attack):
		is_cool = true
		Global.player_state.magic -= Global.player_state.attack_consume_magic
		var particles = attack_particles.instantiate()
		particles.damage = Global.player_state.attack
		particles.turn_dir = get_global_mouse_position()
		particles.attacker_layer = 6
		particles.hurt_layer = [5]
		particles.position = $Marker.global_position
		get_node("/root/Main").add_child(particles)
		await get_tree().create_timer(Global.player_state.attack_speed).timeout
		is_cool = false
