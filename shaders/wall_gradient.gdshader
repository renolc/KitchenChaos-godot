shader_type spatial;

uniform vec3 Gradient_Color: source_color;

void fragment() {
	if (NORMAL.y < 0.0){
		ALBEDO = Gradient_Color * (1.0 - UV.y);
	} else {
		ALBEDO = Gradient_Color  * .3;
	}
}
