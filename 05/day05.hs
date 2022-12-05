import System.IO
import Data.List.Split
import Data.Char

main = do handle <- openFile "input" ReadMode
          contents <- hGetContents handle
          putStr "Task1: "
          (putStr . show . (map head) . flip task1 initial)
                            ((parse . splitOn "\n") contents)
          putStr "\nTask2: "
          --(putStr . show . task2) (splitOn "\n" contents)
          putStr "\n"
          return ()

initial :: [[Char]]
initial = ["FRW","PWVDCMHT","LNZMP","RHCJ","BTQHGPC","ZFLWCG","CGJZQLVW","CVTWFRNP","VSRGHWJ"]

parse :: [String] -> [[Int]]
parse = map parseSingle
    where
        parseSingle = (map read . filter isNumber . splitOn " ")
        
        isNumber [] = False
        isNumber (x:_) = isDigit x


task1 :: [[Int]] -> [[Char]] -> [[Char]]  --TASK 2: uncomment the reverse
task1 ([x, y, z]:xs) crates = let move = ({-reverse . -}take x) (crates !! (y-1)) in
                       task1 xs (((changeElem (z-1) (move++))
                               . changeElem (y-1) (drop x)) crates)
    where
        changeElem :: Int -> ([a] -> [a]) -> [[a]] -> [[a]]
        changeElem i foo xs = (take i xs) ++ (foo (xs !! i) : (drop (i+1) xs))
task1 _ crates = crates


task2 :: [String] -> a
task2 = undefined

