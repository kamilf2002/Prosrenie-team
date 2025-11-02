extends Node2D

@onready var overlay: Sprite2D = $CanvasLayer/Black  # Оверлей (Black)
@onready var background: Sprite2D = $White  # Фон (White)
@onready var overlay_material: ShaderMaterial = null  # Материал инициализируем null

func _ready():
	if overlay:
		overlay_material = overlay.material as ShaderMaterial
		if not overlay_material:
			print("Ошибка: Материал на Black (overlay) не найден или не ShaderMaterial!")
	else:
		print("Ошибка: Узел Black (overlay) не найден!")
	
	if not background:
		print("Ошибка: Узел White (background) не найден!")
	
	# Адаптивность
	get_viewport().connect("size_changed", _on_viewport_size_changed)
	_on_viewport_size_changed()

# Новое: Обработка событий ввода для мгновенного обновления при движении мыши
func _input(event):
	if overlay_material and event is InputEventMouseMotion:
		var global_mouse = get_global_mouse_position()
		overlay_material.set_shader_parameter("mouse_pos", global_mouse)

# _process() оставляем для дополнительных обновлений (на всякий случай, но основное в _input)
func _process(_delta):
	if overlay_material:
		var global_mouse = get_global_mouse_position()
		overlay_material.set_shader_parameter("mouse_pos", global_mouse)

func _on_viewport_size_changed():
	var viewport_size = get_viewport_rect().size
	
	# Настройка фона (White)
	var bg_texture = load("res://assets/pictures/423b7ae46dd707386be36b2986063fa6.jpg")  # Замени путь, если нужно
	if bg_texture:
		background.texture = bg_texture
		background.scale = viewport_size / bg_texture.get_size()
		background.position = viewport_size / 2
	else:
		print("Ошибка: Текстура res://background.png не найдена!")
	
	# Настройка оверлея (Black)
	var overlay_texture = load("res://test/maxresdefault.jpg")  # Замени путь
	if overlay_texture:
		overlay.texture = overlay_texture
		overlay.scale = viewport_size / overlay_texture.get_size()
		overlay.position = viewport_size / 2
		overlay.z_index = 1  # Сверху
	else:
		print("Ошибка: Текстура res://overlay_black.png не найдена!")
	
