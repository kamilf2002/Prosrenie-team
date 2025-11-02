extends CharacterBody2D

<<<<<<< HEAD

=======
>>>>>>> 37f866f651c359d3287a6247a21aa7c0491421f5
const SPEED = 150.0
const JUMP_VELOCITY = -320.0
var jump = 0
const RESPAWN_POSITION = Vector2(43, 579)

@export var spikes_layer: TileMapLayer
@export var danger_tile_ids: Array[int] = [1, 2]

@onready var anim = $AnimatedSprite2D

# === ПРОВЕРКА ОПАСНОГО ТАЙЛА ===
func is_dangerous_tile_at(world_pos: Vector2) -> bool:
	if spikes_layer == null:
		return false
	var local_pos = spikes_layer.to_local(world_pos)
	var tile_pos = spikes_layer.local_to_map(local_pos)
	var tile_id = spikes_layer.get_cell_source_id(tile_pos)
	return tile_id != -1 and tile_id in danger_tile_ids

# === РЕСПАВН ===
func respawn() -> void:
	position = RESPAWN_POSITION
	velocity = Vector2.ZERO
	print("Респавн там где надо!")

# === ФИЗИКА ===
func _physics_process(delta: float) -> void:
	# ГРАВИТАЦИЯ
	if not is_on_floor():
		velocity += get_gravity() * delta

	# ПРЫЖОК
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump = 0

	# ДВИЖЕНИЕ
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# АНИМАЦИЯ
	if velocity.y == 0:
		if direction != 0:
			anim.play("sad")
		else:
			anim.play("happy")
	
	if direction == -1:
		$AnimatedSprite2D.flip_h = true
	elif direction == 1:
		$AnimatedSprite2D.flip_h = false

	# === ДВИЖЕНИЕ (ОБЯЗАТЕЛЬНО ПЕРЕД ПРОВЕРКОЙ!) ===
	move_and_slide()

	# === ПРОВЕРКА СКОЛЬЖЕНИЯ (БОК/ВЕРХ) ===
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider == spikes_layer and is_dangerous_tile_at(collision.get_position()):
			respawn()
			return

	# === ПРОВЕРКА СТОЯНИЯ НА ШИПАХ ===
	if is_on_floor() and $CollisionShape2D != null:
		var shape = $CollisionShape2D.shape
		var half_width = 8.0
		var foot_y = global_position.y + 16.0

		if shape is RectangleShape2D:
			half_width = shape.extents.x * 0.8
			foot_y = global_position.y + shape.extents.y + 1

		var left_foot = Vector2(global_position.x - half_width, foot_y)
		var center_foot = Vector2(global_position.x, foot_y)
		var right_foot = Vector2(global_position.x + half_width, foot_y)

		if (is_dangerous_tile_at(left_foot) or
			is_dangerous_tile_at(center_foot) or
			is_dangerous_tile_at(right_foot)):
			respawn()
			return
