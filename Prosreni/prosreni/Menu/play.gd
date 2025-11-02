extends Button


func _on_pressed() -> void:
	pass # Replace with function body.


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://Settings/settings.tscn")


func _on_exit_pressed() -> void:
		get_tree().quit()


func _on_test_pressed() -> void:
	get_tree().change_scene_to_file("res://test/test.tscn")
