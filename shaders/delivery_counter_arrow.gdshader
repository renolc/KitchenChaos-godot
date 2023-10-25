shader_type spatial;

uniform sampler2D Texture;
uniform vec2 Dir = vec2(1.0, -1.0);
uniform float Speed = 0.08;
uniform float Time;

void fragment() {
	vec4 t = texture(Texture, UV + (Dir * Time * Speed));
	ALBEDO = t.rgb;
	ALPHA = t.a;
}
