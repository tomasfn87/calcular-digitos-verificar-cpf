#ifndef CPF_H
#define CPF_H

#include <string>

class Cpf {
public:
    Cpf(std::string cpf, std::string completeCpf);
    Cpf();
    ~Cpf();
    Cpf(const Cpf&);
    Cpf& operator=(const Cpf&);
    Cpf(Cpf&& cpf);
    Cpf& operator=(Cpf&&);
    bool operator==(Cpf*);
    std::string filterNumsAndFillWithZeros(std::string s, int n);
    int* calculateVerificationDigits();
    bool verify();
    std::string format(bool complete=true);
    void debugClass();
private:
    std::string cpf, completeCpf;
    int calculateVerificationDigit(std::string onlyNums);
    void data();
    void memAddressAndSizes();
    void testFilterNumsAndFillWithZeros();
    std::string repeat(const char& s, int n);};

#endif
