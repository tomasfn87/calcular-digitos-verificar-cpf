#include "cpf.h"

#include <cctype>
#include <iostream>
#include <memory>
#include <sstream>
#include <string>

using namespace std;

// Standard constructor
Cpf::Cpf(string cpf, string completeCpf):
    cpf(cpf), 
    completeCpf(completeCpf) {}

// Default constructor
Cpf::Cpf() {}

// Destructor
Cpf::~Cpf() {}

// Copy constructor
Cpf::Cpf(const Cpf& c) = default;

// Copy assignment operator
Cpf& Cpf::operator=(const Cpf& c) = default;

// Move constructor
Cpf::Cpf(Cpf&& c) = default;

// Move assignment 
Cpf& Cpf::operator=(Cpf&& c) = default;

// Special equality operator: ignores formatted CPF numbers
bool Cpf::operator==(Cpf* c) {
    return (format() == c->format())
    && (format(false) == c->format(false));}

string Cpf::filterNumsAndFillWithZeros(string s, int n) {
    string onlyNums;
    int count = 0;
    for (char c : s) {
        if (isdigit(c)) {
            onlyNums += c;
            ++count;}
        if (count == n)
            break;}
    if (!count)
        return "";
    if (count < n)
        onlyNums = repeat('0', n - count) + onlyNums;
    return onlyNums;}

int* Cpf::calculateVerificationDigits() {
    static int verificationDigits[2] = { -1, -1 };
    string onlyNums = filterNumsAndFillWithZeros(cpf, 9);
    if (!onlyNums.length())
        return verificationDigits;
    verificationDigits[0] = calculateVerificationDigit(onlyNums);
    onlyNums += to_string(verificationDigits[0]);
    verificationDigits[1] = calculateVerificationDigit(onlyNums);
    return verificationDigits;};

bool Cpf::verify() {
    string onlyNums = filterNumsAndFillWithZeros(completeCpf, 11);
    if (!onlyNums.length())
        return false;
    const int numOfVds = 2;
    int receivedVds[numOfVds] = { 
        onlyNums[onlyNums.length() - 2] - '0',
        onlyNums[onlyNums.length() - 1] - '0'};
    string receivedCpf = onlyNums.erase(onlyNums.size() - numOfVds);
    unique_ptr<Cpf> cpf(new Cpf(receivedCpf, ""));
    int* calculatedVds = cpf->calculateVerificationDigits();
    for (int i = 0; i < numOfVds; ++i)
        if (receivedVds[i] != calculatedVds[i])
            return false;
    return true;}

string Cpf::format(bool complete) {
    int length = 11;
    if (!complete)
        length -= 2;
    string onlyNums;
    if (complete)
        onlyNums = filterNumsAndFillWithZeros(completeCpf, length);
    else
        onlyNums = filterNumsAndFillWithZeros(cpf, length);
    if (!onlyNums.length())
        return "";
    stringstream result;
    result << onlyNums.substr(0, 3) << '.'
        <<    onlyNums.substr(3, 3) << '.'
        <<    onlyNums.substr(6, 3);
    if (!complete)
        return result.str();
    result << '-' << onlyNums.substr(9, 2);
    return result.str();};

void Cpf::debugClass() {
    data();
    memAddressAndSizes();
    testFilterNumsAndFillWithZeros();
    int* vds = this->calculateVerificationDigits();
    if (vds[0] != -1) 
        cout << "- testCalculateVerificationDigits   : { " 
            << vds[0] << ", " << vds[1] << " }" << endl;
    string cpfF = this->format(false);
    string cCpfF = this->format();
    if (cCpfF.length() || cpfF.length()) 
        cout << "- Format Incomplete CPF             : \"" << cpfF
            << "\"" << endl
            <<  "- Format Complete   CPF             : \"" << cCpfF
            << "\"" << endl;
    bool v = this->verify();
    cout << "- CPF is " << (v ? "" : "in") << "valid." << endl;}

int Cpf::calculateVerificationDigit(string onlyNums) {
    int sum = 0;
    int factor, mod;
    factor = onlyNums.length() + 1;
    for (char c : onlyNums) {
        sum += (c - '0') * factor;
        --factor;}
    mod = sum % 11;
    if (mod > 1) 
        return 11 - mod;
    return 0;};

void Cpf::data() {
    cout << "- Data                              : \"" << cpf << "\"/\""
        << completeCpf << "\"" << endl;}

void Cpf::memAddressAndSizes() {
    cout << "- MemAddress                        : " << this << endl
        <<  "- PointerSize                       : " << sizeof(this)
        << " bytes" << endl 
        <<  "- ObjectSize                        : " << sizeof(*this)
        << " bytes" << endl;}

void Cpf::testFilterNumsAndFillWithZeros() {
    cout << "- filterNumsAndFillWithZeros(cpf, 5): \""
        << filterNumsAndFillWithZeros(cpf, 5) << "\"/\""
        << filterNumsAndFillWithZeros(completeCpf, 5) << "\""
        << endl;}

string Cpf::repeat(const char& c, int n) {
    stringstream ss;
    for (int i = 0; i < n; ++i) {
        ss << c;}
    return ss.str();}