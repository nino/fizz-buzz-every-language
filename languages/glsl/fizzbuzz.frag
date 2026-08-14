// FizzBuzz in GLSL. Each row of pixels is one of the 100 results, encoded
// as a colour: red = Fizz, blue = Buzz, magenta = FizzBuzz, greyscale = n/100.
#version 330 core

out vec4 fragColor;
uniform vec2 uResolution;

void main() {
    int n = int(floor(gl_FragCoord.y / uResolution.y * 100.0)) + 1;

    bool fizz = (n % 3) == 0;
    bool buzz = (n % 5) == 0;

    if (fizz && buzz)      fragColor = vec4(1.0, 0.0, 1.0, 1.0);
    else if (fizz)         fragColor = vec4(1.0, 0.0, 0.0, 1.0);
    else if (buzz)         fragColor = vec4(0.0, 0.0, 1.0, 1.0);
    else                   fragColor = vec4(vec3(float(n) / 100.0), 1.0);
}
