shader_type canvas_item;

uniform vec2 mouse_pos;  // Позиция мыши в координатах вьюпорта

uniform float radius = 150.0;  // Радиус в экранных пикселях

void fragment() {
    // Используем FRAGCOORD.xy для позиции пикселя в экране, mouse_pos тоже в экране
    float dist = distance(FRAGCOORD.xy, mouse_pos);
    
    if (dist < radius) {
        COLOR.a = 0.0;  // Прозрачно внутри круга
    } else {
        COLOR = texture(TEXTURE, UV);  // Оверлей снаружи
    }
}
