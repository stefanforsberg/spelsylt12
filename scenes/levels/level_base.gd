extends Node2D
class_name LevelBase

var collision_shapes: Array
@onready var blocks = $Blocks

var max_end = 0


func _ready():
	pass # Replace with function body.

	detect_collision_shapes()
	


func _draw():
	# Print the found shapes for debugging
	for shape in collision_shapes:
		if shape.shape is RectangleShape2D:
			

			var top_start: Vector2
			var top_end: Vector2
			var width = shape.shape.extents.x * 2
			var height = shape.shape.extents.y * 2
			top_start = Vector2(-width / 2, -height / 2)
			top_end = Vector2(width / 2, -height / 2)
			
			max_end = max(top_end.x, max_end)
			
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
