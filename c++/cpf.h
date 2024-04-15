#ifndef HELLO_H
#define HELLO_H

#include <string>

class Cpf {
    private:
        std::string cpf, completeCpf;
    public:
        Cpf(std::string cpf="", std::string completeCpf="");
        ~Cpf();
        std::string removeNonNumChars(std::string s);
        void data();
        void testRemoveNonNumChars();};

#endif
