extends MarginContainer

@export var addition = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	$Button.text = addition.text


func _on_button_pressed():
	if(addition.fun):
		addition.fun()
	
