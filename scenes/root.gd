extends Node2D

@onready var timer = $CanvasLayer/Timer
@onready var inventory = $CanvasLayer/Inventory
@onready var level_root = $LevelRoot
@onready var player = $Player
@onready var sprite_2d_4 = $CanvasLayer2/Sprite2D4
@onready var sprite_2d_3 = $CanvasLayer2/Sprite2D3

var elapsed_time := 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	# var level = Startup.currentLevel.instantiate()
	
	level_root.add_child(Startup.currentLevel)
	#get_tree().root.add_child()
	Startup.inventory_updated.connect(_inventory_updated)
	Startup.player_hit.connect(_player_hit)
	_inventory_updated()
	
	print("here?")
	print(Startup.currentLevel.max_end)
	
	
	pass # Replace with function body.

func _player_hit():
	elapsed_time += 2

func _inventory_updated():
	inventory.text = 'S %s | P %s' % [Startup.inventory[Startup.NamedEnum.SCISSOR], Startup.inventory[Startup.NamedEnum.PAPER]]
	

func _process(delta: float) -> void:

	sprite_2d_4.position.x -= 0.1
	sprite_2d_3.position.x -= 0.1 	
	
	if sprite_2d_4.position.x < -640:
		sprite_2d_4.position.x = 1280+640
		
	if sprite_2d_3.position.x < -640:
		sprite_2d_3.position.x = 1280+640

	elapsed_time += delta
	timer.text = str(elapsed_time as int).pad_zeros(4) 
