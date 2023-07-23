shader_type canvas_item;
render_mode skip_vertex_transform;

uniform bool enabled = false;

void vertex() {
	VERTEX = (MODEL_MATRIX * vec4(VERTEX, 0.0, 1.0)).xy;
	if (enabled) {
		float vertex_offset = VERTEX.y * 4.0;
		float time_offset = TIME * 3.0;
		VERTEX.x += sin(vertex_offset + time_offset) * 5.0;
	}
}
