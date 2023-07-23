shader_type canvas_item;

uniform sampler2D pulse_texture;
uniform sampler2D screen_texture: hint_screen_texture;

void fragment() {
	vec4 screen_color = texture(screen_texture, SCREEN_UV);
	COLOR.rgb = vec3(1.0, 1.0, 1.0) - screen_color.rgb;
}
