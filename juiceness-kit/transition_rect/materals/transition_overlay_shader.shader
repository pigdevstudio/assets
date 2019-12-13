shader_type canvas_item;

uniform sampler2D transition_texture: hint_albedo;
uniform float cutoff: hint_range(0.0, 1.0);
uniform float smooth_percent : hint_range(0.0, 1.0);

void fragment()
{
	float value = texture(transition_texture, UV).r;
	float alpha = smoothstep(cutoff, cutoff + smooth_percent, 
			value * (1.0 - smooth_percent) + smooth_percent);
	COLOR = vec4(COLOR.rgb, alpha);
}