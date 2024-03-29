import Data.Char (isDigit)

main :: IO ()
main = do
    demo

demo :: IO ()
demo = do 
    putStrLn $ "reterNumeros 'test'    1 -> '" ++ reterNumeros "test"    1 ++ "'"
    putStrLn $ "reterNumeros 'test123' 2 -> '" ++ reterNumeros "test123" 2 ++ "'"
    putStrLn $ "reterNumeros 'test123' 4 -> '" ++ reterNumeros "test123" 4 ++ "'"

reterNumeros :: String -> Int -> String
reterNumeros text n
    | numDigits == 0 = ""
    | otherwise = let paddedDigits = replicate (max 0 (n - numDigits)) '0' ++ digits
                  in take n paddedDigits
    where digits = filter isDigit text
          numDigits = length digits
