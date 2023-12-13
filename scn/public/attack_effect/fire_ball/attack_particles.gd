extends Area2D

@export var damage:int  = 0
@export var turn_dir:Vector2 = Vector2.ZERO
@export var attacker_layer = 1
@export var hurt_layer = []
@export var speed = 100
var is_disapper = false
# Called when the node enters the scene tree for the first time.
var v_dir = Vector2.ZERO
func _ready():
	look_at(turn_dir)
	v_dir = (turn_dir - position).normalized()
	set_collision_layer_value(attacker_layer,true)
	for i in hurt_layer:
		set_collision_mask_value(i,true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(!is_disapper):
		position += delta * v_dir * speed

func _on_body_entered(body):
	if( !is_disapper):
		print(body)
		for i in hurt_layer:
			if(body.get_collision_layer_value(i)):
				disapper()
				body.hurt and await body.hurt(damage)


func _on_timer_timeout():
	disapper()

func disapper():
	is_disapper = true
	$AnimatedSprite2D.visible = false
	$CollisionShape2D.disabled = true
	$GPUParticles2D.emitting = true


func _on_gpu_particles_2d_finished():
	queue_free()
