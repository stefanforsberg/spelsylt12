extends Node2D

var isActive = false
var player: CharacterBody2D



# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isActive:
		player.wind()


func _on_area_2d_body_entered(body):
	if body is CharacterBody2D:
		player = body
		isActive = true


func _on_area_2d_body_exited(body):
	isActive = false
