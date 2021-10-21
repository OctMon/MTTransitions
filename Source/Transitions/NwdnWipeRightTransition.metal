#include <metal_stdlib>
#include "MTIShaderLib.h"
#include "MTTransitionLib.h"

using namespace metalpetal;

float2 simple_zoom2(float2 uv, float amount) {
    return 0.5 + ((uv - 0.5) * (0.74+amount));
}

fragment float4 NwdnWipeRightFragment(VertexOut vertexIn [[ stage_in ]],
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
    float2 p = uv.xy/float2(1.0).xy;
    float4 a = getFromColor(simple_zoom2(uv, smoothstep(0.0, nQuick, progress/3.0)), fromTexture, ratio, _fromR);
    float4 b = getToColor(simple_zoom2(uv, smoothstep(0.0, nQuick, progress/3.0)), toTexture, ratio, _toR);
    return mix(a, b, step(0.0 + p.x, progress));
}
