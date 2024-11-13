Shader "Sorcery/RimLighting"
{
    Properties
    {
        _RimColor("Rim Colour", Color) = (0,0.5,0.5,0.0)
        

        [MaterialToggle] _Inverse ("Inverse Rim", float) = 0
        _RimPower("Rim Power", Range(0.5,8.0)) = 3.0
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        struct Input {
            float3 viewDir;
        };


        float4 _RimColor;
        float _RimPower;
        float _Inverse;
        void surf (Input IN, inout SurfaceOutput o) {
            if (!_Inverse)
            {
            half rim = dot (normalize(IN.viewDir), o.Normal);

            o.Emission = _RimColor.rgb * pow(rim, _RimPower);
            }
            else
            {
                half rim = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));
                o.Emission = _RimColor.rgb * pow(rim, _RimPower);
            }
        }
        ENDCG
    }
    FallBack "Diffuse"
}
