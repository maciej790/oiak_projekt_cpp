#include <iostream>
#include <bitset>
#include <cstdint>
#include <cmath>
#include <cstring>

// Funkcja wyodrêbniania pola
void extract_fields(uint32_t val, int n, int es, int &regime, int &exp, int &frac) {
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

// Funkcja konstruowania liczby zmiennoprzecinkowej IEEE 754
float construct_ieee_float(bool sign, int biased_exp, int frac) {
    uint32_t ieee_int = (sign << 31) | ((biased_exp & 0xFF) << 23) | (frac & ((1 << 23) - 1));
    float ieee_float;
    std::memcpy(&ieee_float, &ieee_int, sizeof(ieee_float));
    return ieee_float;
}

// Funkcja konwersji liczby Posit na IEEE 754 float
float posit_to_float(uint32_t x, int n, int es) {
    // Wyodrêbnianie znaku
    bool sign = (x >> (n - 1)) & 1;

    // Wyodrêbnianie wartoœci
    uint32_t val = x & ((1u << (n - 1)) - 1);

    if (val == 0) {
        return sign ? -0.0f : 0.0f;
    } else {
        uint32_t abs_val = sign ? ((1u << (n - 1)) - 1) & ~val + 1 : val;

        int regime, exp, frac;
        extract_fields(abs_val, n, es, regime, exp, frac);

        int bias = (1 << (8 - 1)) - 1;
        int biased_exp = (regime * (1 << es)) + exp + bias;

        return construct_ieee_float(sign, biased_exp, frac);
    }
}

// Funkcja dodawania dwóch liczb Posit
uint32_t posit_add(uint32_t a, uint32_t b, int n, int es) {
    // Konwersja Posit na IEEE 754 float
    float a_float = posit_to_float(a, n, es);
    float b_float = posit_to_float(b, n, es);

    // Dodawanie float
    float sum = a_float + b_float;

    // Konwersja wyniku z powrotem na Posit
    // Uproszczona metoda dla celów demonstracyjnych
    uint32_t result;
    std::memcpy(&result, &sum, sizeof(result));
    return result;
}

int main() {
    // Przyk³adowe wartoœci Posit (32-bit)
    uint32_t posit_value1 = 0b01000000010010010000111111000000;
    uint32_t posit_value2 = 0b11000000100000000000000000000000;

    // Parametry Posit
    int n = 32;
    int es = 2;

    // Dodawanie dwóch liczb Posit
    uint32_t result = posit_add(posit_value1, posit_value2, n, es);

    // Wyœwietlanie wyników
    std::cout << "Posit 1: " << std::bitset<32>(posit_value1) << std::endl;
    std::cout << "Posit 2: " << std::bitset<32>(posit_value2) << std::endl;
    std::cout << "Wynik: " << std::bitset<32>(result) << std::endl;

    return 0;
}
