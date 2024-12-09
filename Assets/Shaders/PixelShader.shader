Shader "Custom/PixelationShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _PixelDensity ("Pixel Density", Float) = 10.0
        _AspectRatioMultiplier ("Aspect Ratio Multiplier", Vector) = (1, 1, 1, 1)
    }

    SubShader
    {
        Cull Off Zwrite Off Ztest Always
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            // Texture Sampler
            sampler2D _MainTex;
            float _PixelDensity;
            float2 _AspectRatioMultiplier;

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

            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                // Calculate pixelated UVs
                float2 pixelatedUV = floor(i.uv * _PixelDensity) / _PixelDensity;
                // Adjust for aspect ratio if necessary
                pixelatedUV *= _AspectRatioMultiplier;
                return tex2D(_MainTex, pixelatedUV);
            }
            ENDCG
        }
    }

    FallBack "Diffuse"
}
