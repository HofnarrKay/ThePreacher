shader_type canvas_item;

const float maxShade = 0.7;
const float shadeStrength = 1.4;
const float alphaStart = 0.4;

void fragment(){
	float alpha = UV.y - alphaStart;
	if (alpha <= 0.0)
		alpha = 0.0;
	alpha *= shadeStrength;
	COLOR = vec4(0, 0, 0, alpha);
}