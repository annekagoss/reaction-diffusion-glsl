#define FEED_RATE 0.05
#define KILL_RATE 0.062
#define DIFFUSION_COEFFICIENT vec2(1.0, 0.3)
#define PASSES = 4

struct Settings {
    float feedRate;
    float killRate;
    vec2 diffusionCoefficient;
    bool invert;
    int passes;
};

Settings settings = Settings(
    FEED_RATE,
    KILL_RATE,
    DIFFUSION_COEFFICIENT,
    false,
    4
);

Settings allDots = Settings(
    0.026,
    0.061,
    DIFFUSION_COEFFICIENT,
    false,
    4
);

Settings spiral = Settings(
    0.0085,
    0.04,
    DIFFUSION_COEFFICIENT,
    false,
    1
);

Settings mu1 = Settings(
    0.046,
    0.065,
    DIFFUSION_COEFFICIENT,
    false,
    4
);

Settings mu2 = Settings(
    0.058,
    0.065,
    DIFFUSION_COEFFICIENT,
    false,
    4
);

Settings xi1 = Settings(
    0.01,
    0.041,
    DIFFUSION_COEFFICIENT,
    false,
    4
);

Settings xi2 = Settings(
    0.014,
    0.047,
    DIFFUSION_COEFFICIENT,
    false,
    4
);

Settings pi1 = Settings(
    0.062,
    0.061,
    DIFFUSION_COEFFICIENT,
    false,
    4
);

Settings rho1 = Settings(
    0.09,
    0.059,
    vec2(1.0, 0.49),
    true,
    4
);

Settings spikeyBoi = Settings(
    0.05,
    0.062,
    vec2(1.0, 0.5),
    false,
    4
);

Settings getSettings() {
    return pi1;
}