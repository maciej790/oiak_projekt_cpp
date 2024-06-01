#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <string.h>
#include <math.h>
#include <time.h>

int N = 16;
int ES = 8; // es bedzie zmieniany w kodzie (od 1 do 8) przy benchtestach
#define BIAS ((1 << (8 - 1)) - 1)

void wyodrebnij_pola(uint16_t wartosc, int *regime, int *wykladnik, int *mantysa);
float stworz_float_ieee(bool znak, int bias_wykladnik, int mantysa);
float posit_na_float(uint16_t x);

int main() {
    // Przykladowe wartoscii posita (wybrane recznie arbitralnie do tesow)
    uint16_t testy[] = {
        0b0100011111010101, // mantysa z większą ilością jedynek
        0b0100011000110101,
        0b0011100101001011,
        0b1011011110110101,
        0b1100111110010010,
        0b0111111000010010,
        0b0100100111110011,
        0b1101011010110100,
        0b1010100101100101,
        0b1111110111000100,
        0b0011111011011100,
        0b1000111000111000,
        0b1010011100011111,
        0b1111011011011000,
        0b0111111101101001,
        0b0001011110011110,
        0b1100101111011111,
        0b0101111011100111,
        0b1111111111111111, // maks wartość posit
        0b0000000000000001, // min wartość posit
        // inne wartocii posita (wybrane losowo za pomoca generatora w pythonie) - sprawozdanie
        0b0110010101110000,
        0b1010110100111011,
        0b0011100111111110,
        0b0111001101101011,
        0b1001001110011111,
        0b0101111100101101,
        0b1010101011110100,
        0b1110001110110010,
        0b0011111100010101,
        0b0111110010010011,
        0b1101010101001110,
        0b1000010011000111,
        0b0101101111000101,
        0b0110111111101001,
        0b1111011001000110,
        0b0010101010101010,
        0b0110010110011001,
        0b1011101101000110,
        0b1110101001011101,
        0b1100111111110100,
        0b0100100100100100,
        0b0000000010000011,
        0b0101101100000101,
        0b1101000100100111,
        0b1111011011011110,
        0b1110000011111111,
        0b0100110010101101,
        0b0010100111101011,
        0b1010101011011011,
        0b0010011110011010,
    };

    int ilosc_testow = sizeof(testy) / sizeof(uint16_t);

    for (int es = 1; es <= 8; ++es) {
        ES = es;
        clock_t start_time = clock();

        for (int test = 0; test < ilosc_testow; ++test) {
            uint16_t posit_wartosc = testy[test];
            float ieee_float = posit_na_float(posit_wartosc); //skonwertowany posit
            printf("Test %d: Posit (es=%d): 0b", test + 1, ES);
            for (int i = N - 1; i >= 0; i--) {
                printf("%d", (posit_wartosc >> i) & 1);
            }
            printf(", IEEE 754 Float: %.10f\n", ieee_float); // %.10f dla wiekszej precyzji - wymaga usprawnienia
        }

        clock_t end_time = clock();
        double elapsed_time = (double)(end_time - start_time) / CLOCKS_PER_SEC;
        printf("Czas wykonania dla ES=%d: %.6f sekund\n", ES, elapsed_time);
    }

    return 0;
}

void wyodrebnij_pola(uint16_t wartosc, int *regime, int *wykladnik, int *mantysa) {
    int k = 0;
    // szukamy dlugosci pola regime - do momentu natrafienia na przeciwny bit
    while (k < (N - 1) && ((wartosc >> (N - 2 - k)) & 1)) {
        k++;
    }

    *regime = (k > 0 ? k - 1 : -k); // decydujemy jakie bedzie regime - wzor sprawozdania
    int regime_dlugosc = k + 1;
    int wykladnik_dlugosc = ES;
    int mantysa_dlugosc = N - 1 - regime_dlugosc - wykladnik_dlugosc; // obliczamy dl mantysy

    *wykladnik = (wartosc >> mantysa_dlugosc) & ((1 << wykladnik_dlugosc) - 1);
    *mantysa = (wartosc & ((1 << mantysa_dlugosc) - 1)) << (23 - mantysa_dlugosc);

    // do debugowania
    // printf("Regime: %d, ES: %d, Mantysa: 0x%X\n", *regime, *wykladnik, *mantysa);
}

// finalna konstrukcja floata z wyodrebnionych pol
float stworz_float_ieee(bool znak, int bias_wykladnik, int mantysa) {
    uint32_t ieee_int = (znak << 31) | ((bias_wykladnik & 0xFF) << 23) | (mantysa & ((1 << 23) - 1));
    float ieee_float;
    memcpy(&ieee_float, &ieee_int, sizeof(ieee_float));
    return ieee_float;
}

float posit_na_float(uint16_t x) {
    // pobierz znak
    bool znak = (x >> (N - 1)) & 1;

    // pobierz reszte bitow - bez znaku
    uint16_t wartosc = x & ((1 << (N - 1)) - 1);

    // dopelnienie
    if (wartosc == 0) {
        return znak ? -0.0f : 0.0f;
    } else {
        // wartosc bezwzgledna
        uint16_t abs_wartosc = znak ? ((1 << (N - 1)) - 1) & ~wartosc + 1 : wartosc;

        // wyodrebnianione pola
        int regime, wykladnik, mantysa;
        wyodrebnij_pola(abs_wartosc, &regime, &wykladnik, &mantysa);

        int bias = BIAS;

        // policz wykladnik przesuniety o bias
        int bias_wykladnik = (regime * (1 << ES)) + wykladnik + bias;

        // do  debugowania
        // printf("przesuniety wykladnik: %d\n", bias_wykladnik);

        // tworzenie floata
        float ieee_float = stworz_float_ieee(znak, bias_wykladnik, mantysa);
        return ieee_float;
    }
}
