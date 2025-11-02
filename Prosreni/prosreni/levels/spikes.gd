extends TileMapLayer

func _on_Area2D_body_entered(body):
	if body == CharacterBody2D:
		$"../player".position = Vector2(43,579)
	
