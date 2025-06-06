Shader "Unlit/VideoAlphaBlend"
{
    Properties
    {
        _MainTex ("RGB Texture", 2D) = "white" {}
        _AlphaTex ("Alpha Texture", 2D) = "black" {}
    }
    SubShader
    {
        Tags { "Queue"="Transparent" "RenderType"="Transparent" }
        LOD 100

        Pass
        {
            Blend SrcAlpha OneMinusSrcAlpha
            ZWrite Off
            Cull Off
            

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            sampler2D _MainTex;
            sampler2D _AlphaTex;
            float4 _MainTex_ST;

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

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float4 rgb = tex2D(_MainTex, i.uv);
                float alpha = tex2D(_AlphaTex, i.uv).r;
                return float4(rgb.rgb, alpha);
            }
            ENDCG
        }
    }
}