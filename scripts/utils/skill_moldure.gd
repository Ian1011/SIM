extends TextureRect

@onready var icon = $TextureRect

# Called when the node enters the scene tree for the first time.
func add_icon(path):
	#$TextureRect.size = Vector2(32, 32)
	$TextureRect.texture = path
	$TextureRect.scale = Vector2(0.375, 0.375)
	$TextureRect.position = Vector2(16,16) # anterior 4, ou seja, diferença de 12

