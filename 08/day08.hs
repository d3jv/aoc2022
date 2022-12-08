import System.IO
import Data.List.Split
import Data.Char
import Data.Bool

main = do handle <- openFile "input" ReadMode
          contents <- hGetContents handle
          putStr "Task1: "
          (putStr . show . task1) ((parse . splitOn "\n") contents)
          --(putStr . show . parse . splitOn "\n") contents
          putStr "\nTask2: "
          (putStr . show . task2) ((parse . splitOn "\n") contents)
          putStr "\n"
          return ()

parse :: [String] -> [[Int]]
parse = map (map digitToInt)

isVisible :: Int -> Int -> [[Int]] -> Bool
isVisible a b as = isVisibleCol a b as || isVisibleRow b (as !! a)
    where
        isVisibleCol :: Int -> Int -> [[Int]] -> Bool
        isVisibleCol x i = (isVisibleRow x . map (!!i))

        isVisibleRow :: Int -> [Int] -> Bool
        isVisibleRow i xs = if i == 0 || i == length xs - 1 then True else 
                            let x = xs !! i 
                            in allSmaller x (take i xs)
                            || allSmaller x (drop (i+1) xs)

        allSmaller :: Ord a => a -> [a] -> Bool
        allSmaller _ [] = True
        allSmaller x xs = (and . map (<x)) xs

        unPair :: [(a, b)] -> [a]
        unPair = map (\(x, _) -> x)

task1 :: [[Int]] -> Integer
task1 db = (sum . map (sum . map (\x -> bool 0 1 x)) . task 0) db
    where
        task _ [] = []
        task x (a:xs) = row x 0 a : task (x+1) xs

        row _ _ [] = []
        row x y (a:xs) = (isVisible x y db) : row x (y+1) xs

task2 :: [[Int]] -> Int
task2 db = (maximum . map maximum . task 0) db
    where
        task _ [] = []
        task x (a:xs) = frow x 0 a : task (x+1) xs

        frow _ _ [] = []
        frow x y (a:xs) = let row = db !! x
                              col = map (!!y) db
                              n = row !! y
                         in
                             (countVisible n ((reverse . take y) row) *
                             countVisible n (drop (y+1) row) *
                             countVisible n ((reverse . take x) col) *
                             countVisible n (drop (x+1) col)) : (frow x (y+1) xs)

        countVisible :: Int -> [Int] -> Int
        countVisible _ [] = 0
        countVisible n (x:xs) = if x >= n then 1 else 1 + countVisible n xs

