shader_type canvas_item;
uniform vec4 color : hint_color;
uniform float precision = 1.9;
uniform float ring_start = 0.9;
uniform float ring_size = 0.1;

void fragment() {
	vec2 uv = UV + vec2(-0.5);
	float l = length(uv*precision);
	COLOR.rgb = textureLod(SCREEN_TEXTURE, SCREEN_UV, 1.0).rgb;
	COLOR.rgb *= color.rgb;
	COLOR.rgb += color.rgb;
	COLOR.a = 1.4 - l;
	if (l>ring_start && l<=ring_start+ring_size) 
		COLOR.a = l;
	if (l>ring_start+ring_size)
		COLOR.a = 0.0;
}