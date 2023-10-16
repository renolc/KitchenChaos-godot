shader_type spatial;
render_mode cull_disabled;

uniform sampler2D Texture;

void fragment() {
	vec4 t = texture(Texture, UV);
	ALBEDO = vec3(100);
	ALPHA = t.a;
}
