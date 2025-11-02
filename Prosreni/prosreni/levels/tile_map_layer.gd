extends TileMapLayer

"""func _input(event: InputEvent) -> void:
	if event is CollisionObject2D:
		var tile_pos := get_tile_pos"""
# Called when the node enters the scene tree for the first time.

func _on_detector_body_entered(body):
	if body == $"../player/player":
		$"../player/player".position = Vector2(43,579)
