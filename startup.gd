extends Node

enum NamedEnum {ROCK, PAPER, SCISSOR = -1}

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

var inventory: Dictionary[NamedEnum, int] = {
	NamedEnum.ROCK: 0,
	NamedEnum.PAPER: 0,
	NamedEnum.SCISSOR: 0,
}

signal inventory_updated()
signal player_hit()

var levels: Dictionary[String, PackedScene] = {
	"Level 0": level0,
	"Level 1": level1,
	"Level 2": level2
}

var high_score: Dictionary[String, float] = {
	"Level 0": 100.00,
	"Level 1": 100.00,
	"Level 2": 100.00
}




var currentLevel: Node = null
var currentLevelName = null

var saveGameUri = "user://savegame.save"

func loadGame():
	if not FileAccess.file_exists(saveGameUri):
		# No file to load
		return {}

	var file = FileAccess.open(saveGameUri, FileAccess.READ)
	if not file:
		return

	var loaded_data = file.get_var(true)
	
	high_score = loaded_data["high_score"]
	
	print("loaded", loaded_data)
	
	file.close()
	
func saveGame():
	
	var saveData = {
		"high_score": high_score
	}
	
	var file = FileAccess.open(saveGameUri, FileAccess.WRITE)
	file.store_var(saveData, true)
	file.close()
	

func setCurrentLevel(level):
	currentLevelName = level

	if(currentLevel):
		currentLevel.queue_free()
		
	currentLevel = levels[level].instantiate()

func startLevel():
	get_tree().call_deferred("change_scene_to_packed", root_scene)
	await get_tree().process_frame

	
func goal():
	var current_time = get_tree().current_scene.elapsed_time
	if current_time < high_score[currentLevelName]:
		high_score[currentLevelName] = current_time
		print("NEW HIGHSCORE", get_tree().current_scene.elapsed_time)
		saveGame()
	get_tree().call_deferred("change_scene_to_packed", menu)

func death():
	setCurrentLevel(currentLevelName)
	startLevel()
	
func updateInventory(type: NamedEnum, delta):
	inventory[type] += delta
	inventory_updated.emit()

func musicOff():
	var asp: AudioStreamPlayer = GlobalAudio.get_node("AudioStreamPlayer")
	asp.stop()
	
func musicOn():
	var asp: AudioStreamPlayer = GlobalAudio.get_node("AudioStreamPlayer")
	asp.play()
