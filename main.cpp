#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <string.h>
#include <math.h>

#int N = 16;
#int ES = 2;
#define BIAS ((1 << (8 - 1)) - 1)

void extract_fields(uint16_t val, int *regime, int *exp, int *frac);
float construct_ieee_float(bool sign, int biased_exp, int frac);
float posit_to_float(uint16_t x);

int main() {
    uint16_t posit_value = 0b0100101010010001;
    float ieee_float = posit_to_float(posit_value);
    printf("Posit (es=%d): 0b", ES);
    for (int i = N - 1; i >= 0; i--) {
        printf("%d", (posit_value >> i) & 1);
    }
    printf(", IEEE 754 Float: %f\n", ieee_float);
    return 0;
}

void extract_fields(uint16_t val, int *regime, int *exp, int *frac) {
    int k = 0;
    while (k < (N - 1) && ((val >> (N - 2 - k)) & 1)) {
        k++;
    }

    *regime = (k > 0 ? k - 1 : -k);
    int regime_length = k + 1;
    int exp_length = ES;
    int frac_length = N - 1 - regime_length - exp_length;

    *exp = (val >> frac_length) & ((1 << exp_length) - 1);
    *frac = (val & ((1 << frac_length) - 1)) << (23 - frac_length); // Assuming IEEE 754 single precision float

    // Debug output
    printf("Regime: %d, Exp: %d, Frac: 0x%X\n", *regime, *exp, *frac);
}

float construct_ieee_float(bool sign, int biased_exp, int frac) {
    uint32_t ieee_int = (sign << 31) | ((biased_exp & 0xFF) << 23) | (frac & ((1 << 23) - 1));
    float ieee_float;
    memcpy(&ieee_float, &ieee_int, sizeof(ieee_float));
    return ieee_float;
}

float posit_to_float(uint16_t x) {
    // Step 1: Extract sign
    bool sign = (x >> (N - 1)) & 1;

    // Step 2: Extract value (magnitude)
    uint16_t val = x & ((1 << (N - 1)) - 1);

    // Step 3: Check if value is zero
    if (val == 0) {
        // Step 4: Return positive or negative zero based on sign
        return sign ? -0.0f : 0.0f;
    } else {
        // Step 9: Determine absolute value
        uint16_t abs_val = sign ? ((1 << (N - 1)) - 1) & ~val + 1 : val;

        // Step 13: Extract regime, exponent, fraction fields
        int regime, exp, frac;
        extract_fields(abs_val, &regime, &exp, &frac);

        // Step 14: Bias for IEEE float exponent
        int bias = BIAS;

        // Step 15: Calculate biased exponent
        int biased_exp = (regime * (1 << ES)) + exp + bias;

        // Debug output
        printf("Biased Exp: %d\n", biased_exp);

        // Step 16: Construct IEEE float
        float ieee_float = construct_ieee_float(sign, biased_exp, frac);

        // Step 17: Return IEEE float
        return ieee_float;
    }
}
