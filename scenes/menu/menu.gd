extends Node2D

@onready var v_box_container = $VBoxContainer
@onready var bg: Sprite2D = $Bg
@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var achievements: RichTextLabel = $Achievements

# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = create_tween()
	# Loop infinitely (pass -1) so it never stops
	tween.set_loops(-1)
	# Tween scale to 2× over 2 seconds, with smooth in‑out easing
	tween.tween_property(bg, "scale", Vector2(1.2, 1.5), 20.0) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_IN_OUT)
	# Then tween scale back to 1× over 2 seconds
	tween.tween_property(bg, "scale", Vector2(1.2, 1.5), 20.0) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_IN_OUT)
	
	Startup.loadGame()
	
	for key in Startup.levels.keys():
		var button = Button.new()
		button.custom_minimum_size = Vector2(300, 50)
		
		button.text = str(key + " | best " + "%.2f" % Startup.high_score[key])
		button.name = str(key)  # Optional: name the button for identification
		button.pressed.connect(_on_button_pressed.bind(button))  # Connect with a bound parameter
		v_box_container.add_child(button)
	
	var achievementsTotal = 0
	var achievementsUnlocked = 0
	for value in Startup.achievements.values():	
		achievementsTotal+=1
		if value:
			achievementsUnlocked += 1
	
	var achievementsText = "Achievements: %s/%s" % [str(achievementsUnlocked), str(achievementsTotal)]
	achievements.text = "[rainbow freq=1.0 sat=0.3 val=0.8 speed=0.4]%s[/rainbow]" % achievementsText
	print(Startup.achievements.keys().size())

func _on_button_pressed(button:Button):
	Startup.setCurrentLevel(button.name)
	Startup.startLevel()


func _on_check_button_toggled(toggled_on):
	if toggled_on:
		Startup.musicOn()
	else:
		Startup.musicOff()


func _on_button_button_up() -> void:
	canvas_layer.visible = true


func _on_close_button_up() -> void:
	canvas_layer.visible = false
