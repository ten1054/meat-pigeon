extends CharacterBody2D

const SPEED = 500.0

func _physics_process(delta):
	if(Input.is_action_pressed("up")):
		velocity.y = 0 - SPEED
		$AnimationTree["parameters/conditions/run"] = true
		$AnimationTree["parameters/conditions/idle"] = false
	elif(Input.is_action_pressed("down")):
		velocity.y =  SPEED
		$AnimationTree["parameters/conditions/run"] = true
		$AnimationTree["parameters/conditions/idle"] = false
	else:
		velocity.y = 0
	if(Input.is_action_pressed("left")):
		velocity.x = 0 - SPEED
		$AnimatedSprite2D.flip_h = true
		$AnimationTree["parameters/conditions/run"] = true
		$AnimationTree["parameters/conditions/idle"] = false
	elif(Input.is_action_pressed("right")):
		velocity.x =  SPEED
		$AnimatedSprite2D.flip_h = false
		$AnimationTree["parameters/conditions/run"] = true
		$AnimationTree["parameters/conditions/idle"] = false
	else:
		velocity.x = 0
	if(velocity == Vector2.ZERO):
		$AnimationTree["parameters/conditions/idle"] = true
		$AnimationTree["parameters/conditions/run"] = false
	move_and_slide()
