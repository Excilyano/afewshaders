Shader "Unlit/RotationMatrix"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_Color("Color", Color) = (1,1,1,1)
        _Helices("Helices", Int) = 30
        _Rotation("Rotation", Float) = 0.0
		_RotationSpeed("Rotation Speed", Float) = 2.0
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


			sampler2D _MainTex;
            float4 _MainTex_TexelSize;
			float4 _Color;
            int _Helices;
            float _Rotation;
			float _RotationSpeed;

			v2f vert(appdata_full v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				float sinX = sin ( _Rotation + _RotationSpeed * _Time );
				float cosX = cos ( _Rotation + _RotationSpeed * _Time );
				float sinY = sin ( _Rotation + _RotationSpeed * _Time );
				float2x2 rotationMatrix = float2x2( cosX, -sinX, sinY, cosX);
				rotationMatrix *=0.5;
                rotationMatrix +=0.5;
                rotationMatrix = rotationMatrix * 2-1;
				o.uv = mul (v.texcoord.xy, rotationMatrix);
				return o;
			}

			float4 frag(v2f i) : SV_Target
			{
				float4 color = tex2D(_MainTex, i.uv) * _Color;
                return color;
			}
			ENDCG
		}
	}
}