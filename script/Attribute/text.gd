extends MarginContainer

@export var addition = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	$PanelContainer/Label.text = addition.text


func _on_panel_container_mouse_entered():
	$hover.play()


func _on_panel_container_gui_input(event:InputEvent):
	if(event.is_action_pressed("select")):
		if(addition.fun):
			if(addition.fun.size() >= 2):
				addition.fun[0].call(addition.fun[1])
			else:
				addition.fun[0].call()
			$select.play()
			$AnimationPlayer.play("disappear")
			await $AnimationPlayer.animation_finished
			get_tree().paused = false
			get_node('/root/Main/AdditionLayer').queue_free()
		
