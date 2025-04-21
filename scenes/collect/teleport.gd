extends Node

@onready var marker_2d: Marker2D = $Marker2D
@export var type: Startup.NamedEnum

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		body.velocity = Vector2(0,0)
		body.position = marker_2d.global_position + Vector2(-60,60)
		
