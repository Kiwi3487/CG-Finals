Shader "Custom/RainbowShader"
{
    Properties
    {
        _ColorRed("Red",Range(0,255)) = 255
        _ColorBlue("Blue",Range(0,255)) = 255
        _ColorGreen("Green",Range(0,255)) = 255
        
                // Color of the outline drawn around the object
        _OutlineColor ("Outline Color", Color) = (0, 0, 0, 1)

        // Thickness of the outline drawn around the object
        _OutlineThickness ("Outline Thickness", Float) = 0.03
        
    }
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            
            sampler2D _MainTex;

            float _ColorRed;
            float _ColorBlue;
            float _ColorGreen;
            
            struct appdata
            {
                float4 vertex : POSITION;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float4 color: COLOR;
            };
            v2f vert (appdata v)
            {
                v2f o;
                UNITY_INITIALIZE_OUTPUT(v2f, o)
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.color.r = (v.vertex.y + _ColorRed)/255;
                o.color.b = (v.vertex.y + _ColorBlue)/255;
                o.color.g = (v.vertex.y + _ColorGreen)/255;
                return o;
            }
            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = i.color;
                return col;
            }
            ENDCG
        }
        Pass
        {
            // Define this pass as "Outline" for rendering around the object
            Name "Outline"

            // Set LightMode to "Always" so it renders in every lighting pass
            Tags { "LightMode" = "Always" }

            // Cull front faces to draw only the back-facing geometry, creating an outline
            Cull Front

            // Enable depth writing
            ZWrite On

            // Only write to RGB channels, excluding alpha
            ColorMask RGB

            // Begin CG shader code for the outline
            CGPROGRAM
            #pragma vertex vert       // Vertex shader for expanding vertices for the outline
            #pragma fragment frag     // Fragment shader for coloring the outline

            // Declare outline thickness and color
            uniform float _OutlineThickness;
            uniform float4 _OutlineColor;

            // Structure for vertex input data
            struct appdata
            {
                float4 vertex : POSITION; // Vertex position
                float3 normal : NORMAL;   // Normal for outline expansion
            };

            // Structure for data passed to the fragment shader
            struct v2f
            {
                float4 pos : SV_POSITION; // Position of the vertex in screen space
                float4 color : COLOR;     // Color of the outline
            };

            // Vertex shader to expand vertices outward by normal direction
            v2f vert(appdata v)
            {
                v2f o;
                // Calculate normal in world space
                float3 norm = normalize(mul((float3x3)unity_ObjectToWorld, v.normal));

                // Move vertex along its normal by the outline thickness
                o.pos = UnityObjectToClipPos(v.vertex + norm * _OutlineThickness);

                // Set outline color
                o.color = _OutlineColor;
                return o;
            }

            // Fragment shader to output the outline color
            float4 frag(v2f i) : SV_Target
            {
                return i.color;
            }
            ENDCG
        }
    }
}
