Shader "Unlit/DynamicColorMaterial"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _LightPos ("Light Position", Vector) = (0.23,1.06,-0.15,0.57) // inspector üzerinden ayarlanabilir
        _CameraPos ("Camera Position", Vector) = (0.43,0.58,0.63,0.36) // inspector üzerinden ayarlanabilir.
         _Color1 ("Color 1", Color) = (0,0,1,1) // Mavi renk
        _Color2 ("Color 2", Color) = (1,0,0,1) // Kýrmýzý renk
        _NormalMap ("Normal Map", 2D) = "bump" {}
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _MainTex;
        sampler2D _NormalMap;
        fixed4 _Color1;
        fixed4 _Color2;
        fixed3 _LightPos;
        fixed3 _CameraPos;

        struct Input
        {
            float2 uv_MainTex;
            float3 worldNormal;
            float3 worldPos;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed3 normalMap = tex2D(_NormalMap, IN.uv_MainTex).rgb * 2.0 - 1.0;
            normalMap = normalize(normalMap);

            fixed3 lightDir = normalize(_LightPos - IN.worldPos);
            fixed3 viewDir = normalize(_CameraPos - IN.worldPos);

            fixed diff = max(0.0, dot(normalMap, lightDir));
            o.Albedo = _Color1.rgb * diff;

            fixed3 colorTransition = lerp(_Color1.rgb, _Color2.rgb, saturate(dot(normalize(normalMap + viewDir), normalMap)));
            o.Albedo = lerp(o.Albedo, colorTransition, 0.5);
            
            o.Alpha = 1.0;
        }
        ENDCG
    }

    FallBack "Diffuse"
}
