#include <stdio.h>
#include <stdint.h>
#include <string.h>

// Function declarations
float posit_to_float(int n, int es, uint32_t x);
void extract_fields(int n, int es, uint32_t val, int *regime, int *exp, int *frac);
float construct_ieee_float(bool sign, int biased_exp, int frac);

// Main function
int main() {
    uint32_t posit_value = 0b11000111001110011110001110001110;

    int n = 32;
    int es = 2;
    float ieee_float = posit_to_float(n, es, posit_value);


    printf("Posit (es=%d): 0b", es);
    for (int i = n - 1; i >= 0; i--) {
        printf("%d", (posit_value >> i) & 1);
    }
    printf(", IEEE 754 Float: %f\n", ieee_float);
    return 0;

}

// Function definitions
float posit_to_float(int n, int es, uint32_t x) {
    bool sign = (x >> (n - 1)) & 1;
    uint32_t val = x & ((1u << (n - 1)) - 1);

    if (val == 0) {
        return sign ? -0.0f : 0.0f;
    } else {
        uint32_t abs_val = sign ? ((1u << (n - 1)) - 1) & ~val + 1 : val;

        int regime, exp, frac;
        extract_fields(n, es, abs_val, &regime, &exp, &frac);

        printf("Regime: %d, Exp: %d, Frac: %d\n", regime, exp, frac);

        int bias = (1 << (8 - 1)) - 1;
        int biased_exp = (regime * (1 << es)) + exp + bias;

        printf("Biased Exp: %d\n", biased_exp);

        float ieee_float = construct_ieee_float(sign, biased_exp, frac);

        return ieee_float;
    }
}

void extract_fields(int n, int es, uint32_t val, int *regime, int *exp, int *frac) {
    int k = 0;
    bool reg_sign = (val >> (n - 2)) & 1;

    while (k < (n - 1) && ((val >> (n - 2 - k)) & 1) == reg_sign) {
        k++;
    }

    *regime = reg_sign ? k - 1 : -k;
    int regime_length = k + 1;
    int exp_length = es;
    int frac_length = n - 1 - regime_length - exp_length;

    *exp = (val >> frac_length) & ((1 << exp_length) - 1);
    *frac = (val & ((1 << frac_length) - 1)) << (23 - frac_length);
}

float construct_ieee_float(bool sign, int biased_exp, int frac) {
    uint32_t ieee_int = (sign << 31) | ((biased_exp & 0xFF) << 23) | (frac & ((1 << 23) - 1));
    float ieee_float;
    memcpy(&ieee_float, &ieee_int, sizeof(ieee_float));
    return ieee_float;
}
