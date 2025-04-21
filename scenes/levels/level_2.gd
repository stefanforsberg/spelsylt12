extends LevelBase


func _ready():
	super()

	Startup.inventory[Startup.NamedEnum.SCISSOR] = 1

func _draw():
	super()


func _on_oob_body_entered(body: Node2D) -> void:
	Startup.death()
