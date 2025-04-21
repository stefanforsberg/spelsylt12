extends LevelBase

@export var To: Vector2
@onready var static_body_2d_2: StaticBody2D = $Blocks/StaticBody2D2

func _ready():
	super()

	Startup.inventory[Startup.NamedEnum.SCISSOR] = 5
	Startup.inventory[Startup.NamedEnum.PAPER] = 5

	var tween = create_tween()
	tween.set_loops(-1)
	tween.tween_property(static_body_2d_2, "rotation_degrees", -90, 2) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_IN_OUT)
	
	tween.tween_property(static_body_2d_2, "rotation_degrees", -90, 2) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_IN_OUT)
		
	tween.tween_property(static_body_2d_2, "rotation_degrees", 0, 2) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_IN_OUT)
		
	tween.tween_property(static_body_2d_2, "rotation_degrees", 0, 2) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_IN_OUT)	
		
		

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		body.zoom(0.3)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		body.zoom()
		
func _on_oob_2_body_entered(body: Node2D) -> void:
	Startup.death()

func _on_area_low_gravity_body_entered(body: Node2D) -> void:
	body.gravity_rock_delta = 12

func _on_area_normal_gravity_body_entered(body: Node2D) -> void:
	body.gravity_rock_delta = 1
