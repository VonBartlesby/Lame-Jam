shader_type canvas_item;

uniform sampler2D screenTex : hint_screen_texture, filter_nearest;
uniform sampler2D curve : repeat_disable, filter_linear;

void fragment() {
	float f = 0.2;
	vec2 uv_c = (vec2(.5)-UV);
	vec2 uv_c_s = REGION_RECT.xy + (uv_c / REGION_RECT.zw);
	float r_d = length(uv_c)*2.;
	float a = (1.-r_d)*50.;
	vec2 _uv=SCREEN_UV.xy;
	float c = texture(curve,vec2(r_d,0.)).r;
	_uv += (uv_c_s*c)*SCREEN_PIXEL_SIZE;
	vec3 col = texture(screenTex,_uv).xyz;
	col -= max((.8-r_d)*4.,0.);
	COLOR=vec4(col,a);
}
