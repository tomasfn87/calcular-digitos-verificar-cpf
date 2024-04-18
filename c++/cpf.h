#ifndef CPF_H
#define CPF_H

#include <string>

class Cpf {
    public:
        Cpf(std::string cpf="", std::string completeCpf="");
        ~Cpf();
        std::string filterNumsAndFillWithZeroes(std::string s);
        int* calculateVerificationDigits();
        bool verify();
        std::string format(bool complete=true);
        void debugClass();
    private:
        std::string cpf, completeCpf;
        int calculateVerificationDigit(std::string onlyNums);
        void data();
        void memAddressAndSizes();
        void testfilterNumsAndFillWithZeroes();
        void repeat(const std::string& s, int n);};

#endif
