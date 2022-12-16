#pragma header

// ---- gllock required fields -----------------------------------------------------------------------------------------
float RATE = 0.75;

uniform float time = 0;
uniform float end;
uniform sampler2D imageData;
uniform vec2 screenSize;
// ---------------------------------------------------------------------------------------------------------------------

float rand(vec2 co){
  return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453) * 2.0 - 1.0;
}

float offset(float blocks, vec2 uv) {
  float shaderTime = time*RATE;
  return rand(vec2(shaderTime, floor(uv.y * blocks)));
}

void main(void) {
  vec2 uv = openfl_TextureCoordv;
  gl_FragColor = flixel_texture2D(bitmap, uv);
  gl_FragColor.r = flixel_texture2D(bitmap, uv + vec2(offset(64.0, uv) * 0.03, 0.0)).r;
  gl_FragColor.g = flixel_texture2D(bitmap, uv + vec2(offset(64.0, uv) * 0.03 * 0.16666666, 0.0)).g;
  gl_FragColor.b = flixel_texture2D(bitmap, uv + vec2(offset(64.0, uv) * 0.03, 0.0)).b;
}