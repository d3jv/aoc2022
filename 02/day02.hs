import System.IO

main = do handle <- openFile "input" ReadMode
          contents <- hGetContents handle
          putStr "Task01: "
          (putStr . show . parse1) contents
          putStr "\nTask02: "
          (putStr . show . parse2) contents
          putStr "\n"
          return ()

charToScore 'A' = 1
charToScore 'B' = 2
charToScore 'C' = 3
charToScore 'X' = 1
charToScore 'Y' = 2
charToScore 'Z' = 3

roundScore 'A' 'X' = 3
roundScore 'B' 'Y' = 3
roundScore 'C' 'Z' = 3
roundScore 'A' 'Y' = 6
roundScore 'A' 'Z' = 0
roundScore 'B' 'X' = 0
roundScore 'B' 'Z' = 6
roundScore 'C' 'X' = 6
roundScore 'C' 'Y' = 0

parse1 :: String -> Int
parse1 [] = 0
parse1 (x:' ':y:'\n':xs) = charToScore y + roundScore x y + parse1 xs

parse2 :: String -> Int
parse2 [] = 0
parse2 (x:' ':y:'\n':xs) = let act = getAction x y in charToScore act + roundScore x (abcToXyz act) + parse2 xs
    where
        getAction x 'Y' = x
        getAction 'A' 'X' = 'C'
        getAction 'B' 'X' = 'A'
        getAction 'C' 'X' = 'B'
        getAction 'A' 'Z' = 'B'
        getAction 'B' 'Z' = 'C'
        getAction 'C' 'Z' = 'A'
       
        abcToXyz 'A' = 'X'
        abcToXyz 'B' = 'Y'
        abcToXyz 'C' = 'Z'

