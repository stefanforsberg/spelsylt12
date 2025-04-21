extends Node2D
@onready var bg_layer_0_alt_1: Sprite2D = $CanvasLayer2/Bg_Layer0_Alt1
@onready var bg_layer_0_alt_2: Sprite2D = $CanvasLayer2/Bg_Layer0_Alt2

var rng = RandomNumberGenerator.new()

@onready var timer = $CanvasLayer/Timer
@onready var inventory = $CanvasLayer/Inventory
@onready var level_root = $LevelRoot
@onready var player = $Player
@onready var sprite_2d_4 = $CanvasLayer2/Sprite2D4
@onready var sprite_2d_3 = $CanvasLayer2/Sprite2D3
@onready var bg_layer_2_1: Sprite2D = $CanvasLayer2/BgLayer2_1
@onready var bg_layer_2_2: Sprite2D = $CanvasLayer2/BgLayer2_2

var elapsed_time := 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	# var level = Startup.currentLevel.instantiate()
	
	var rngNum = rng.randf_range(0, 1)
	
	bg_layer_0_alt_1.visible = false
	bg_layer_0_alt_2.visible = false
	
	if(rngNum < 0.5):
		bg_layer_0_alt_1.visible = true
	else:
		bg_layer_0_alt_2.visible = true
	
	level_root.add_child(Startup.currentLevel)
	#get_tree().root.add_child()
	Startup.inventory_updated.connect(_inventory_updated)
	Startup.player_hit.connect(_player_hit)
	_inventory_updated()
	
	pass # Replace with function body.

func _player_hit(delta):
	elapsed_time += delta

func _inventory_updated():
	inventory.text = 'S %s | P %s' % [Startup.inventory[Startup.NamedEnum.SCISSOR], Startup.inventory[Startup.NamedEnum.PAPER]]
	

func _process(delta: float) -> void:

	bg_layer_2_1.position.x -= 0.1
	bg_layer_2_2.position.x -= 0.1
	
	if bg_layer_2_1.position.x < -640:
		bg_layer_2_1.position.x = 1280+640
		
	if bg_layer_2_2.position.x < -640:
		bg_layer_2_2.position.x = 1280+640

	sprite_2d_4.position.x -= 0.3
	sprite_2d_3.position.x -= 0.3 	
	
	if sprite_2d_4.position.x < -640:
		sprite_2d_4.position.x = 1280+640
		
	if sprite_2d_3.position.x < -640:
		sprite_2d_3.position.x = 1280+640

	elapsed_time += delta
	timer.text = "%.2f" % elapsed_time


func _on_menu_button_down() -> void:
	Startup.goToMenu()
