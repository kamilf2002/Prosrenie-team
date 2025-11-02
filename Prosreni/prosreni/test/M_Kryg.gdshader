shader_type canvas_item;

uniform vec2 mouse_pos;  // Позиция мыши в координатах вьюпорта
uniform float radius = 150.0;  // Радиус в экранных пикселях

uniform vec4 fog_color : source_color = vec4(0.1, 0.1, 0.2, 1.0); // Цвет тумана (темно-синий)
uniform float noise_scale : hint_range(0, 10) = 3.0;

float rand(vec2 coord) {
    return fract(sin(dot(coord, vec2(12.9898, 78.233))) * 43758.5453);
}
void fragment() {
	
	vec2 coord = UV * noise_scale;
    COLOR = fog_color + (rand(coord) * 0.1);
    // Используем FRAGCOORD.xy для позиции пикселя в экране, mouse_pos тоже в экране
    float dist = distance(FRAGCOORD.xy, mouse_pos);
    
    if (dist < radius) {
        COLOR.a = 0.0;  // Прозрачно внутри круга
    } else {
        COLOR = texture(TEXTURE, UV);  // Оверлей снаружи
    }
}


