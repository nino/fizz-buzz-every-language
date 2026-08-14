// FizzBuzz in HLSL as a compute shader.
// Writes a code per element: 0 = number, 1 = Fizz, 2 = Buzz, 3 = FizzBuzz.
RWStructuredBuffer<uint> Output : register(u0);

[numthreads(100, 1, 1)]
void CSMain(uint3 id : SV_DispatchThreadID)
{
    uint n = id.x + 1;
    if (n > 100) return;

    bool fizz = (n % 3) == 0;
    bool buzz = (n % 5) == 0;

    Output[id.x] = (fizz && buzz) ? 3 : (fizz ? 1 : (buzz ? 2 : 0));
}
