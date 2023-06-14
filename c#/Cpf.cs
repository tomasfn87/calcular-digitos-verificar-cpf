using System;

namespace cpf {
    class MainClass {
        public static void Main(string[] args) {
            printStringIntStringTest("ReterNumeros", ReterNumeros, "123", 2);
            printStringIntStringTest("ReterNumeros", ReterNumeros, "a1b2c3", 1);
            printStringIntStringTest("ReterNumeros", ReterNumeros, "abc", 1);
            printStringIntStringTest("ReterNumeros", ReterNumeros, "123", 4);
            printStringIntStringTest("ReterNumeros", ReterNumeros, "a1b2c3", 5);
        }

        private static string ReterNumeros(
            string cpf,
            int n) {
            string nums = "";
            int count = 0;
            foreach (char c in cpf) {
                if (char.IsDigit(c)) {
                    nums += c;
                    count++;
                }
                if (count == n) {
                    break;
                }
            }
            if (nums.Length < 1) {
                return "";
            }
            if (nums.Length < n) {
                return nums.PadLeft(n, '0');
            }
            return nums;
        }

        private static void printStringIntStringTest(
            string fnName,
            Func<string, int, string> testFn,
            string testCaseString,
            int testCaseAmount) {
            string test =
                $"{fnName}(\"{testCaseString}\", {testCaseAmount}) = \"{testFn(testCaseString, testCaseAmount)}\"";
            Console.WriteLine(test);
        }
    }
}
