extends Node



# TODO death - choose to restart and go to menu?
# TODO goal of level - take you back to menu
# 
var root_scene = preload("res://scenes/root.tscn")
var level1 = preload("res://scenes/levels/level1.tscn")
var menu = preload("res://scenes/menu/menu.tscn")
var root_scene_instance: Node = null

var levels: Dictionary[String, PackedScene] = {
	"1": level1
}

var currentLevel: PackedScene = null

func setCurrentLevel(level):
	currentLevel = levels[level]

func startLevel():
	#var root = root_scene.instantiate()
	#root_scene_instance = root
	#get_tree().root.add_child(root)
	get_tree().change_scene_to_packed(root_scene)
	
func goal():
	get_tree().change_scene_to_packed(menu)

func death():
	print("should reload!")
	startLevel()
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
