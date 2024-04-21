#include <cctype>
#include <iostream>
#include <memory>
#include <sstream>
#include <string>

using namespace std;

class Cpf {
public:
    // Standard constructor
    Cpf(string cpf, string completeCpf):
        cpf(cpf), 
        completeCpf(completeCpf) {}

    // Default constructor
    Cpf() {}

    // Destructor
    ~Cpf() {}

    // Copy constructor
    Cpf(const Cpf& c) = default;

    // Copy assignment operator
    Cpf& operator=(const Cpf& c) = default;

    // Move constructor
    Cpf(Cpf&& c) = default;

    // Move assignment 
    Cpf& operator=(Cpf&& c) = default;

    // Special equality operator: ignores formatted CPF numbers
    bool operator==(Cpf* c) {
        return (format() == c->format())
        && (format(false) == c->format(false));}

    string filterNumsAndFillWithZeros(string s, int n) {
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

    int* calculateVerificationDigits() {
        static int verificationDigits[2] = { -1, -1 };
        string onlyNums = filterNumsAndFillWithZeros(cpf, 9);
        if (!onlyNums.length())
            return verificationDigits;
        verificationDigits[0] = calculateVerificationDigit(onlyNums);
        onlyNums += to_string(verificationDigits[0]);
        verificationDigits[1] = calculateVerificationDigit(onlyNums);
        return verificationDigits;};

    bool verify() {
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
    
    string format(bool complete=true) {
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

    void debugClass() {
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

private:
    string cpf, completeCpf;

    int calculateVerificationDigit(string onlyNums) {
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

    void data() {
        cout << "- Data                              : \"" << cpf << "\"/\""
            << completeCpf << "\"" << endl;}

    void memAddressAndSizes() {
        cout << "- MemAddress                        : " << this << endl
            <<  "- PointerSize                       : " << sizeof(this)
            << " bytes" << endl 
            <<  "- ObjectSize                        : " << sizeof(*this)
            << " bytes" << endl;}

    void testFilterNumsAndFillWithZeros() {
        cout << "- filterNumsAndFillWithZeros(cpf, 5): \""
            << filterNumsAndFillWithZeros(cpf, 5) << "\"/\""
            << filterNumsAndFillWithZeros(completeCpf, 5) << "\""
            << endl;}

    string repeat(const char& c, int n) {
        stringstream ss;
        for (int i = 0; i < n; ++i) {
            ss << c;}
        return ss.str();}};

void smartCompareCpfObjects(
    string cpfA, Cpf* pCpfA, string cpfB, Cpf* pCpfB) {
    cout << "- `" + cpfA + "` is " << (pCpfA != *pCpfB ? "not " : "") 
        << "equal to `" << cpfB << "`." << endl;}

Cpf* createDefaultCpfObject(string varName) {
    Cpf* c = new Cpf();
    cout << "Cpf* " << varName << " = new Cpf()" << endl;
    return c;}

Cpf* createCpfObject(string varName, string cpf, string completeCpf) {
    Cpf* c = new Cpf(cpf, completeCpf);
    cout << "Cpf* " << varName << " = new Cpf(\"" << cpf << "\", "
        << "\"" << completeCpf << "\")" << endl;
    return c;}

Cpf* copyCpfObject(
    string newCpf, string oldCpf, Cpf* pOldCpf) {
    cout << "Cpf* " << newCpf << " = new Cpf(*" << oldCpf << ")" << endl;
    Cpf* pNewCpf = new Cpf(*pOldCpf);
    return pNewCpf;}

void deleteTest(string varName, Cpf* cpf, string option="") {
    if (option == "--delete-test") {
        cout << "- deleting `" << varName << "`" << endl;
        delete cpf;
        cpf = nullptr;}}

void demo(string option) {
    Cpf* cpf = createDefaultCpfObject("cpf");
    cpf->debugClass();
    deleteTest("cpf", cpf, option);
    cout << endl;

    Cpf* cpf1 = createCpfObject("cpf1", "0", "00");
    cpf1->debugClass();
    deleteTest("cpf1", cpf1, option);
    cout << endl;

    Cpf* cpf2 = createCpfObject("cpf2", "test...1 2 3", "testing...1 2 3");
    cpf2->debugClass();
    cout << endl;

    Cpf* cpf3 = createCpfObject("cpf3", "003.444.777", "003.444.777-62");
    cpf3->debugClass();
    cout << endl;

    Cpf* cpf4 = copyCpfObject("cpf4", "cpf3", cpf3);
    cout << endl;

    Cpf* cpf5 = createCpfObject("cpf5", "03.444.777", "03.444.777-62");
    cpf5->debugClass();
    cout << endl;

    Cpf* cpf6 = createCpfObject("cpf6", "3444777", "344477762");
    cpf6->debugClass();
    cout << endl;

    smartCompareCpfObjects("cpf3", cpf3, "cpf4", cpf4);
    smartCompareCpfObjects("cpf3", cpf3, "cpf5", cpf5);
    smartCompareCpfObjects("cpf3", cpf3, "cpf6", cpf6);

    if (option == "--delete-test") {
        cout << endl;
        deleteTest("cpf3", cpf3, option);
        cout << endl;

        cout << "`cpf4` is accessible after deleting `cpf3`" << endl;
        cpf4->debugClass();}}

void help_user() {
    cout << "Digite uma das opções abaixo:" << endl
        << "- '-c' ou '--calcular' e um número de CPF sem os dígitos " 
        << "verificadores;" << endl
        << "- '-f' ou '--formatar' e um número de CPF completo;" << endl
        << "- '-v' ou '--verificar' e um número de CPF completo;" << endl
        << "- '--demo';" << endl
        << "- '--demo --delete-test'." << endl;}

int main(int argc, char* argv[]) {
    string option1, option2;
    if (argc > 1)
        option1 = argv[1];
    if (argc > 2)
        option2 = argv[2];
    if (option1 == "--demo") {
        cout << "CLI args: " << endl;
        for (int i = 0; i < argc; i++) {
            cout << "- " << i+1 <<  ") " << argv[i] << endl;}
        cout << endl;
        demo(option2);
        return 0;}
    unique_ptr<Cpf> aux(new Cpf());
    if (!aux->filterNumsAndFillWithZeros(option2, 1).length()) {
        cout << "ERRO: o CPF informado não possui números." << endl << endl;
        help_user();
        return 1;}
    if (option1 == "--calcular" || option1 == "-c") {
        unique_ptr<Cpf> cpf(new Cpf(option2, ""));
        int* dvs = cpf->calculateVerificationDigits();
        string cCpf = cpf->format(false);
        cCpf += "-" + to_string(dvs[0]) + to_string(dvs[1]);
        cout << "CPF informado: " << cpf->format(false) << endl
            <<  "CPF completo : " << cCpf << endl
            <<  "               "
            << cpf->filterNumsAndFillWithZeros(cCpf, 11) << endl
            << "{ " << dvs[0] << ", " << dvs[1] << " }" << endl;}
    else if (option1 == "--formatar" || option1 == "-f") {
        unique_ptr<Cpf> cpf(new Cpf("", option2));
        cout << "CPF formatado: " << cpf->format() << endl;}
    else if (option1 == "--verificar" || option1 == "-v") {
        unique_ptr<Cpf> cpf(new Cpf("", option2));
        bool v = cpf->verify();
        cout << "O CPF " << cpf->format() << " é " << (v ? "" : "in")
            << "válido." << endl;
        if (!v)
            return 2;}
    else {
        help_user();
        return 1;}
    return 0;}

