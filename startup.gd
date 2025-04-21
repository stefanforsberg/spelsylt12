extends Node

enum NamedEnum {ROCK, PAPER, SCISSOR = -1}

var level_completed_scene = preload("res://scenes/levels/level_completed.tscn")
var root_scene = preload("res://scenes/root.tscn")
var level1 = preload("res://scenes/levels/level1.tscn")
var level2 = preload("res://scenes/levels/level_2.tscn")
var level3 = preload("res://scenes/levels/level_3.tscn")
var level4 = preload("res://scenes/levels/level_4.tscn")
var level5 = preload("res://scenes/levels/level_5.tscn")
var level6 = preload("res://scenes/levels/level_6.tscn")
var level0 = preload("res://scenes/levels/level_0.tscn")
var menu = preload("res://scenes/menu/menu.tscn")
var root_scene_instance: Node = null

var inventory: Dictionary[NamedEnum, int] = {
	NamedEnum.ROCK: 0,
	NamedEnum.PAPER: 0,
	NamedEnum.SCISSOR: 0,
}

signal inventory_updated()
signal player_hit(delta)

var levels: Dictionary[String, PackedScene] = {
	#"Level 0": level0,
	"Level 1": level1,
	"Level 2": level2,
	"Level 3": level3,
	"Level 4": level4,
	"Level 5": level5,
	"Level 6": level6,
}

var high_score: Dictionary[String, float] = {
	#"Level 0": 100.00,
	"Level 1": 100.00,
	"Level 2": 100.00,
	"Level 3": 100.00,
	"Level 4": 100.00,
	"Level 5": 100.00,
	"Level 6": 100.00,
}

var achievements: Dictionary[String, bool] = {
	"DropOfFaith": false,
	"NeverTouchGrass": false
}

var currentLevel: Node = null
var currentLevelName = null

var saveGameUri = "user://savegame_v3.save"

func loadGame():
	if not FileAccess.file_exists(saveGameUri):
		# No file to load
		return {}

	var file = FileAccess.open(saveGameUri, FileAccess.READ)
	if not file:
		return

	var loaded_data = file.get_var(true)
	
	if loaded_data.has("high_score"):
		for key in loaded_data["high_score"].keys():
			high_score[key] = loaded_data["high_score"][key]
	
	if loaded_data.has("achievements"):
		for key in loaded_data["achievements"].keys():
			achievements[key] = loaded_data["achievements"][key]
		
	print("loaded", loaded_data)
	
	file.close()
	
func saveGame():
	
	var saveData = {
		"high_score": high_score,
		"achievements": achievements
	}
	
	var file = FileAccess.open(saveGameUri, FileAccess.WRITE)
	file.store_var(saveData, true)
	file.close()
	
	print(saveData)
	

func setCurrentLevel(level):
	currentLevelName = level

	if(currentLevel):
		currentLevel.queue_free()
		
	currentLevel = levels[level].instantiate()

func startLevel():
	get_tree().call_deferred("change_scene_to_packed", root_scene)
	
func goal():
	var achievement_text = ""
	if currentLevelName == "Level 1" and not currentLevel.touched_grass:
		achievement("NeverTouchGrass")
		achievement_text = "You unlocked \"Never touch grass\" achievement!"
		
	if currentLevelName == "Level 5" and currentLevel.drop_of_faith:
		achievement("DropOfFaith")	
		achievement_text = "You unlocked \"Drop of faith\" achievement!"
				
	var current_time = get_tree().current_scene.elapsed_time
	
	var timeText = "Time: %.2f |" % current_time
	timeText += " best %.2f" % high_score[currentLevelName]
	timeText += " (%s" % ("+" if current_time > high_score[currentLevelName] else "")
	timeText += " %.2f)" % (current_time-high_score[currentLevelName])
	
	if current_time < high_score[currentLevelName]:
		high_score[currentLevelName] = current_time
	
	saveGame()
	
	showEndOfLevel("You completed %s" % currentLevelName, timeText, achievement_text)

func death():
	var current_time = get_tree().current_scene.elapsed_time
	var timeText = "Time of death: %.2f" % current_time
	timeText += " | best %.2f" % high_score[currentLevelName]
	showEndOfLevel("You failed %s" % currentLevelName, timeText)

func showEndOfLevel(level_completed_text, level_time_text, achievement_text = ""):
	var new_scene = level_completed_scene.instantiate()
	
	var old = get_tree().current_scene
	old.queue_free()
	get_tree().root.add_child(new_scene)
	get_tree().current_scene = new_scene
	new_scene.setTexts(level_completed_text, level_time_text, achievement_text)

func restartLevel():
	setCurrentLevel(currentLevelName)
	startLevel()
	
func goToMenu():
	get_tree().call_deferred("change_scene_to_packed", menu)
	
func updateInventory(type: NamedEnum, delta):
	inventory[type] += delta
	inventory_updated.emit()

func musicOff():
	var asp: AudioStreamPlayer = GlobalAudio.get_node("AudioStreamPlayer")
	asp.stop()
	
func musicOn():
	var asp: AudioStreamPlayer = GlobalAudio.get_node("AudioStreamPlayer")
	asp.play()
	
func achievement(name):
	achievements[name] = true
