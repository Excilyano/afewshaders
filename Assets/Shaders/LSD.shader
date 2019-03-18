Shader "Unlit/LSD"
{
    Properties
	{
		_MainTex("Texture", 2D) = "white" {}
        _Speed("Speed", Float) = 1
	}

	SubShader
	{

		Pass
		{
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
            float _Speed;

			float4 frag(v2f i) : SV_Target
			{
                float r = .75 + (cos((i.uv.r - _Time.y) * _Speed) /4);
                float g = .75 + (sin((i.uv.g - _Time.w) * _Speed) /4);
                float b = 1-r;
				float4 color = float4(r, g, 0, .5) * tex2D(_MainTex, i.uv);
				return color;
			}
			ENDCG
		}
	}
}
