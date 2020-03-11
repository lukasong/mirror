//shader author: luka, also known as "luka!" in game, or luka#8375 on Discord
//files not for resale, redistribution, etc etc
//by USING or OWNING this shader file, you agree to these terms
bool mirrorCheck()
{
	return unity_CameraProjection[2][0] != 0.f || unity_CameraProjection[2][1] != 0.f;
}

float3 rainbowHSV2RGB(float3 c)
{
	float3 rgb = clamp(abs(fmod(c.x*6.0 + float3(0.0, 4.0, 2.0), 6.0) - 3.0) - 1.0, 0.0, 1.0);
	rgb = rgb * rgb*(3.0 - 2.0*rgb);
	return c.z * lerp(float3(1.0, 1.0, 1.0), rgb, c.y);
}