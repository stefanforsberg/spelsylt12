extends LevelBase

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
