extends Node2D

enum NamedEnum {ROCK, PAPER, SCISSOR = -1}
@export var x: NamedEnum
@onready var sprite_rock = $SpriteRock
@onready var sprite_paper = $SpritePaper
@onready var sprite_scissor = $SpriteScissor

# Called when the node enters the scene tree for the first time.
func _ready():
	if x == NamedEnum.ROCK:
		sprite_rock.visible = true
	elif x == NamedEnum.PAPER:
		sprite_paper.visible = true
	elif x == NamedEnum.SCISSOR:
		sprite_scissor.visible = true
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body is CharacterBody2D:
		# collect this thing, call some method on player?
		pass


func _on_area_2d_body_exited(body):
	pass # Replace with function body.
