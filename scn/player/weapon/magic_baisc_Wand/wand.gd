extends Node2D
@onready var attack_particles = preload("res://scn/public/attack_effect/fire_ball/attack_particles.tscn")
@onready var attack_wav = preload("res://scn/player/weapon/magic_baisc_Wand/attack.wav")

var is_cool = false
var current_screen = ""
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
		current_screen.add_child(particles)
		createMusic(attack_wav)
		await get_tree().create_timer(Global.player_state.attack_speed).timeout
		is_cool = false
	elif Input.is_action_pressed("attack") and !is_could_attack and !$error.playing:
		$error.play()

func createMusic(stream):
		var music_effect = AudioStreamPlayer2D.new()
		music_effect.stream = stream
		music_effect.autoplay = true
		music_effect.volume_db = 5
		add_child(music_effect)
		music_effect.finished.connect(func():music_effect.queue_free() )


