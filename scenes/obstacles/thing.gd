extends Node2D

@export var type: Startup.NamedEnum

@onready var sprite_paper = $SpritePaper
@onready var sprite_scissor = $SpriteScissor
@onready var sprite_rock = $SpriteRock

var currentSprite = null

func _ready():
	if type == Startup.NamedEnum.PAPER:
		currentSprite = sprite_paper
	elif type == Startup.NamedEnum.SCISSOR:
		currentSprite = sprite_scissor
	elif type == Startup.NamedEnum.ROCK:
		currentSprite = sprite_rock
		
	currentSprite.visible = true

func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body is CharacterBody2D:
		match [body.currentState, type]:
			["rock", Startup.NamedEnum.PAPER], ["scissor", Startup.NamedEnum.ROCK], ["paper", Startup.NamedEnum.SCISSOR]:
				Startup.player_hit.emit()
			["scissor", Startup.NamedEnum.PAPER],["rock", Startup.NamedEnum.SCISSOR],["paper", Startup.NamedEnum.ROCK]:
				Startup.updateInventory(type,1)
				currentSprite.visible = false
		
		
