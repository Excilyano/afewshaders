Shader "Unlit/TimeBlur"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Tween("Pixels", Int) = 15
    }
    SubShader
    {
        Tags {
                "RenderType"="Opaque" }

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
            float4 _MainTex_TexelSize;
            float4 _MainTex_ST;
            int _Tween;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 gauss (sampler2D tex, float2 pos, float4 texel) {
                int i, j;
                if(_Tween > 30) _Tween = 30;
                float quot = 3 * _Tween;
                float ratio = quot;

                fixed4 sum = quot * tex2D(tex, pos);

                for(i = 0; i < _Tween; i++) {
                    quot = quot*(abs(_SinTime.w));
                    for(j = 0; j <= i; ) {
                        j++;
                        sum += quot * tex2D(tex, pos + float2((i-j)*texel.x, (i-j)*texel.y));
                        sum += quot * tex2D(tex, pos + float2((i-j)*texel.x, (j-i)*texel.y));
                        sum += quot * tex2D(tex, pos + float2((j-i)*texel.x, (i-j)*texel.y));
                        sum += quot * tex2D(tex, pos + float2((j-i)*texel.x, (j-i)*texel.y));
                        ratio += 4*quot;
                    }
                }
                return sum/ratio;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = gauss(_MainTex, i.uv, _MainTex_TexelSize);
                return col;
            }
            ENDCG
        }
    }
}
