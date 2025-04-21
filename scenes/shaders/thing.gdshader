shader_type canvas_item;

// Red tint and flicker parameters:
uniform float red_intensity: hint_range(0.0, 1.0) = 0.5;
uniform float pulse_speed: hint_range(0.0, 10.0) = 2.0;
uniform float flicker_range: hint_range(0.0, 1.0) = 0.2;

// Smooth distortion parameters:
uniform float distortion_strength: hint_range(0.0, 0.05) = 0.01;
uniform float distortion_speed: hint_range(0.0, 10.0) = 2.0;
uniform float noise_scale: hint_range(0.1, 10.0) = 2.0;

// Glitch (flitch) effect parameters:
uniform bool glitch_enabled = false; // Toggle the glitch effect on or off.
uniform float glitch_strength: hint_range(0.0, 0.1) = 0.05;
uniform float glitch_frequency: hint_range(0.0, 10.0) = 5.0;

// --- Utility functions ---

// A simple random generator based on the input vector.
float random(vec2 st) {
    return fract(sin(dot(st, vec2(12.9898, 78.233))) * 43758.5453123);
}

// A basic 2D noise function that interpolates between random values.
float noise(vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);

    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));

    vec2 u = f * f * (3.0 - 2.0 * f);
    return mix(a, b, u.x) + (c - a) * u.y * (1.0 - u.x) + (d - b) * u.x * u.y;
}

void fragment() {
    // --- Distortion ---
    // Create a dynamic distortion by offsetting the UV coordinates based on noise.
    vec2 distorted_uv = UV;
    vec2 noise_input = UV * noise_scale + TIME * distortion_speed;
    float n = noise(noise_input);
    distorted_uv += distortion_strength * vec2(n, n);

    // --- Glitch (Flitch) Effect ---
    // If the glitch effect is enabled, add an intermittent horizontal offset on certain scanlines.
    if (glitch_enabled) {
        float glitch_factor = fract(sin(UV.y * glitch_frequency + TIME * glitch_frequency) * 43758.5453123);
        // Trigger the glitch on fragments with glitch_factor above a threshold (here, 0.9).
        if (glitch_factor > 0.9) {
            float glitch_offset = glitch_strength * (fract(sin(UV.y * 100.0 + TIME * 5.0) * 43758.5453123) - 0.5);
            distorted_uv.x += glitch_offset;
        }
    }

    // --- Texture Sampling ---
    // Sample the sprite's texture using the modified (distorted) UV coordinates.
    vec4 tex_color = texture(TEXTURE, distorted_uv);

    // --- Red Tint & Flicker ---
    // Animate the red tint intensity over time using a sine function.
    float animated_intensity = red_intensity + flicker_range * sin(TIME * pulse_speed);
    vec3 enemy_color = mix(tex_color.rgb, vec3(0.0, 1.0, 1.0), animated_intensity);

    // Output the final color, preserving the original alpha.
    COLOR = vec4(enemy_color, tex_color.a);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
