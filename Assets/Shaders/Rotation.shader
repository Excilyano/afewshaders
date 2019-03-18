Shader "Unlit/Rotation"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_Color("Color", Color) = (1,1,1,1)
        _Helices("Helices", Int) = 1
        _Rotation("Rotation", Float) = 0
	}

	SubShader
	{
		Tags
		{
			"Queue" = "Transparent"
			"PreviewType" = "Plane"
		}

		Pass
		{
			Blend SrcAlpha OneMinusSrcAlpha

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
			};

			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}

			sampler2D _MainTex;
            float4 _MainTex_TexelSize;
			float4 _Color;
            int _Helices;
            float _Rotation;


			float4 frag(v2f i) : SV_Target
			{
				int scalar = _MainTex_TexelSize.z * i.uv.y / _Helices;
				//int scalar = 1;
                float4 color = float4(0,0,0,0);
                    color = tex2D(  _MainTex,
                                    float2(.5 - (.5 - i.uv.x) / (cos(_Rotation * scalar + _Time.w)), i.uv.y)) * _Color;
                return color;
			}
			/*
			float4 frag(v2f i) : SV_Target
			{
                float4 color = float4(0,0,0,0);
                    color = tex2D(  _MainTex,
                                    float2(.5 - (.5 - i.uv.x) / (cos(_Rotation + i.uv.y + _Time.w)), i.uv.y)) * _Color;
                return color;
			}
			*/
			ENDCG 
		}
	}
}