// Define a custom shader named "EigthShader"
Shader "Custom/EigthShader"
{
    // Shader properties, exposed in the Inspector
    Properties
    {
        // Color tint that can be adjusted in the Inspector
        _Color ("Color", Color) = (1,1,1,1)

        // Metallic texture map where the red channel defines metallic intensity
        _MetallicTex ("Metallic (R)", 2D) = "white" {}

        // Metallic scalar value that can be adjusted between 0 and 1
        _Metallic ("Metallic", Range(0,1)) = 0.0
    }

    // SubShader containing the main rendering code
    SubShader
    {
        // Render queue specifies when the shader should be rendered, set to "Geometry" (default opaque objects)
        Tags
        {
            "Queue" = "Geometry"
        }

        // Begin CG shader code for a surface shader
        CGPROGRAM

        // Use the Standard lighting model for Physically Based Rendering (PBR)
        #pragma surface surf Standard

        // Declare shader variables to link with properties defined above
        sampler2D _MetallicTex; // Texture sampler for the metallic map
        half _Metallic;         // Metallic scalar value
        fixed4 _Color;          // Color tint for the surface

        // Input structure to hold UV coordinates for the metallic texture
        struct Input
        {
            float2 uv_MetallicTex; // UV coordinates for the metallic texture
        };

        // Surface function that sets surface properties for rendering
        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Set the Albedo (base color) using the color property
            o.Albedo = _Color.rgb;

            // Sample the metallic texture and use its red channel for smoothness
            o.Smoothness = tex2D (_MetallicTex, IN.uv_MetallicTex).r;

            // Set the Metallic value, combining the scalar with the texture
            o.Metallic = _Metallic;
        }
        // End CG shader code block
        ENDCG
    }
    FallBack "Diffuse"
}
