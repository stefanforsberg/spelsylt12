extends Node2D

var isActive = false
var player: CharacterBody2D

@export var width: int
@export var height: int

# Called when the node enters the scene tree for the first time.
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D

func _ready():
	var pm: ParticleProcessMaterial = gpu_particles_2d.process_material
	pm.emission_box_extents = Vector3(width, 1, 1)
	var shape: RectangleShape2D = collision_shape_2d.shape
	shape.size.x = width*2

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
