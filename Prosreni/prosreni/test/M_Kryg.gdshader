shader_type canvas_item;

uniform vec2 mouse_pos;  // Позиция мыши в координатах вьюпорта
uniform float radius = 200.0;  // Радиус в экранных пикселях

void fragment() {
    float dist = distance(FRAGCOORD.xy, mouse_pos);
    if (dist < radius) {
        COLOR.a = 0.0;  // Прозрачно внутри круга
    } else {
        COLOR = texture(TEXTURE, UV);  // Оверлей снаружи
    }
}