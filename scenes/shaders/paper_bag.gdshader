shader_type canvas_item;

uniform float amplitude : hint_range(0, 30) = 20.0;
uniform float frequency : hint_range(0, 20) = 10.0;
uniform float speed : hint_range(0, 10) = 5.0;

varying vec4 v_modulate;

void vertex() {
    // COLOR here already includes sprite.modulate (and any CanvasModulate)
    v_modulate = COLOR;
}

void fragment() {
    // Start with the original UV
    vec2 distorted_uv = UV;

    // Apply a subtle wave
    // Here, we displace the UV vertically based on a sine wave that depends on x
    distorted_uv.y += sin(UV.x * frequency + TIME * speed) * (amplitude / 100.0);

	// Sample the texture at the distorted coordinates
    vec4 tex_color = texture(TEXTURE, distorted_uv);

    // Reapply the original tint
    COLOR = tex_color * v_modulate;
}