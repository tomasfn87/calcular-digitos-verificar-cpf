#include <cctype>
#include <cstring>
#include <iostream>
#include <memory>
#include <string>

using namespace std;

class Cpf {
    public:
        Cpf(string cpf="", string completeCpf=""):
            cpf(cpf), completeCpf(completeCpf) {}

        ~Cpf() {}

        string removeNonNumChars(string s, int n) {
            string onlyNums;
            int count = 0;
            for (char c : s) {
                if (isdigit(c)) {
                    onlyNums += c;
                    ++count;}
                if (count == n)
                    break;}
            return onlyNums;}

        int* calculateVerificationDigits() {
            static int verificationDigits[2] = { -1, -1 };
            string onlyNums = removeNonNumChars(cpf, 9);
            if (!onlyNums.length())
                return verificationDigits;
            verificationDigits[0] = calculateVerificationDigit(onlyNums);
            onlyNums += to_string(verificationDigits[0]);
            verificationDigits[1] = calculateVerificationDigit(onlyNums);
            return verificationDigits;};

        bool verify() {
            string onlyNums = removeNonNumChars(completeCpf, 11);
            if (!onlyNums.length())
                return false;
            if (onlyNums == "0" || onlyNums == "00")
                return true;
            if (onlyNums.length() <= 2)
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

        void debugClass() {
            data();
            memAddressAndSizes();
            testRemoveNonNumChars();
            int* vds = this->calculateVerificationDigits();
            if (vds[0] != -1) 
                cout << "- testCalculateVerificationDigits: { " 
                    << vds[0] << ", " << vds[1] << " }" << endl;
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
            cout << "- Data                           : \"" << cpf << "\"/\""
                << completeCpf << "\"" << endl;}

        void memAddressAndSizes() {
            cout << "- MemAddress                     : " << this << endl
                <<  "- PointerSize                    : " << sizeof(this)
                << " bytes" << endl 
                <<  "- ObjectSize                     : " << sizeof(*this)
                << " bytes" << endl;}

        void testRemoveNonNumChars() {
            cout << "- testRemoveNonNumChars(cpf, 5)  : \""
                << removeNonNumChars(cpf, 5) << "\"/\""
                << removeNonNumChars(completeCpf, 5) << "\"" << endl;}};

void demo(string option) {
    Cpf* cpf = new Cpf();
    cout << "new Cpf()" << endl;
    cpf->debugClass();
    if (option == "--delete-test") {
        cout << "- deleting `cpf`" << endl;
        delete cpf;
        cpf = nullptr;}
    cout << endl;

    Cpf* cpf1 = new Cpf("0", "00");
    cout << "new Cpf(\"0\", \"00\")" << endl;
    cpf1->debugClass();
    if (option == "--delete-test") {
        cout << "- deleting `cpf1`" << endl;
        delete cpf1;
        cpf1 = nullptr;}
    cout << endl;

    Cpf* cpf2 = new Cpf("test...1...2...3", "testing...1...2...3");
    cout << "new Cpf(\"test...1...2...3\", \"testing...1...2...3\")" << endl;
    cpf2->debugClass();
    if (option == "--delete-test") {
        cout << "- deleting `cpf2`" << endl;
        delete cpf2;
        cpf2 = nullptr;}
    cout << endl;

    Cpf* cpf3 = new Cpf("111.444.777", "111.444.777-35");
    cout << "new Cpf(\"111.444.777\", \"111.444.777-35\")" << endl;
    cpf3->debugClass();}

int main(int argc, char* argv[]) {
    string option1, option2;
    if (argc > 1)
        option1 = argv[1];
    if (argc > 2 && option1 == "--demo")
        option2 = argv[2];
    if (option1 == "--demo") {
        cout << "CLI args: " << endl;
        for (int i = 0; i < argc; i++) {
            cout << "- " << i+1 <<  ") " << argv[i] << endl;}
        cout << endl;
        demo(option2);};
    return 0;}
