extends Node2D

var collision_shapes: Array
@onready var blocks = $Blocks

func _ready():
	collision_shapes = []

	# Call the function to detect collision shapes
	detect_collision_shapes()

	
			
			

func _draw():
	print("draw")
	# Print the found shapes for debugging
	for shape in collision_shapes:
		if shape.shape is RectangleShape2D:
			print("Found shape!")
			

			var top_start: Vector2
			var top_end: Vector2
			print("Detected CollisionShape2D: ", shape.name)
			var width = shape.shape.extents.x * 2
			var height = shape.shape.extents.y * 2
			top_start = Vector2(-width / 2, -height / 2)
			top_end = Vector2(width / 2, -height / 2)
			
			#modulate = Color(0, 1.4, 0)  # Green color
			
			var line = Line2D.new()
			shape.add_child(line)

			# Customize the Line2D appearance
			line.width = 4
			line.default_color = Color(2, 0, 0)  # Red color
			
			line.clear_points()

			# Add points to Line2D
			line.add_point(top_start)
			line.add_point(top_end)
			
			#line.rotation = shape.rotation
			
			# line.modulate = Color(1,0,0)

			
			#draw_line(shape.position + rotate_point(top_start, shape.rotation), shape.position+rotate_point(top_end, shape.rotation), Color(1, 1, 1), 8)			
			#draw_line(shape.position + top_start + Vector2(0,6), shape.position+top_end + Vector2(0,6), Color(1, 0, 0), 3)			

		



func detect_collision_shapes():
	# Iterate through all children of the current node
	for child in blocks.get_children():
		if child is CollisionShape2D:
			collision_shapes.append(child)
		elif child.get_child_count() > 0:
			# Check nested children recursively
			collision_shapes += find_collision_shapes_recursive(child)

func find_collision_shapes_recursive(node: Node) -> Array:
	var found_shapes = []
	for child in node.get_children():
		if child is CollisionShape2D:
			found_shapes.append(child)
		elif child.get_child_count() > 0:
			found_shapes += find_collision_shapes_recursive(child)
	return found_shapes

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
