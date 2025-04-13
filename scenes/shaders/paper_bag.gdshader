shader_type canvas_item;

uniform float amplitude : hint_range(0, 30) = 20.0;
uniform float frequency : hint_range(0, 20) = 10.0;
uniform float speed : hint_range(0, 10) = 5.0;

void fragment() {
    // Start with the original UV
    vec2 distorted_uv = UV;

    // Apply a subtle wave
    // Here, we displace the UV vertically based on a sine wave that depends on x
    distorted_uv.y += sin(UV.x * frequency + TIME * speed) * (amplitude / 100.0);

    // Use the newly distorted UV to sample the texture
    COLOR = texture(TEXTURE, distorted_uv);
}