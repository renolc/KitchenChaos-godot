shader_type spatial;

uniform vec3 top_color: source_color;

void fragment() {
	if (NORMAL.y < 0.0){
		ALBEDO = top_color * (1.0 - UV.y);
	} else {
		ALBEDO = top_color  * .3;
	}
}
