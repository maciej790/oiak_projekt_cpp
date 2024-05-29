#include <iostream>
#include <bitset>
#include <cstring>


class Posit {
private:
    int n; // Number of bits in the Posit representation
    int es; // Number of exponent bits

public:
    Posit(int n = 16, int es = 2) : n(n), es(es) {}

    float posit_to_float(uint16_t x) {
        // Step 1: Extract sign
        bool sign = (x >> (n - 1)) & 1;

        // Step 2: Extract value (magnitude)
        uint16_t val = x & ((1 << (n - 1)) - 1);

        // Step 3: Check if value is zero
        if (val == 0) {
            // Step 4: Return positive or negative zero based on sign
            return sign ? -0.0f : 0.0f;
        } else {
            // Step 9: Determine absolute value
            uint16_t abs_val = sign ? ((1 << (n - 1)) - 1) & ~val + 1 : val;

            // Step 13: Extract regime, exponent, fraction fields
            int regime, exp, frac;
            extract_fields(abs_val, regime, exp, frac);

            // Debug output
            std::cout << "Regime: " << regime << ", Exp: " << exp << ", Frac: " << frac << std::endl;

            // Step 14: Bias for IEEE float exponent
            int bias = (1 << (8 - 1)) - 1;

            // Step 15: Calculate biased exponent
            int biased_exp = (regime << es) + exp + bias;

            // Debug output
            std::cout << "Biased Exp: " << biased_exp << std::endl;

            // Step 16: Construct IEEE float
            float ieee_float = construct_ieee_float(sign, biased_exp, frac);

            // Step 17: Return IEEE float
            return ieee_float;
        }
    }

private:
    void extract_fields(uint16_t val, int &regime, int &exp, int &frac) {
        int k = 0;
        while (val & (1 << (n - 2 - k))) {
            k++;
        }

        regime = k - 1;
        exp = (val >> (n - 2 - k - es)) & ((1 << es) - 1);
        frac = (val & ((1 << (n - 2 - k - es)) - 1)) << (23 - (n - 2 - k - es)); // Assuming IEEE 754 single precision float
    }

    float construct_ieee_float(bool sign, int biased_exp, int frac) {
        uint32_t ieee_int = (sign << 31) | (biased_exp << 23) | (frac & ((1 << 23) - 1));
        float ieee_float;
        std::memcpy(&ieee_float, &ieee_int, sizeof(ieee_float));
        return ieee_float;
    }
};

int main() {
    // Example usage
    Posit posit_system(16, 2);
    uint16_t posit_value = 0b1011111001000111; // Example Posit value

    float ieee_float = posit_system.posit_to_float(posit_value);

    std::cout << "Posit: " << std::bitset<16>(posit_value) << ", IEEE 754 Float: " << ieee_float << std::endl;

    return 0;
}
