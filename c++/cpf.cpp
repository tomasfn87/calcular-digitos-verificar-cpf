export module cpf;

import <cctype>;
import <iostream>;
import <memory>;
import <sstream>;
import <string>;

export class Cpf {
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
    void data();
    int calculateVerificationDigit(std::string onlyNums);
    void memAddressAndSizes();
    void testFilterNumsAndFillWithZeros();
    std::string repeat(const char& s, int n);};

// Standard constructor
Cpf::Cpf(std::string cpf, std::string completeCpf):
    cpf(cpf), completeCpf(completeCpf) {}

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

export std::string Cpf::filterNumsAndFillWithZeros(std::string s, int n) {
    std::string onlyNums;
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

export int* Cpf::calculateVerificationDigits() {
    static int verificationDigits[2] = { -1, -1 };
    std::stringstream onlyNums;
    onlyNums << filterNumsAndFillWithZeros(cpf, 9);
    if (!onlyNums.str().length())
        return verificationDigits;
    verificationDigits[0] = calculateVerificationDigit(onlyNums.str());
    onlyNums << verificationDigits[0];
    verificationDigits[1] = calculateVerificationDigit(onlyNums.str());
    return verificationDigits;};

export bool Cpf::verify() {
    std::string onlyNums = filterNumsAndFillWithZeros(completeCpf, 11);
    if (!onlyNums.length())
        return false;
    const int numOfVds = 2;
    int receivedVds[numOfVds] = { 
        onlyNums[onlyNums.length() - 2] - '0',
        onlyNums[onlyNums.length() - 1] - '0'};
    std::string receivedCpf = onlyNums.erase(onlyNums.size() - numOfVds);
    std::unique_ptr<Cpf> cpf(new Cpf(receivedCpf, ""));
    int* calculatedVds = cpf->calculateVerificationDigits();
    for (int i = 0; i < numOfVds; ++i)
        if (receivedVds[i] != calculatedVds[i])
            return false;
    return true;}

export std::string Cpf::format(bool complete) {
    int length = 11;
    if (!complete)
        length -= 2;
    std::string onlyNums;
    if (complete)
        onlyNums = filterNumsAndFillWithZeros(completeCpf, length);
    else
        onlyNums = filterNumsAndFillWithZeros(cpf, length);
    if (!onlyNums.length())
        return "";
    std::stringstream result;
    result << onlyNums.substr(0, 3) << '.'
        <<    onlyNums.substr(3, 3) << '.'
        <<    onlyNums.substr(6, 3);
    if (!complete)
        return result.str();
    result << '-' << onlyNums.substr(9, 2);
    return result.str();};

export void Cpf::debugClass() {
    data();
    memAddressAndSizes();
    testFilterNumsAndFillWithZeros();
    int* vds = this->calculateVerificationDigits();
    if (vds[0] != -1) 
        std::cout << "- calculateVerificationDigits       : { " 
            << vds[0] << ", " << vds[1] << " }" << std::endl;
    std::string cpfF = this->format(false);
    std::string cCpfF = this->format();
    if (cCpfF.length() || cpfF.length()) 
        std::cout << "- Format Incomplete CPF             : \"" << cpfF
            << "\"" << std::endl
            <<  "- Format Complete   CPF             : \"" << cCpfF
            << "\"" << std::endl;
    bool v = this->verify();
    std::cout << "- CPF is " << (v ? "" : "in") << "valid." << std::endl;}

int Cpf::calculateVerificationDigit(std::string onlyNums) {
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
    std::cout << "- Data                              : \"" << cpf << "\"/\""
        << completeCpf << "\"" << std::endl;}

void Cpf::memAddressAndSizes() {
    std::cout << "- MemAddress                        : " << this << std::endl
        <<  "- PointerSize                       : " << sizeof(this)
        << " bytes" << std::endl 
        <<  "- ObjectSize                        : " << sizeof(*this)
        << " bytes" << std::endl;}

void Cpf::testFilterNumsAndFillWithZeros() {
    std::cout << "- filterNumsAndFillWithZeros(cpf, 5): \""
        << filterNumsAndFillWithZeros(cpf, 5) << "\"/\""
        << filterNumsAndFillWithZeros(completeCpf, 5) << "\""
        << std::endl;}

std::string Cpf::repeat(const char& c, int n) {
    std::stringstream ss;
    for (int i = 0; i < n; ++i) {
        ss << c;}
    return ss.str();}
