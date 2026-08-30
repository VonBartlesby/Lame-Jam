shader_type canvas_item;
uniform sampler2D c;
uniform vec3 a: source_color;
uniform float a_p=0.1;
float fresnel(float amount, vec3 normal)
{
	return pow((1.0 - clamp(dot(normalize(normal), vec3(0.,0.,1.)), 0.0, 1.0 )), amount);
}
void light() {
	float cNdotL = max(0.0, dot(NORMAL, LIGHT_DIRECTION));
	cNdotL=1.+(cNdotL-1.)*(1.+float(LIGHT_IS_DIRECTIONAL));
	LIGHT = vec4(LIGHT_COLOR.rgb * COLOR.rgb * LIGHT_ENERGY * cNdotL , LIGHT_COLOR.a);
	float _cNdotL=texture(c,vec2(cNdotL)).r * float(!LIGHT_IS_DIRECTIONAL);
	LIGHT+=SPECULAR_SHININESS*_cNdotL*LIGHT_ENERGY;
	LIGHT+=vec4(a*fresnel(a_p,NORMAL),0.) * float(LIGHT_IS_DIRECTIONAL);
}
