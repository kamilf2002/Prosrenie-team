extends Node2D

@onready var overlay: Sprite2D = $CanvasLayer/Black  # Оверлей (Black)
@onready var overlay_material: ShaderMaterial = null  # Материал инициализируем null

func _ready():

	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

	if overlay:
		overlay_material = overlay.material as ShaderMaterial
		if not overlay_material:
			print("Ошибка: Материал на Black (overlay) не найден или не ShaderMaterial!")
	else:
		print("Ошибка: Узел Black (overlay) не найден!")
	
<<<<<<< HEAD

=======
>>>>>>> 37f866f651c359d3287a6247a21aa7c0491421f5
	# Адаптивность
	get_viewport().connect("size_changed", _on_viewport_size_changed)
	_on_viewport_size_changed()

# Новое: Обработка событий ввода для мгновенного обновления при движении мыши
func _input(event):
	if overlay_material and event is InputEventMouseMotion:
		var screen_mouse = get_viewport().get_mouse_position()  # ФИКС: screen space!
		overlay_material.set_shader_parameter("mouse_pos", screen_mouse)
<<<<<<< HEAD

=======
>>>>>>> 37f866f651c359d3287a6247a21aa7c0491421f5

func _process(_delta):
	if overlay_material:
		var screen_mouse = get_viewport().get_mouse_position()
		overlay_material.set_shader_parameter("mouse_pos", screen_mouse)

func _on_viewport_size_changed():
	var viewport_size = get_viewport_rect().size
	
<<<<<<< HEAD
	# Настройка фона (White)
=======
>>>>>>> 37f866f651c359d3287a6247a21aa7c0491421f5
	# Настройка оверлея (Black)
	var overlay_texture = load("res://test/maxresdefault.jpg")  # Замени путь
	if overlay_texture:
		overlay.texture = overlay_texture
		overlay.scale = viewport_size / overlay_texture.get_size()
		overlay.position = viewport_size / 2
		overlay.z_index = 1  # Сверху
	else:
		print("Ошибка: Текстура res://overlay_black.png не найдена!")

		
func _exit_tree():  # Опционально: Показать курсор при выходе из сцены
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
