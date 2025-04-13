extends Node2D

@onready var v_box_container = $VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	
	Startup.loadGame()
	
	for key in Startup.levels.keys():
		print(key)
		var button = Button.new()
		button.text = str(key + " | best " + "%.2f" % Startup.high_score[key])
		button.name = str(key)  # Optional: name the button for identification
		button.pressed.connect(_on_button_pressed.bind(button))  # Connect with a bound parameter
		v_box_container.add_child(button)

func _on_button_pressed(button:Button):
	Startup.setCurrentLevel(button.name)
	Startup.startLevel()


func _on_check_button_toggled(toggled_on):
	if toggled_on:
		Startup.musicOn()
	else:
		Startup.musicOff()
