#ifndef CPF_H
#define CPF_H

#include <string>

class Cpf {
    public:
        Cpf(std::string cpf="", std::string completeCpf="");
        ~Cpf();
        std::string removeNonNumChars(std::string s);
        int* calculateVerificationDigits();
        void debugClass();
    private:
        std::string cpf, completeCpf;
        int calculateVerificationDigit(std::string onlyNums);
        void data();
        void memAddressAndSizes();
        void testRemoveNonNumChars();};

#endif
