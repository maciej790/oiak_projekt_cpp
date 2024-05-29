
        // Step 16: Construct IEEE float
        float ieee_float = construct_ieee_float(sign, biased_exp, frac);

        // Step 17: Return IEEE float
        return ieee_float;
    }
}

int main() {
    uint16_t posit_value = 0b1011111001000111;
    int n = 16;
    int es = 3;

    float ieee_float = posit_to_float(posit_value, n, es);
    std::cout << "Posit (es=3): " << std::bitset<16>(posit_value) << ", IEEE 754 Float: " << ieee_float << std::endl;

    return 0;
}
