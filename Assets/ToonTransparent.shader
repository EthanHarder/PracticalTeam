Shader "Sorcery/ToonTransparent"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}

        _Ramp ("Ramp", 2D) = "white" {}

        [MaterialToggle] _DoToon ("DoToon", float) = 0
        [MaterialToggle] _DoAlpha ("DoAlpha", float) = 0
        
    }
    SubShader
    {
        Tags { "Queue" = "Transparent" }
        
        CGPROGRAM
        
        #pragma surface surf ToonShaderPanic alpha:fade


        sampler2D _MainTex;
        sampler2D _Ramp;

        struct Input
        {
            float2 uv_MainTex;
        };
        fixed4 _Color;


        float _DoToon;
        float _DoAlpha;



        float4 LightingToonShaderPanic (SurfaceOutput s, fixed3 lightDir, fixed atten)
        {
            float diff = dot (s.Normal, lightDir);
            float h = diff * 0.5 + 0.5;
            float2 rh = h;
            float4 ramp = tex2D(_Ramp, rh);

            float4 c;
            if (_DoToon) 
            {
                c.rgb = s.Albedo * _LightColor0.rgb * (ramp.rgb);
            }
            else
            {
                c.rgb = s.Albedo;
            }

            if (_DoAlpha) 
            {
                c.a = s.Alpha * ramp.a;
            }
            else
            {
                c.a = 1;
            }
            //c.a = 1;
            return c;
        }
      
        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D(_MainTex,IN.uv_MainTex);
            o.Albedo = c.rgb * _Color.rgb;
            o.Alpha = 1;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
