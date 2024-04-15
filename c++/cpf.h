#ifndef CPF_H
#define CPF_H

#include <string>

class Cpf {
    private:
        std::string cpf, completeCpf;
        void data();
        void memAddressAndSize(Cpf* cpf);
        void testRemoveNonNumChars();
    public:
        Cpf(std::string cpf="", std::string completeCpf="");
        ~Cpf();
        std::string removeNonNumChars(std::string s);
        void testClass();};

#endif
