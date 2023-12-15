extends CharacterBody2D


func _physics_process(delta):
	if(Input.is_action_pressed("up")):
		velocity.y = 0 - Global.player_state.move_speed
		$AnimationTree["parameters/conditions/run"] = true
		$AnimationTree["parameters/conditions/idle"] = false
	elif(Input.is_action_pressed("down")):
		velocity.y =  Global.player_state.move_speed
		$AnimationTree["parameters/conditions/run"] = true
		$AnimationTree["parameters/conditions/idle"] = false
	else:
		velocity.y = 0
	if(Input.is_action_pressed("left")):
		velocity.x = 0 - Global.player_state.move_speed
		$AnimatedSprite2D.flip_h = true
		$AnimationTree["parameters/conditions/run"] = true
		$AnimationTree["parameters/conditions/idle"] = false
	elif(Input.is_action_pressed("right")):
		velocity.x =  Global.player_state.move_speed
		$AnimatedSprite2D.flip_h = false
		$AnimationTree["parameters/conditions/run"] = true
		$AnimationTree["parameters/conditions/idle"] = false
	else:
		velocity.x = 0
	if(velocity == Vector2.ZERO):
		$AnimationTree["parameters/conditions/idle"] = true
		$AnimationTree["parameters/conditions/run"] = false
	recover(delta)
	move_and_slide()


func hurt(damage_type,damage_num,damage_dir):
	if(Global.player_state.invincible):
		return
	match damage_type:
		0:
			normal_hurt(damage_num)


func normal_hurt(damage_num):
	$player_color.play("hurt")
	$hurt.play()
	Global.player_state.invincible = true
	Global.player_state.health -= Global.calculate_damage(damage_num) 
	await get_tree().create_timer(0.6).timeout
	Global.player_state.invincible = false
	$player_color.stop()


func recover(delta):
	var new_health = Global.player_state.health + Global.player_state.health_restore_value * delta
	Global.player_state.health = new_health if new_health < Global.player_state.max_health else Global.player_state.max_health
	var new_magic = Global.player_state.magic + Global.player_state.magic_restore_value  * delta
	Global.player_state.magic = new_magic if new_magic < Global.player_state.max_magic else Global.player_state.max_magic


