#include <iostream>
#include <bitset>
#include <cstring>
#include <cmath>

class Posit {
private:
    int n; // Number of bits in the Posit representation
    int es; // Number of exponent bits

public:
    Posit(int n = 16, int es = 2) : n(n), es(es) {}

    float posit_to_float(uint32_t x) {
        // Step 1: Extract sign
        bool sign = (x >> (n - 1)) & 1;

        // Step 2: Extract value (magnitude)
        uint32_t val = x & ((1u << (n - 1)) - 1);

        // Step 3: Check if value is zero
        if (val == 0) {
            // Step 4: Return positive or negative zero based on sign
            return sign ? -0.0f : 0.0f;
        } else {
            // Step 9: Determine absolute value
            uint32_t abs_val = sign ? ((1u << (n - 1)) - 1) & ~val + 1 : val;

            // Step 13: Extract regime, exponent, fraction fields
            int regime, exp, frac;
            extract_fields(abs_val, regime, exp, frac);

            // Debug output
            std::cout << "Regime: " << regime << ", Exp: " << exp << ", Frac: " << frac << std::endl;

            // Step 14: Bias for IEEE float exponent
            int bias = (1 << (8 - 1)) - 1;

            // Step 15: Calculate biased exponent
            int biased_exp = (regime * (1 << es)) + exp + bias;

            // Debug output
            std::cout << "Biased Exp: " << biased_exp << std::endl;

            // Step 16: Construct IEEE float
            float ieee_float = construct_ieee_float(sign, biased_exp, frac);

            // Step 17: Return IEEE float
            return ieee_float;
        }
    }

private:
    void extract_fields(uint32_t val, int &regime, int &exp, int &frac) {
        int k = 0;
        while (k < (n - 1) && ((val >> (n - 2 - k)) & 1)) {
            k++;
        }

        regime = (k > 0 ? k - 1 : -k);
        int regime_length = k + 1;
        int exp_length = es;
        int frac_length = n - 1 - regime_length - exp_length;

        exp = (val >> frac_length) & ((1 << exp_length) - 1);
        frac = (val & ((1 << frac_length) - 1)) << (23 - frac_length); // Assuming IEEE 754 single precision float
    }

    float construct_ieee_float(bool sign, int biased_exp, int frac) {
        uint32_t ieee_int = (sign << 31) | ((biased_exp & 0xFF) << 23) | (frac & ((1 << 23) - 1));
        float ieee_float;
        std::memcpy(&ieee_float, &ieee_int, sizeof(ieee_float));
        return ieee_float;
    }
};

int main() {
    // Example usage
    uint32_t posit_value = 0b10111110010001111010101011100001; // Example 32-bit Posit value

    Posit posit_system2(32, 8);
    float ieee_float = posit_system2.posit_to_float(posit_value);
    std::cout << "Posit (es=3): " << std::bitset<32>(posit_value) << ", IEEE 754 Float: " << ieee_float << std::endl;

    return 0;
}
