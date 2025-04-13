extends CharacterBody2D
@onready var player_stone = $Sprites/PlayerStone
@onready var player_paper = $Sprites/PlayerPaper
@onready var player_scissor = $Sprites/PlayerScissor

@onready var floor_detector = $FloorDetector
@onready var dash = $Dash


const SPEED = 600.0
const JUMP_VELOCITY = -400.0

var currentState = "rock"

var current_floor = null

func _physics_process(delta):


	if Input.is_action_just_pressed("rock"):
		print("rock!")
		currentState = "rock"
		player_scissor.visible = false
		player_paper.visible = false
		player_stone.visible = true
		
	if Input.is_action_just_pressed("paper") and !is_on_floor() and Startup.inventory[Startup.NamedEnum.PAPER] > 0:
		currentState = "paper"
		player_scissor.visible = false
		player_paper.visible = true
		player_stone.visible = false
		rotation = 0
		
	if Input.is_action_just_pressed("scissor") and Startup.inventory[Startup.NamedEnum.SCISSOR] > 0:
		dash.restart()
		Startup.updateInventory(Startup.NamedEnum.SCISSOR,-1)
		currentState = "scissor"
		player_scissor.visible = true
		player_paper.visible = false
		player_stone.visible = false
		velocity.x = SPEED*4
		velocity.y =  -700
		
	if currentState == "rock":

		
		

		

		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta * 8
		else:
			velocity.x = SPEED
		
		#rotation += 0.25
		player_stone.rotation += 0.25

	elif currentState == "paper":
		
		if is_on_floor():
			currentState = "rock"
			player_scissor.visible = false
			player_paper.visible = false
			player_stone.visible = true
		else:

			velocity.y = move_toward(velocity.y, 100, 30)
			velocity.x = move_toward(velocity.x, SPEED, 30)
	elif currentState == "scissor":

		if velocity.y > -10 and is_on_floor():
			currentState = "rock"
			player_scissor.visible = false
			player_paper.visible = false
			player_stone.visible = true
		else:
			
			velocity += get_gravity() * delta
			
			velocity.x = move_toward(velocity.x, SPEED, SPEED/10)
			
			player_scissor.rotation += 0.25
			
	

	move_and_slide()
	
	if floor_detector.is_colliding():
		var floor = floor_detector.get_collider()
		if floor != current_floor:
			current_floor = floor
			current_floor.modulate = Color(4,0,0)
	else:
		if current_floor:
			current_floor.modulate = Color(1,0,0)
			current_floor = null
	
func wind():
	print("wind!")
	if currentState == "paper":
		print("up!")
		velocity.y = -600
		
	
