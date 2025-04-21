extends LevelBase
@onready var static_body_2d_2: StaticBody2D = $Blocks/StaticBody2D2

func _ready():
	super()

	Startup.inventory[Startup.NamedEnum.SCISSOR] = 5
	Startup.inventory[Startup.NamedEnum.PAPER] = 5

func _physics_process(delta: float) -> void:
	static_body_2d_2.rotation_degrees -= 100*delta


func _on_oob_body_entered(body: Node2D) -> void:
	Startup.death()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		body.zoom(0.3)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		body.zoom()
