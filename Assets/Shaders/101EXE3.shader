Shader "Custom/101EXE3"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
        _SecondTex("Second Texture", 2D) = "white" {}
		_Tween("Tween", Range(0,1)) = 0
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
            sampler2D _SecondTex;
            float _Tween;

			float4 frag(v2f i) : SV_Target
			{
				float4 color = _Tween * tex2D(_MainTex, i.uv) + (1 - _Tween) * tex2D(_SecondTex, i.uv);
				return color;
			}
			ENDCG
		}
	}
}