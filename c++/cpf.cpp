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
    bool operator==(Cpf&);
    bool operator!=(Cpf&);
    static bool hasANumber(const std::string s);
    int* calculateVerificationDigits() const;
    bool verify() const;
    std::string format(const bool complete=true) const;
    std::string clean(const bool complete=true) const;
    void debugClass();
private:
    std::string cpf, completeCpf;
    void data();
    static std::string filterNumsAndFillWithZeros(
        const std::string s, const int n);
    int calculateVerificationDigit(const std::string onlyNums) const;
    void memAddressAndSizes();
    static std::string repeat(const char& s, const int n);};

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
bool Cpf::operator==(Cpf& c) {
    return (clean() == c.clean())
        && (clean(false) == c.clean(false));}

bool Cpf::operator!=(Cpf& c) {
    return !(*this == c);}

export bool Cpf::hasANumber(const std::string s) {
    return filterNumsAndFillWithZeros(s, 1).length() > 0;}

export int* Cpf::calculateVerificationDigits() const {
    static int verificationDigits[2] = { -1, -1 };
    std::stringstream onlyNums;
    onlyNums << filterNumsAndFillWithZeros(cpf, 9);
    if (!onlyNums.str().length())
        return verificationDigits;
    verificationDigits[0] = calculateVerificationDigit(onlyNums.str());
    onlyNums << verificationDigits[0];
    verificationDigits[1] = calculateVerificationDigit(onlyNums.str());
    return verificationDigits;}

export bool Cpf::verify() const {
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

export std::string Cpf::format(const bool complete) const {
    std::string onlyNums = clean(complete);
    if (!onlyNums.length())
        return "";
    std::stringstream result;
    result << onlyNums.substr(0, 3) << '.'
        <<    onlyNums.substr(3, 3) << '.'
        <<    onlyNums.substr(6, 3);
    if (!complete)
        return result.str();
    result << '-' << onlyNums.substr(9, 2);
    return result.str();}

export std::string Cpf::clean(const bool complete) const {
    std::string result;
    int length = 9;
    if (complete)
        length += 2;
    if (complete)
        result = completeCpf;
    else
        result = cpf;
    return filterNumsAndFillWithZeros(result, length);}

export void Cpf::debugClass() {
    data();
    memAddressAndSizes();
    if (this->clean(false).length() || this->clean().length())
        std::cout << "- Format CPF         : \"" << this->format(false)
            << "\"/\"" << this->format() << "\"" << std::endl
            <<       "- Clean CPF          : \"" << this->clean(false)
            << "\"/\"" << this->clean() << "\"" << std::endl;
    int* vds = this->calculateVerificationDigits();
    if (vds[0] != -1) 
        std::cout << "- Verification Digits: { " 
            << vds[0] << ", " << vds[1] << " }" << std::endl;
    bool v = this->verify();
    std::cout << "- CPF is " << (v ? "" : "in") << "valid." << std::endl;}

std::string Cpf::filterNumsAndFillWithZeros(
    const std::string s, const int n) {
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

int Cpf::calculateVerificationDigit(std::string onlyNums) const {
    int sum = 0;
    int factor, mod;
    factor = onlyNums.length() + 1;
    for (char c : onlyNums) {
        sum += (c - '0') * factor;
        --factor;}
    mod = sum % 11;
    if (mod > 1) 
        return 11 - mod;
    return 0;}

void Cpf::data() {
    std::cout << "- Data               : \"" << cpf << "\"/\""
        << completeCpf << "\"" << std::endl;}

void Cpf::memAddressAndSizes() {
    std::cout << "- Memory Address     : " << this << std::endl
        <<       "- Pointer/Object Size: " << sizeof(this)
        << " bytes/" << sizeof(*this) << " bytes" << std::endl;}

std::string Cpf::repeat(const char& c, const int n) {
    std::stringstream ss;
    for (int i = 0; i < n; ++i) {
        ss << c;}
    return ss.str();}
