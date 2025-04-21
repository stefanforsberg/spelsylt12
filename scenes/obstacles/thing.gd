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
		currentSprite.visible = false
		match [body.currentState, type]:
			[Startup.NamedEnum.ROCK, Startup.NamedEnum.PAPER], [Startup.NamedEnum.SCISSOR, Startup.NamedEnum.ROCK], [Startup.NamedEnum.PAPER, Startup.NamedEnum.SCISSOR]:
				Startup.player_hit.emit(3)
			[Startup.NamedEnum.SCISSOR, Startup.NamedEnum.PAPER],[Startup.NamedEnum.ROCK, Startup.NamedEnum.SCISSOR],[Startup.NamedEnum.PAPER, Startup.NamedEnum.ROCK]:
				Startup.player_hit.emit(-2)
				
		
		
