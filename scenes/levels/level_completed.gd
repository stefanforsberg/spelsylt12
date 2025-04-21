extends Node2D
@onready var bg: Sprite2D = $Bg
@onready var level_completed: Label = $LevelCompleted
@onready var level_time: Label = $LevelTime
@onready var achievement: RichTextLabel = $Achievement

func _ready() -> void:
	var tween = create_tween()
	# Loop infinitely (pass -1) so it never stops
	tween.set_loops(-1)
	# Tween scale to 2× over 2 seconds, with smooth in‑out easing
	tween.tween_property(bg, "scale", Vector2(2, 2), 20.0) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_IN_OUT)
	# Then tween scale back to 1× over 2 seconds
	tween.tween_property(bg, "scale", Vector2(1, 1), 20.0) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_IN_OUT)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("rock"):
		Startup.restartLevel()
		
	if Input.is_action_just_pressed("paper"):
		Startup.goToMenu()

func setTexts(level_complete_text, level_time_text, achievement_text = ""):
	level_completed.text = level_complete_text
	level_time.text = level_time_text
	
	if achievement_text.length() > 0:
		achievement.text = "[rainbow freq=1.0 sat=0.3 val=0.8 speed=0.4][center]%s[/center][/rainbow]" % achievement_text

func _on_button_retry_button_up() -> void:
	Startup.restartLevel()


func _on_button_menu_button_up() -> void:
	Startup.goToMenu()
