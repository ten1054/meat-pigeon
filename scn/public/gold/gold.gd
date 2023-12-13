extends CharacterBody2D


var player = null
var is_received = false
@onready var mp3 = preload("res://scn/public/gold/disapper.wav")
@onready var label = preload("res://scn/public/label.tscn")
# Called when the node enters the scene tree for the first time.

func _ready():
	$NavigationAgent2D.set_velocity(Vector2.ZERO)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(is_received):
		$NavigationAgent2D.target_position = player.position
		if(not $NavigationAgent2D.is_navigation_finished()):
			var dir = to_local($NavigationAgent2D.get_next_path_position()).normalized()
			$NavigationAgent2D.set_velocity(dir * 200)
		else:
			if(!find_child("music",false)):
				create_lab()
				create_music()
				disapper()

func _on_area_body_entered(body):
	if(body.get_collision_layer_value(1)):
		player = body
		is_received = true
		


func _on_disapper_timeout():
	if(!is_received):
		disapper()


func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	velocity = safe_velocity
	move_and_slide()

func disapper():
	$Area/CollisionShape2D.disabled = true
	var tween = get_tree().create_tween()
	tween.tween_property(self,"modulate:a",0,0.6)
	tween.tween_callback(func(): queue_free())

func create_lab():
	var number = randi() % (Global.game_difficulty.level * 10) + 1
	var Lable = label.instantiate()
	Lable.value = number
	Global.player_state.gold += number
	Lable.position = position
	add_child(Lable)


func create_music():
	var music = AudioStreamPlayer2D.new()
	music.name = "music"
	music.stream = mp3
	music.autoplay = true
	add_child(music)
	music.owner = $"."
