extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_button_down():
	Startup.setCurrentLevel("1")
	Startup.startLevel()
	#get_tree().change_scene_to_packed("root_scene")


func _on_button_2_button_down():
	Startup.setCurrentLevel("2")
	Startup.startLevel()


func _on_button_3_button_down():
	Startup.setCurrentLevel("0")
	Startup.startLevel()
