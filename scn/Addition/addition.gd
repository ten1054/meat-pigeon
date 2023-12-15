extends CanvasLayer

# Called when the node enters the scene tree for the first time.
@export var Addition = preload("res://scn/public/entry.tscn")
func _ready():
	get_tree().paused = true
	var random = []
	while random.size() < 3 :
		var num = randi() % Global.addition_list.size()
		if(!random.has(num)):
			random.append(num)
	print("随机",random)
	for i in 3:
		var add = Addition.instantiate()
		add.addition = Global.addition_list[random[i]]
		$HBoxContainer.add_child(add)

