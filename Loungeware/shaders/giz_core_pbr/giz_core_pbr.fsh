varying vec3		v_Normal;
varying vec2		v_UV;
varying vec3		v_Position;
varying mat3		v_TBN;
varying float		v_vRim;
varying vec3		v_vEyeVec;

uniform vec3		u_campos;
uniform vec3		u_sundir;
uniform vec3		u_suncol;
uniform sampler2D	s_metalrough;
uniform sampler2D	s_emission;
uniform sampler2D	s_normal;
uniform sampler2D	s_skybox;
uniform sampler2D	s_brdf;

uniform vec4		u_emission_uvs;
uniform vec4		u_normal_uvs;
uniform vec4		u_skybox_uvs;
uniform vec4		u_brdf_uvs;

const float PI = 3.141592653589793;
const float PI2 = PI * 2.0;

vec2 calculate_uvs(vec4 inUvs){
	return vec2(v_UV*inUvs.zw+inUvs.xy);	
}

/// MICROFACET DISTRIBUTION
float microfacetDistribution(float cos_theta, float rough_sqr) {
    float rough_quad = rough_sqr * rough_sqr;
    float cos_sqr = cos_theta * cos_theta;
    float k = cos_sqr * rough_quad + (1.0 - cos_sqr);
    return rough_quad / ( PI * k * k );
}

/// GEOMETRIC OCCLUSION
float geometricOcclusion(float cos_theta, float rough_sqr) {
    float cos_sqr = cos_theta * cos_theta;
    float tan2 = ( 1. - cos_sqr ) / cos_sqr;
    float geom = 2. / ( 1. + sqrt( 1. + rough_sqr * rough_sqr * tan2 ) );
    return geom;
}

/// SPECULAR REFLECTION
vec3 specularReflection(float VH, vec3 reflectance0, vec3 reflectance90)
{
    return reflectance0 + (reflectance90 - reflectance0) * pow(clamp(1.0 - VH, 0.0, 1.0), 5.0);
}

/// SRGB TO LINEAR
vec4 srgb_to_linear( vec4 srgbIn )
{
    vec3 linOut = pow(srgbIn.rgb, vec3(2.2));
    return vec4( linOut, srgbIn.a );
}

/// return uv for environment map using ray
vec2 envMapEquirect( vec3 ray ) {
  return vec2((atan(ray.z, ray.x) / PI2 ) + 0.5, 1.0 - acos(ray.y) / PI );
}

/// return IBL contribution
vec3 getIBLContribution(float roughness, float NV, vec3 in_diff, vec3 in_spec, vec3 n, vec3 reflection)
{
    float lod = floor( roughness * 7.0 );
    float spec_off = 1.0 - pow( 2.0, -lod );
    vec3 brdf = srgb_to_linear(texture2D(s_brdf, vec2( NV, 1.0 - roughness )*u_brdf_uvs.zw+u_brdf_uvs.xy)).rgb;
    vec2 diff_uv = envMapEquirect( -n );
    diff_uv = clamp( diff_uv, .01, .99 );
    diff_uv = ( diff_uv * vec2( 1.0, 0.5 ) + 1.0 ) * .5;
    vec2 spec_uv = envMapEquirect( -reflection );
    spec_uv *= pow( 2.0, -lod );
    float uv_offset = mix(.001,.009, roughness );
    spec_uv = clamp( spec_uv, uv_offset, 1.0 - uv_offset );
    spec_uv.t = spec_uv.t * .5 + spec_off;
    vec3 diffuseLight = srgb_to_linear( texture2D(s_skybox, diff_uv * u_skybox_uvs.zw+u_skybox_uvs.xy ) ).rgb;
    vec3 specularLight = srgb_to_linear( texture2D(s_skybox, spec_uv * u_skybox_uvs.zw+u_skybox_uvs.xy ) ).rgb;
	
    vec3 diffuse_clr = diffuseLight * in_diff;
    vec3 specular_clr = specularLight * ( in_spec * brdf.x + brdf.y);
    
    return diffuse_clr + specular_clr;
}

/// calculate normal
vec3 getNormal()
{
    vec3 n = texture2D( s_normal, calculate_uvs(u_normal_uvs) ).rgb * 2. - 1.;
    n = normalize( v_TBN * n );
    return n;
}

void main()
{
    vec4  metalrough	= texture2D(s_metalrough, v_UV );
    float roughness		= clamp(metalrough.g, 0.05, 0.95);
    float metallic		= clamp(metalrough.b, 0.0, 1.0);
    float rough_sqr		= roughness * roughness;
    
    vec4 baseColor		= srgb_to_linear( texture2D( gm_BaseTexture, v_UV ) );
    vec3 f0				= vec3(0.04);
    vec3 diffuseColor	= baseColor.rgb;
    diffuseColor		*= 1.0 - metallic;
    vec3 specularColor	= mix(f0, baseColor.rgb, metallic);
    float reflectance	= max(max(specularColor.r, specularColor.g), specularColor.b);
    float reflectance90 = clamp(reflectance * 25.0, 0.0, 1.0);
	
    vec3 specularEnvironmentR0	= specularColor.rgb;
    vec3 specularEnvironmentR90 = vec3(reflectance90);
    
    vec3 n = getNormal();
    vec3 v = normalize(u_campos - v_Position);
    vec3 l = normalize(u_sundir);
    vec3 h = normalize( v + l );
    vec3 reflection = normalize(reflect(v, n));
    float NL = clamp(dot(n, l), 0.01, 1.0);
    float NV = abs(dot(n, v)) + 0.001;
    float NH = clamp(dot(n, h), 0.0, 1.0);
    float VH = clamp(dot(v, h), 0.0, 1.0);
    
    vec3  F = specularReflection( VH, specularEnvironmentR0, specularEnvironmentR90 );
    float G = geometricOcclusion( NV, rough_sqr) * geometricOcclusion( NL, rough_sqr);
    float D = microfacetDistribution( NH, rough_sqr);

    vec3 diffuseContrib = (1.0 - F) * diffuseColor / PI;
    vec3 specContrib = F * G * D / (4.0 * NL * NV);
    vec3 clr = (diffuseContrib + specContrib);
	
    /// IBL
    clr += getIBLContribution( roughness, NV, diffuseColor, specularColor, n, reflection) * ( 1. - roughness );
	
	/// SUN COLOR
	clr *= NL * u_suncol;
    
    /// AMBIENT OCLUSION
    clr *= metalrough.r;
    
    /// EMISSION
    clr += srgb_to_linear(texture2D(s_emission, calculate_uvs(u_emission_uvs))).rgb;
    
    /// FINAL COLOR REINHARD
    gl_FragColor = vec4( pow(clr,vec3(1.0/2.2)), 1.0 );
		
	//Rim lighting
	gl_FragColor.rgb += .2 * vec3(pow(1. + v_vRim, 2.));

}