#ifndef CPF_H
#define CPF_H

#include <string>

class Cpf {
    private:
        std::string cpf, completeCpf;
        void data();
        void memAddressAndSizes();
        void testRemoveNonNumChars();
        int calculateVerificationDigit(std::string onlyNums);
    public:
        Cpf(std::string cpf="", std::string completeCpf="");
        ~Cpf();
        std::string removeNonNumChars(std::string s);
        int* calculateVerificationDigits();
        void debugClass();};

#endif
