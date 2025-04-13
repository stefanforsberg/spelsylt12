extends LevelBase


func _ready():
	super()
	
	Startup.inventory[Startup.NamedEnum.PAPER] = 5
	Startup.inventory[Startup.NamedEnum.SCISSOR] = 5

#func _draw():
	#super()


func _on_area_2d_body_entered(body):
	Startup.death()
