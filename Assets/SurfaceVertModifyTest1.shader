Shader "Sorcery/VertExtrude"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Amount ("Extrude", Range(-1,30)) = 0.001
    }
    SubShader
    {
        Pass
        {
        CGPROGRAM
        
        #include "UnityCG.cginc"
        #pragma vertex vert
        #pragma fragment frag

        sampler2D _MainTex;
        float4 _MainTex_ST;
        float _Amount;

        struct Input
        {
            float2 uv_MainTex;
        };

        struct appdata
        {
            float4 vertex : POSITION; // Input vertex position
            float2 uv : TEXCOORD0;    // UV coordinates for texture sampling
        };

        struct v2f
        {
            float2 uv : TEXCOORD0;
            float4 vertex : SV_POSITION; // Output vertex position, system uses SV_POSITION
            float4 color : COLOR;        // Output color (for now, just set to a fixed value)
        };

        v2f vert (appdata v)
        {
            v2f o;
            // Transform the vertex position to clip space (camera space)
            o.vertex = UnityObjectToClipPos(v.vertex);
            // Apply the extrusion effect (modify the X position)
            o.vertex.x += _Amount * sin(_Time.z * 5) / 100;
            // Set the color to white (can later be modified or use a texture)
            o.color.rgb = 1;
            o.uv = TRANSFORM_TEX(v.uv, _MainTex);
            return o;
        }

        fixed4 frag (v2f i) : SV_Target
        {
    // Sample the texture (use i.uv_MainTex in the Input structure)
            fixed4 col = tex2D(_MainTex, i.uv);
            return col;
        }


        ENDCG
        }
    }
}
