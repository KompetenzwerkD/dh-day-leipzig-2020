shader_type spatial;

uniform vec4 albedo_color: hint_color;
uniform sampler2D noise_texture;
uniform float noise_scale = 1.f;
uniform float noise_strength = 1.0f;
uniform float time_scale = 0.1f;

void fragment () {
	vec4 noise = texture(noise_texture, UV*noise_scale + TIME * time_scale);
	//vec4 col = mix(albedo_color, noise, 0.7);
	vec4 col = albedo_color + noise * noise_strength;
	ALBEDO = col.rgb;
}