Shader "Unlit/Wind"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Light ("Light level", Float) = 1.2
        _Speed ("Speed", Float) = 1
        _Amplitude ("Amplitude", Range(0,5)) = .5
    }
    SubShader
    {
        Tags
		{
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
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _Light;
            float _Speed;
            float _Amplitude;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex) + float4(v.uv.g * cos(_Time.x * _Speed) * _Amplitude/100, 0,0,0);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv) * _Light;
                return col;
            }
            ENDCG
        }
    }
}
