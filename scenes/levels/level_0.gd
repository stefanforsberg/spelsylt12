extends LevelBase


func _ready():
	super()

func _draw():
	super()


func _on_area_2d_body_entered(body):
	Startup.death()
