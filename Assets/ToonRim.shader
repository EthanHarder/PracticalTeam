Shader "Sorcery/ToonRimFlashing"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _RampTex ("Ramp Texture", 2D) = "white" {}
        _RimColor ("Rim Color", Color) = (0,0.5,0.5,0.0)
        _RimPower ("Rim Power", Range(0.1,8.0)) = 3.0

        [MaterialToggle] _doFlash ("flashing", float) = 0

        _Amount ("Extrude", Range(-1,5)) = 0.001
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf ToonRamp vertex:vert

        struct Input
        {
            float3 viewDir;
            float2 uv_MainTex;
        };

        float4 _Color;
        float4 _RimColor;
        float _RimPower;
        float _doFlash;
        float _Amount;
        sampler2D _RampTex;

        float4 LightingToonRamp (SurfaceOutput s, fixed3 lightDir, fixed atten)
        {
            float diff = dot (s.Normal, lightDir);
            float h = diff * 0.5 + 0.5;
            float2 rh = h;
            float3 ramp = tex2D(_RampTex, rh).rgb;

            float4 c;
            c.rgb = s.Albedo * _LightColor0.rgb * (ramp);
            c.a = s.Alpha;

            
            return c;
        }

        struct appdata
        {
            float4 vertex: POSITION;
            float3 normal: NORMAL;
            float4 texcoord: TEXCOORD0;
        };

        void vert (inout appdata v) {
            if (_doFlash)
            {
                v.vertex.xyz += v.normal * abs(_Amount * sin(_Time.z * 5)) / 100;
            }
        }

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = _Color.rgb;

            half rim = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));
            if (_doFlash)
            o.Emission = _RimColor.rgb * pow (rim, _RimPower * sin(_Time.z * 5));
        }
        ENDCG
    }
    FallBack "Diffuse"
}
