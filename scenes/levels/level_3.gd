extends LevelBase


func _ready():
	super()

	Startup.inventory[Startup.NamedEnum.SCISSOR] = 2
	Startup.inventory[Startup.NamedEnum.PAPER] = 2

func _draw():
	super()


func _on_oob_body_entered(body: Node2D) -> void:
	Startup.death()


func _on_zoom_1_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		body.zoom(0.4)


func _on_zoom_1_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		body.zoom()
