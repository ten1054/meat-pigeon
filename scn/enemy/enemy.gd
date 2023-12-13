extends CharacterBody2D


const SPEED = 100.0
var attacking = false
@onready var label = preload("res://scn/public/label.tscn")
@onready var Gold = preload("res://scn/public/gold/gold.tscn")
@export var health = 10
@export var damage = 5
@export var player:CharacterBody2D = null
var is_enter = true
func _ready():
	$weapons.visible = false
	$CollisionShape2D.disabled = true
	$hurtArea/CollisionShape2D.disabled = true
	$AttackArea/CollisionShape2D.disabled = true

func _physics_process(delta):
	if(health <= 0 or is_enter):
		$CollisionShape2D.disabled = true
		return
	if(!attacking):
		var newT =  transform.looking_at(player.position)
		$weapons/left.rotation = newT.get_rotation()
		$NavigationAgent2D.target_position = player.position
		if(not $NavigationAgent2D.is_navigation_finished()):
			var dir2 = to_local($NavigationAgent2D.get_next_path_position()).normalized()
			$NavigationAgent2D.set_velocity(dir2 * SPEED)
		if(velocity != Vector2.ZERO):
			$AnimationPlayer.play("run")
		else:
			$AnimationPlayer.play("idle")
		if(velocity.x < 0):
			$AnimatedSprite2D.flip_h = true
		elif velocity.x > 0:
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimationPlayer.play("idle")
		$NavigationAgent2D.set_velocity(Vector2.ZERO)


func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	velocity = safe_velocity
	move_and_slide()


func _on_attack_area_body_entered(body:CharacterBody2D):
	if(body.get_collision_layer_value(1) and !attacking):
		attacking = true
		$AttackArea.set_collision_mask_value(1,false)
		var dir = (player.position - position).normalized()
		var beforePos = $weapons/left.position
		var tween = get_tree().create_tween()
		tween.tween_property($weapons/left,"position",$weapons/left.position - dir * 20 ,0.3)
		tween.tween_property($weapons/left,"position",$weapons/left.position + dir * 70 ,0.1)
		tween.tween_property($weapons/left,"position",beforePos ,0.1)
		tween.tween_callback(end_attack)
		await get_tree().create_timer(0.3).timeout
		$weapons/left/Hitbox/CollisionShape2D.set_deferred("disabled",false)


func end_attack():
	$weapons/left/Hitbox/CollisionShape2D.set_deferred("disabled",true)
	await get_tree().create_timer(0.7).timeout
	attacking = false
	$AttackArea.set_collision_mask_value(1,true)


func _on_hitbox_body_entered(body):
	if(body.get_collision_layer_value(1)):
		var dir = (player.position - position).normalized()
		body.hurt(0,damage,dir)

func hurt(damage):
	health -= damage
	if(health <= 0):
		$NavigationAgent2D.set_velocity(Vector2.ZERO)
		$AnimationPlayer.play("die")
		await $AnimationPlayer.animation_finished
		create_gold()
	else:
		$AnimationPlayer2.play("hurt")
		var Lable = label.instantiate()
		Lable.value = damage
		Lable.position =  position
		add_child(Lable)

func create_gold():
	var gold = Gold.instantiate()
	gold.position = position
	var parent = get_node("/root/Main/Props")
	parent.add_child(gold)
	gold.owner = parent
	queue_free()


func enter_finish():
	$weapons.visible = true
	$CollisionShape2D.disabled = false
	$hurtArea/CollisionShape2D.disabled = false
	$AttackArea/CollisionShape2D.disabled = false
	is_enter = false
	remove_child($GreenEnter)
