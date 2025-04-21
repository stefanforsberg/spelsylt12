extends LevelBase

var touched_grass = false

func _ready():
	super()

	Startup.inventory[Startup.NamedEnum.PAPER] = 1
	Startup.inventory[Startup.NamedEnum.SCISSOR] = 3

	# Call the function to detect collision shapes

func _draw():
	super()

func _process(delta):
	pass


func _on_oob_body_entered(body):
	Startup.death()


func _on_grass_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		print("touch grass!!!")
		touched_grass = true
