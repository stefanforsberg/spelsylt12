extends CharacterBody2D
@onready var player_stone = $Sprites/PlayerStone
@onready var player_paper = $Sprites/PlayerPaper
@onready var player_scissor = $Sprites/PlayerScissor

@onready var floor_detector = $FloorDetector
@onready var dash = $Dash
@onready var camera_2d: Camera2D = $Camera2D
@onready var gpu_particles_2d_land: GPUParticles2D = $GPUParticles2DLand

@onready var jump: AudioStreamPlayer = $"../Jump"
@onready var explosion: AudioStreamPlayer = $"../Explosion"
@onready var windSfx: AudioStreamPlayer = $"../Wind"
@onready var explosion_break: AudioStreamPlayer = $"../ExplosionBreak"
@onready var powerup: AudioStreamPlayer = $"../Powerup"
@onready var hit: AudioStreamPlayer = $"../Hit"

const SPEED = 800.0
const JUMP_VELOCITY = -400.0

var currentState: Startup.NamedEnum = Startup.NamedEnum.ROCK

var current_floor = null

var was_in_air = false

var gravity_rock_delta = 1

func _ready() -> void:
	Startup.player_hit.connect(_on_player_hit)

func _on_player_hit(val):
	if val > 0:
		hit.play();
	elif val < 0:
		powerup.play()

func _physics_process(delta):

	var current_y_vel = velocity.y

	if Input.is_action_just_pressed("rock"):
		currentState = Startup.NamedEnum.ROCK
		player_scissor.visible = false
		player_paper.visible = false
		player_stone.visible = true
		
	if Input.is_action_just_pressed("paper") and !is_on_floor() and Startup.inventory[Startup.NamedEnum.PAPER] > 0:
		Startup.updateInventory(Startup.NamedEnum.PAPER,-1)
		currentState = Startup.NamedEnum.PAPER
		player_scissor.visible = false
		player_paper.visible = true
		player_stone.visible = false

		
	if Input.is_action_just_pressed("scissor") and Startup.inventory[Startup.NamedEnum.SCISSOR] > 0:
		jump.play()
		dash.restart()
		Startup.updateInventory(Startup.NamedEnum.SCISSOR,-1)
		currentState = Startup.NamedEnum.SCISSOR
		player_scissor.visible = true
		player_paper.visible = false
		player_stone.visible = false
		velocity.x = SPEED*4
		velocity.y =  -700
		
	if currentState == Startup.NamedEnum.ROCK:

		if not is_on_floor():
			velocity += get_gravity() * delta * (12 / gravity_rock_delta)
		else:
			velocity.x = SPEED
		
		player_stone.rotation += 0.25

	elif currentState == Startup.NamedEnum.PAPER:
		
		if is_on_floor():
			currentState = Startup.NamedEnum.ROCK
			player_scissor.visible = false
			player_paper.visible = false
			player_stone.visible = true
		else:

			velocity.y = move_toward(velocity.y, 100, 30)
			velocity.x = move_toward(velocity.x, SPEED, 30)
	elif currentState == Startup.NamedEnum.SCISSOR:

		if velocity.y > -10 and is_on_floor():
			currentState = Startup.NamedEnum.ROCK
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
			
			if current_floor:
				var breakable = floor.get_meta("Breakable", false)
				current_floor.modulate = Color(1,2,2) if breakable else Color(2,1,1) 
				current_floor = null
			
			current_floor = floor
			var breakable = floor.get_meta("Breakable", false)
			current_floor.modulate = Color(0,8,8) if breakable else Color(8,0,0) 
			
			if was_in_air and currentState == Startup.NamedEnum.ROCK:
				
				explosion.play();
				if gpu_particles_2d_land:
					gpu_particles_2d_land.restart()
			
			if was_in_air and currentState == Startup.NamedEnum.ROCK and current_floor.get_meta("Breakable", false):
				explosion_break.play()
				current_floor.process_mode = Node.PROCESS_MODE_DISABLED
				current_floor.visible = false
			
	else:
		if current_floor:
			var breakable = current_floor.get_meta("Breakable", false)
			current_floor.modulate = Color(0,2,2) if breakable else Color(2,0,0) 
			current_floor = null
			
	if is_on_floor():
		was_in_air = false
	else:
		was_in_air = true
	
func wind():
	if currentState == Startup.NamedEnum.PAPER:
		windSfx.play()
		velocity.y = -800
	
func zoom(value = 0.6):
	var tween = get_tree().create_tween()
	tween.tween_property(camera_2d, "zoom", Vector2(value,value), 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
