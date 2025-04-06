extends CharacterBody2D
@onready var scissor_aim = $ScissorAim
@onready var player_stone = $PlayerStone
@onready var player_paper = $PlayerPaper
@onready var player_scissor = $PlayerScissor
@onready var floor_detector = $FloorDetector


const SPEED = 600.0
const JUMP_VELOCITY = -400.0

var state = ["rock","paper","scissor","aim","dash"]
var stateIndex = 0

var currentState = "rock"

var current_collision : Node = null

var current_floor = null

func _physics_process(delta):


	if Input.is_action_just_pressed("rock"):
		print("rock!")
		currentState = "rock"
		player_scissor.visible = false
		player_paper.visible = false
		player_stone.visible = true
		
	if Input.is_action_just_pressed("paper") and !is_on_floor():
		currentState = "paper"
		player_scissor.visible = false
		player_paper.visible = true
		player_stone.visible = false
		rotation = 0
		
	if Input.is_action_just_pressed("scissor") and is_on_floor():
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

		## Get the input direction and handle the movement/deceleration.
		## As good practice, you should replace UI actions with custom gameplay actions.
		#var direction = Input.get_axis("ui_left", "ui_right")
		#if direction:
			#velocity.x = direction * SPEED
			#rotation += direction/4
		#else:
			#velocity.x = move_toward(velocity.x, 0, SPEED)
			#
	elif currentState == "paper":
		
		if is_on_floor():
			currentState = "rock"
			player_scissor.visible = false
			player_paper.visible = false
			player_stone.visible = true
		else:

			velocity.y = move_toward(velocity.y, 100, 30)
			velocity.x = move_toward(velocity.x, SPEED / 2, 30)
			
		
				# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
			
	elif currentState == "scissor":

		if velocity.y > -10 and is_on_floor():
			currentState = "rock"
			player_scissor.visible = false
			player_paper.visible = false
			player_stone.visible = true
		else:
			
		#scissor_aim.rotation = 0
		#stateIndex+=1
		
		#velocity.x = SPEED
		
			velocity += get_gravity() * delta
			
			velocity.x = move_toward(velocity.x, SPEED/2, SPEED/10)
			
			player_scissor.rotation += 0.25
			
	

	move_and_slide()
	
	if floor_detector.is_colliding():
		var floor = floor_detector.get_collider()
		if floor != current_floor:
			#reset_previous_floor_color()
			current_floor = floor
			print("new floor")
			print(floor)
			current_floor.modulate = Color(4,0,0)
			#change_floor_color(current_floor, Color(1, 0, 0)) # Example: Red
	else:
		if current_floor:
			current_floor.modulate = Color(1,0,0)
			current_floor = null
			print("exit floor")
			#reset_previous_floor_color()
	
	#var nextCollision = null
	#
	#print(nextCollision, current_collision)
#
	#for i in get_slide_collision_count():
		#var collision = get_slide_collision(i)
		#
		#print(collision.normal)
		#
		#if collision.normal == Vector2.UP:
			#print("floor")
		##var collider = collision.get_collider()
		##if collider is StaticBody2D:
			##
			##
			##
			##nextCollision = collider
			###print("Collided with: ", collision.get_collider().name)
			###print(collision.get_collider().modulate)
			##collider.modulate = Color(4,0,0)

	
func wind():
	print("wind!")
	print(state[stateIndex])
	if currentState == "paper":
		print("up!")
		velocity.y = -600
		
	
