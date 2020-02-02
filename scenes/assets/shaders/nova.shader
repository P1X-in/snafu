shader_type canvas_item;
uniform vec4 color : hint_color;
uniform float uv_scale = 2.2;
uniform float ring_start = 0.97;
uniform float ring_size = 0.05;

void fragment() {
	vec2 uv = UV + vec2(-0.5);
	float l = length(uv*uv_scale);
	COLOR.rgb = textureLod(SCREEN_TEXTURE, SCREEN_UV, 1.0).rgb;
	COLOR.rgb *= color.rgb;
	COLOR.rgb += color.rgb;
	COLOR.a = 0.25 + smoothstep(0.0,1.7, l);
	if (l>ring_start && l<=ring_start+ring_size) 
		COLOR.a = smoothstep(ring_start+ring_size,ring_start,l);
	if (l>ring_start+ring_size)
		COLOR.a = 0.0;
}