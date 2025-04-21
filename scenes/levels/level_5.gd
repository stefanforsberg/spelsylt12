extends LevelBase
@onready var static_body_2d_2: StaticBody2D = $Blocks/StaticBody2D2

var drop_of_faith = false

func _ready():
	super()

	Startup.inventory[Startup.NamedEnum.SCISSOR] = 5
	Startup.inventory[Startup.NamedEnum.PAPER] = 5

func _on_oob_body_entered(body: Node2D) -> void:
	Startup.death()

func _on_area_achievement_body_entered(body: Node2D) -> void:
	drop_of_faith = true
