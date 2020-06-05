Shader "NathanLibrary/GlowShader"
{
	properties
	{
		_myColor ("myColor", Color) = (1,1,1,1)
		_myEmission("myEmission", Color) = (1,1,1,1)
		_myGlossiness("Smoothness", Range(0,1)) = 0.5		
		_myMetallic("Metallic", Range(0,1)) = 0.0
		_Curvature("Curvature", Float) = 0		
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		_LerpValue("Transition float", Range(0,1)) = 0.5
	}

	SubShader
	{
		CGPROGRAM

		#pragma surface surf Standard vertex:vert fullforwardshadows
		#pragma target 3.0

		struct Input 
		{
			float2 uv_MainTex;
		};

		sampler2D _MainTex;
		uniform float _Curvature;

		fixed4 _myColor;
		fixed4 _myEmission;		
		half _myGlossiness;
		half _myMetallic;
		float _LerpValue;
		
		void vert(inout appdata_full v)
		{			
			float4 vv = mul(unity_ObjectToWorld, v.vertex);
						
			vv.xyz -= _WorldSpaceCameraPos.xyz;
			
			vv = float4(0.0f, (vv.z * vv.z) * -_Curvature, 0.0f, 0.0f);
						
			v.vertex += mul(unity_WorldToObject, vv);
		}

			UNITY_INSTANCING_BUFFER_START(Props)
			// put more per-instance properties here
			UNITY_INSTANCING_BUFFER_END(Props)

		void surf (Input IN, inout SurfaceOutputStandard o)
		{	
			//fixed4 c = _myColor;
			fixed4 d = tex2D(_MainTex, IN.uv_MainTex) * _myColor;
			fixed4 col = lerp(2.0,8.0,_LerpValue);

			o.Albedo = d.rgb;
			o.Emission = _myEmission.rgb * col;
			o.Smoothness = _myGlossiness;
			o.Metallic = _myMetallic;
		}
		ENDCG
	}
		
	fallBack "Diffuse"
}
