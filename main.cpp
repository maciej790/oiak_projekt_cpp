#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include <time.h>

int N = 16;
int ES = 2;
#define BIAS ((1 << (8 - 1)) - 1)

void wyodrebnij_pola(uint16_t wartosc, int *regime, int *wykladnik, int *mantysa);
float stworz_float_ieee(bool znak, int bias_wykladnik, int mantysa);
float post_na_float(uint16_t x);

int main() {
    srand(time(NULL));

    int ilosc_testow = 50; //ile testow
    for (int test = 0; test < ilosc_testow; ++test) {
        uint16_t posit_wartosc = rand() % (1 << N); // losoj posita

        float ieee_float = post_na_float(posit_wartosc); //skonwertowany posit
        printf("Test %d: Posit (es=%d): 0b", test + 1, ES);
        for (int i = N - 1; i >= 0; i--) {
            printf("%d", (posit_wartosc >> i) & 1);
        }
        printf(", IEEE 754 Float: %f\n", ieee_float);
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
    // normalizujemy mantyse do pojedynczej precyzji - single floata
    *mantysa = (wartosc & ((1 << mantysa_dlugosc) - 1)) << (23 - mantysa_dlugosc);

    // do debugowania
    // printf("Regime: %d, ES: %d, Mantysa: 0x%X\n", *regime, *wykladnik, *mantysa);
}

// finalna kosntrukcja floata z wyodrebnionych pol
float stworz_float_ieee(bool znak, int bias_wykladnik, int mantysa) {
    uint32_t ieee_int = (znak << 31) | ((bias_wykladnik & 0xFF) << 23) | (mantysa & ((1 << 23) - 1));
    float ieee_float;
    memcpy(&ieee_float, &ieee_int, sizeof(ieee_float));
    return ieee_float;
}

float post_na_float(uint16_t x) {
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
