extends Node



# TODO death - choose to restart and go to menu?
# TODO - track time to complete level
# TODO - add another level
# TODO - more obstacles
# TODO - Some thing to end the level when below the current threshold?
# 
var root_scene = preload("res://scenes/root.tscn")
var level1 = preload("res://scenes/levels/level1.tscn")
var level2 = preload("res://scenes/levels/level_2.tscn")
var level0 = preload("res://scenes/levels/level_0.tscn")
var menu = preload("res://scenes/menu/menu.tscn")
var root_scene_instance: Node = null

var levels: Dictionary[String, PackedScene] = {
	"0": level0,
	"1": level1,
	"2": level2
}

var currentLevel: Node = null

func setCurrentLevel(level):

	if(currentLevel):
		currentLevel.queue_free()
		
	currentLevel = levels[level].instantiate()

func startLevel():

	get_tree().change_scene_to_packed(root_scene)
	print(get_tree().current_scene)
	
func goal():
	get_tree().change_scene_to_packed(menu)

func death():
	startLevel()
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
