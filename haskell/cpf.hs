import Data.Char (isDigit, digitToInt)
import Data.List (intercalate)
import Data.List.Split (chunksOf)
import System.Environment (getArgs)

main :: IO ()
main = do
    args <- getArgs
    case length args of
        0 -> helpUser
        1 -> case head args of
                "--demo" -> demo
                _ -> helpUser
        2 -> do
            let filteredArg = filterNumsAndFillWithZeros (args !! 1) 1
            if null filteredArg
                then helpUser
            else case head args of
                    "--calcular" -> cliCalculate (args !! 1)
                    "-c" -> cliCalculate (args !! 1)
                    "--formatar" -> cliFormat (args !! 1)
                    "-f" -> cliFormat (args !! 1)
                    "--verificar" -> cliVerify (args !! 1)
                    "-v" -> cliVerify (args !! 1)
                    _ -> helpUser
        _ -> helpUser

cliCalculate :: String -> IO ()
cliCalculate cpf = do
    let onlyNumsCpf = filterNumsAndFillWithZeros cpf 9
        cpfWithZeros = onlyNumsCpf ++ "00"
        formattedCpf = take 11 (format cpfWithZeros)
        [d1, d2] = calculateVerificationDigits cpf
        fullCpf = onlyNumsCpf ++ show d1 ++ show d2
    putStrLn $ "CPF informado: " ++ formattedCpf
    putStrLn $ "CPF completo : " ++ format fullCpf
    putStrLn $ "               " ++ fullCpf
    putStrLn $ "[ " ++ show d1 ++ ", " ++ show d2 ++ " ]"

cliFormat :: String -> IO ()
cliFormat cpf = do
    putStrLn $ "CPF formatado: " ++ format cpf

cliVerify :: String -> IO ()
cliVerify cpf = do
    let isValid = verify cpf
    putStr $ "O CPF " ++ format cpf ++ " é "
    putStr $ if isValid then "" else "in"
    putStrLn $ "válido."

demo :: IO ()
demo = do
    putStr $ "filterNumsAndFillWithZeros 'test'    1 -> "
    putStrLn $ show (filterNumsAndFillWithZeros "test" 1)
    putStr $ "filterNumsAndFillWithZeros 'test123' 2 -> "
    putStrLn $ show (filterNumsAndFillWithZeros "test123" 2)
    putStr $ "filterNumsAndFillWithZeros 'test123' 4 -> "
    putStrLn $ show (filterNumsAndFillWithZeros "test123" 4)
    putStrLn $ ""

    putStr $ "calculateVerificationDigit '123'       -> "
    putStrLn $ show (calculateVerificationDigit "123")
    putStrLn $ ""

    putStr $ "calculateVerificationDigits '123'      -> "
    putStrLn $ show (calculateVerificationDigits "123")
    putStrLn $ ""

    putStr $ "verify '12360'                         -> "
    putStrLn $ show (verify "12360")
    putStr $ "verify '19291'                         -> "
    putStrLn $ show (verify "19291")
    putStr $ "verify '0'                             -> "
    putStrLn $ show (verify "0")
    putStr $ "verify '12350'                         -> "
    putStrLn $ show (verify "12350")
    putStr $ "verify '1'                             -> "
    putStrLn $ show (verify "1")
    putStrLn $ ""

    putStr $ "format '12360'                         -> "
    putStrLn $ show (format "12360")

helpUser :: IO ()
helpUser = do
    putStrLn $ "Digite uma das opções abaixo:"
    putStr $ "- '-c' ou '--calcular' e um número de CPF sem os dígitos "
    putStrLn $ "verificadores;"
    putStrLn $ "- '-f' ou '--formatar' e um número de CPF completo;"
    putStrLn $ "- '-v' ou '--verificar' e um número de CPF completo;"
    putStrLn $ "- '--demo'."

filterNumsAndFillWithZeros :: String -> Int -> String
filterNumsAndFillWithZeros text n
    | numDigits == 0 = ""
    | otherwise =
        let paddedDigits = replicate (max 0 (n - numDigits)) '0' ++ digits
        in take n paddedDigits
    where
        digits = filter isDigit text
        numDigits = length digits

calculateVerificationDigit :: String -> Int
calculateVerificationDigit onlyNums =
    let indexedChars = zip (reverse onlyNums) [2..]
        digitProducts = [digitToInt c * factor | (c, factor) <- indexedChars]
        total = sum digitProducts
        remainder = total `mod` 11
    in if remainder < 2 then 0 else 11 - remainder

calculateVerificationDigits :: String -> [Int]
calculateVerificationDigits cpf = [digit1, digit2]
    where
        cleanCpf = filterNumsAndFillWithZeros cpf 9
        digit1 = calculateVerificationDigit cleanCpf
        digit2 = calculateVerificationDigit (cleanCpf ++ show digit1)

verify :: String -> Bool
verify cpf =
    let onlyNums = filterNumsAndFillWithZeros cpf 11
        [d1, d2] = calculateVerificationDigits (take 9 onlyNums)
        lastTwoChars = map digitToInt (drop 9 onlyNums)
    in d1 == head lastTwoChars && d2 == last lastTwoChars

format :: String -> String
format cpf = intercalate "." [part1, part2, part3] ++ "-" ++ part4
    where
        onlyNums = filterNumsAndFillWithZeros cpf 11
        [part1, part2, part3, part4] = chunksOf 3 onlyNums
