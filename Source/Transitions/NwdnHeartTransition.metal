#include <metal_stdlib>
#include "MTIShaderLib.h"
#include "MTTransitionLib.h"

using namespace metalpetal;

float2 simple_zoom4(float2 uv, float amount) {
    return 0.5 + ((uv - 0.5) * (1.0-amount));
}

float in_heart(float2 p, float2 center, float size) {
    if (size == 0.0) {
        return 0.0;
    }
    float2 o = (p-center)/(1.0*size);
    float a = o.x*o.x+o.y*o.y-1.0;
    return step(a*a*a, o.x*o.x*o.y*o.y*o.y);
}

fragment float4 NwdnHeartFragment(VertexOut vertexIn [[ stage_in ]],
                              texture2d<float, access::sample> fromTexture [[ texture(0) ]],
                              texture2d<float, access::sample> toTexture [[ texture(1) ]],
                              constant float & ratio [[ buffer(0) ]],
                              constant float & progress [[ buffer(1) ]],
                              sampler textureSampler [[ sampler(0) ]])
{
    float2 uv = vertexIn.textureCoordinate;
    uv.y = 1.0 - uv.y;
    float _fromR = float(fromTexture.get_width())/float(fromTexture.get_height());
    float _toR = float(toTexture.get_width())/float(toTexture.get_height());
    
    float nQuick = clamp(1.0,0.1,1.0);
    float2 factor = float2(1.0, _toR);
    float2 p = uv.xy / factor.xy;
    float2 centerH = float2(0.5, 0.4) / factor;
    
    return mix(getFromColor(simple_zoom4(uv, smoothstep(0.0, nQuick, progress/4.0)), fromTexture, ratio, _fromR),
               getToColor(simple_zoom4(uv, smoothstep(0.0, nQuick, progress/4.0)), toTexture, ratio, _toR),
               in_heart(p, centerH, progress)
               );
}
