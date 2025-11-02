extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -400.0
var jump = 0
const RESPAWN_POSITION = Vector2(43, 579)

# Ссылка на TileMapLayer с шипами — НАЗНАЧЬ В ИНСПЕКТОРЕ!
@export var spikes_layer: TileMapLayer
@export var danger_tile_ids: Array[int] = [1, 2]  # ← ИЗМЕНИ ЗДЕСЬ ИЛИ В ИНСПЕКТОРЕ
@onready var anim = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# === ГРАВИТАЦИЯ ===
	if not is_on_floor():
		velocity += get_gravity() * delta

	# === ПРЫЖОК ===
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump = 0

	# === ДВИЖЕНИЕ ВЛЕВО/ВПРАВО ===
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# === АНИМАЦИЯ ===
	if velocity.y == 0:
		if direction != 0:
			anim.play("sad")  # или "run", если есть
		else:
			anim.play("happy")
	
	if direction == -1:
		$AnimatedSprite2D.flip_h = true
	elif direction == 1:
		$AnimatedSprite2D.flip_h = false

	# === ДВИЖЕНИЕ (ОБЯЗАТЕЛЬНО ПЕРЕД ПРОВЕРКОЙ КОЛЛИЗИЙ!) ===
	move_and_slide()

	# === ПРОВЕРКА ШИПОВ ПОСЛЕ ДВИЖЕНИЯ ===
# === ОПАСНЫЕ ТАЙЛЫ (настраиваются в инспекторе) ===


# === ПРОВЕРКА КОНКРЕТНЫХ ТАЙЛОВ ===
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()

		if collider is TileMapLayer and collider == spikes_layer:
			var collision_pos = collision.get_position()
			var tile_pos = spikes_layer.local_to_map(collision_pos)
			var tile_id = spikes_layer.get_cell_source_id(tile_pos)

		# Если ID тайла есть в списке опасных
			if tile_id in danger_tile_ids:
				respawn()
				return
	if is_on_floor():
		var floor_normal = get_floor_normal()
		if floor_normal != Vector2.ZERO:
		# Позиция под ногами
			var foot_pos = global_position + Vector2(0, 8)  # подстрой под размер персонажа
			var tile_pos = spikes_layer.local_to_map(spikes_layer.to_local(foot_pos))
			var tile_id = spikes_layer.get_cell_source_id(tile_pos)

			if tile_id in danger_tile_ids:
				respawn()
				return

# === РЕСПАВН ===
func respawn():
	position = RESPAWN_POSITION
	velocity = Vector2.ZERO
	print("Респавн в (0, 0)!")
