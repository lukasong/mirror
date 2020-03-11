//shader author: luka, also known as "luka!" in game, or luka#8375 on Discord
//files not for resale, redistribution, etc etc
//by USING or OWNING this shader file, you agree to these terms
Shader "Luka/MirrorMirror"
{
	Properties
	{

		//header
		[Space(5)]
		[Header(Mirror Mirror)]
		[Header(described as very powerful)]
		//header

		//start rendering settings
		[Space(30)]
		[Header(Rendering Settings)]
		[Enum(Off,0,Front,1,Back,2)] _CullingMode ("Culling Mode", Int) = 2
		//[Enum(UnityEngine.Rendering.CompareFunction)] _ZTestMode ("ZTest Mode", Int) = 0
		//end rendering settings

		//start general settings
		[Space(30)]
		[Header(General Settings)]
		[MaterialToggle] _showInWorld ("Show model normally?", Float) = 1
		[MaterialToggle] _showInMirror ("Show model in mirrors?", Float) = 1
		//end general settings

		//space
		[Space(50)]
		//space

		//start normal settings
		[Header(Normal Settings)]
		_MainTex("Normal Texture", 2D) = "white" {}
		_MainScrollX ("Texture Horizontal Scroll", Range(-1.5, 1.5)) = 0
		_MainScrollY ("Texture Vertical Scroll", Range(-1.5, 1.5)) = 0
		_MainColor("Color Tint", Color) = (1, 1, 1, 1)
		[Space(30)]
		[MaterialToggle] _MainTexOverlayToggle ("Allow Normal Overlay?", Float) = 0
		_MainTexOverlay("Normal Overlay Texture", 2D) = "white" {}
		_MainOverlayTexFade ("Overlay Transparency", Range(0, 1)) = 0.5
		_MainTexOverlayScrollX("Overlay Horizontal Scroll", Range(-1.5, 1.5)) = 0
		_MainTexOverlayScrollY("Overlay Vertical Scroll", Range(-1.5, 1.5)) = 0
		[Space(30)]
		[MaterialToggle] _MainRainbowX ("Horizontal rainbow normally??", Float) = 0
		[MaterialToggle] _MainRainbowY ("Vertical rainbow normally?", Float) = 0
		_MainRainbowSpeed("Main rainbow speed", Range(0, 5.5)) = 0.25
		_MainRainbowSize ("Main rainbow size", Range(0.1, 0.75)) = 0.1
		[Space(30)]
		_MainSizeX ("Normal X Size", Range(0, 5)) = 1
		_MainSizeY ("Normal Y Size", Range(0, 5)) = 1
		_MainSizeZ ("Normal Scale", Range(0, 5)) = 1
		//end noraml settings

		//space
		[Space(50)]
		//space

		//start mirror settings
		[Header(Mirror Settings)]
		_MirrorTex ("Mirror Texture", 2D) = "white" {}
		_MirrorScrollX ("Texture Horizontal Scroll", Range(-1.5, 1.5)) = 0
		_MirrorScrollY ("Texture Vertical Scroll", Range(-1.5, 1.5)) = 0
		_MirrorColor("Mirror Color Tint", Color) = (1, 1, 1, 1)
		[Space(30)]
		[MaterialToggle] _MirrorTexOverlayToggle ("Allow Mirror Overlay?", Float) = 0
		_MirrorTexOverlay("Mirror Overlay Texture", 2D) = "white" {}
		_MirrorTexOverlayFade("Overlay Transparency", Range(0, 1)) = 0.5
		_MirrorTexOverlayScrollX("Overlay Horizontal Scroll", Range(-1.5, 1.5)) = 0
		_MirrorTexOverlayScrollY("Overlay Vertical Scroll", Range(-1.5, 1.5)) = 0
		[Space(30)]
		[MaterialToggle] _MirrorRainbowX("Horizontal rainbow in mirror?", Float) = 0
		[MaterialToggle] _MirrorRainbowY("Vertical rainbow in mirror?", Float) = 0
		_MirrorRainbowSpeed("Mirror rainbow speed", Range(0, 5.5)) = 0.25
		_MirrorRainbowSize("Mirror rainbow size",  Range(0.1, 0.75)) = 0.1
		[Space(30)]
		_MirrorSizeX("Mirror X Size", Range(0, 5)) = 1
		_MirrorSizeY("Mirror Y Size", Range(0, 5)) = 1
		_MirrorSizeZ("Mirror Scale", Range(0, 5)) = 1
		//end mirror settings

		//space
		[Space(30)]
		//space

		//footer
		[Space(5)]
		[Header(shader by luka 8375)]
		_WithLoveUWU ("with love uwu", Float) = 100
		//footer

	}

	//start subshader
	SubShader
	{

		//shader properties
		Tags { "RenderType" = "Queue" "Queue" = "Transparent+3000" "ForceNoShadowCasting" = "True" }
		LOD 100
		Blend SrcAlpha OneMinusSrcAlpha
		Cull [_CullMode]
		//ZTest[_ZTestMode]

		//startp ass
		Pass
		{

			//unity shader stuff
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag		
			#include "UnityCG.cginc"
			//end unity shader stuff

			//importing
			#include "CGIncludes/LukaMirrorFunctions.cginc"	



			//structures
			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};
			//end structures




			//declaring
			//general settings
			float _showInWorld, _showInMirror;

			//normal settings
			float _MainTexOverlayToggle, _MainOverlayTexFade, _MainTexOverlayScrollX, _MainTexOverlayScrollY, _MainRainbowX, _MainRainbowY, _MainRainbowSpeed, _MainSizeX, _MainSizeY, _MainSizeZ,
				_MainScrollY, _MainScrollX, _MainRainbowSize;

			//mirror settings
			float _MirrorTexOverlayToggle, _MirrorTexOverlayFade, _MirrorTexOverlayScrollX, _MirrorTexOverlayScrollY, _MirrorRainbowX, _MirrorRainbowY, _MirrorRainbowSpeed, _MirrorSizeX, _MirrorSizeY, _MirrorSizeZ, 
				_MirrorScrollY, _MirrorScrollX, _MirrorRainbowSize;

			//textures
			sampler2D _MainTex, _MainTexOverlay, _MirrorTex, _MirrorTexOverlay;
			float4 _MainTex_ST, _MainTexOverlay_ST, _MirrorTex_ST, _MirrorTexOverlay_ST;

			//colors
			float4 _MainColor, _MirrorColor;
			//end declaring








			//vertex
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);

				//out of mirror
				if (!mirrorCheck()) {
					//o.vertex.z *= _MainSizeZ;
					o.vertex = UnityObjectToClipPos(v.vertex * _MainSizeZ);
					o.vertex.x *= _MainSizeX;
					o.vertex.y *= _MainSizeY;
				}
				else {
				//in mirror 
					o.vertex = UnityObjectToClipPos(v.vertex * _MainSizeZ);
					o.vertex.x *= _MainSizeX;
					o.vertex.y *= _MainSizeY;
				}

				return o;
			}



			//fragment 
			fixed4 frag (v2f i) : SV_Target
			{



				//dont show in mirror 
				if (mirrorCheck() && !_showInMirror) {
					float4 noShow = tex2D(_MainTex, i.uv);
					clip(noShow.a - 10);
					return noShow;
				}

				//dont show in world 
				if (!mirrorCheck() && !_showInWorld) {
					float4 noShow = tex2D(_MainTex, i.uv);
					clip(noShow.a - 10);
					return noShow;
				}

				//start always returning both



				//out of mirror
				if (!mirrorCheck()) {

					//setting up uv
					float xScroll = (_Time.y * _MainScrollX);
					float yScroll = (_Time.y * _MainScrollY);
					float2 appendScrollUV = float2(xScroll, yScroll);
					float2 mainUVs = i.uv;
					mainUVs += appendScrollUV;

					//setting up texture
					float4 mainTexture = tex2D(_MainTex, mainUVs);

					//applying color
					mainTexture *= _MainColor;

					//overlay?
					if (_MainTexOverlayToggle) {

						//setting up uv
						float oxScroll = (_Time.y * _MainTexOverlayScrollX);
						float oyScroll = (_Time.y * _MainTexOverlayScrollY);
						float2 appendOverlayScrollUV = float2(oxScroll, oyScroll);
						float2 overlayUVs = i.uv;
						overlayUVs += appendOverlayScrollUV;

						//setting up texture
						float4 overlayTexture = tex2D(_MainTexOverlay, overlayUVs);

						//applying overlay							
						mainTexture = lerp(mainTexture, max(mainTexture, overlayTexture), _MainOverlayTexFade);

					}

					//:rainbowDance:
					if (_MainRainbowX || _MainRainbowY) {
						float hueMod = _Time.y*_MainRainbowSpeed; //set up time
						hueMod += (i.uv.x*_MainRainbowX); //vertical multiplier
						hueMod += (i.uv.y*_MainRainbowY); //horizontal multiplier
						hueMod *= _MainRainbowSize;
						float3 hsvColor = rainbowHSV2RGB(float3(hueMod, 1, 1));
						mainTexture.rgb *= hsvColor;
					}

					//returning out of mirror
					return mainTexture;


				}
				//in a mirror
				else
				{

					//setting up uv
					float xScroll = (_Time.y * _MirrorScrollX);
					float yScroll = (_Time.y * _MirrorScrollY);
					float2 appendScrollUV = float2(xScroll, yScroll);
					float2 mirrorUVs = i.uv;
					mirrorUVs += appendScrollUV;

					//setting up texture
					float4 mirrorTexture = tex2D(_MirrorTex, mirrorUVs);

					//applying color
					mirrorTexture *= _MirrorColor;

					//overlay?
					if (_MirrorTexOverlayToggle) {

						//setting up uv
						float oxScroll = (_Time.y * _MirrorTexOverlayScrollX);
						float oyScroll = (_Time.y * _MirrorTexOverlayScrollY);
						float2 appendOverlayScrollUV = float2(oxScroll, oyScroll);
						float2 overlayUVs = i.uv;
						overlayUVs += appendOverlayScrollUV;

						//setting up texture
						float4 mirrorOverlayTexture = tex2D(_MirrorTexOverlay, overlayUVs);

						//applying overlay							
						mirrorTexture = lerp(mirrorTexture, max(mirrorTexture, mirrorOverlayTexture), _MirrorTexOverlayFade);

					}

					//:rainbowDance:
					if (_MirrorRainbowX || _MirrorRainbowY) {
						float hueMod = _Time.y*_MirrorRainbowSpeed; //set up time
						hueMod += (i.uv.x*_MirrorRainbowX); //vertical multiplier
						hueMod += (i.uv.y*_MirrorRainbowY); //horizontal multiplier
						hueMod *= _MirrorRainbowSize;
						float3 hsvColor = rainbowHSV2RGB(float3(hueMod, 1, 1));
						mirrorTexture.rgb *= hsvColor;
					}

					//returning out of mirror
					return mirrorTexture;

				}

				//return noShow;

			

				//end frag below here !
			}







			ENDCG
		}
		//end pass

	}
	//end subshader


//made by luka, with love <3
}
//end shader