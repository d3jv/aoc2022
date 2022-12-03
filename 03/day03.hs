import System.IO
import Data.Char
import Data.List.Split
import Data.List.Split.Internals
import Data.List (sort)

main = do handle <- openFile "input" ReadMode
          contents <- hGetContents handle
          putStr "Task1: "
          (putStr . show . task1) (splitOn "\n" contents)
          putStr "\nTask2: "
          (putStr . show . task2) (splitOn "\n" contents)
          putStr "\n"
          return ()

ord' x
    | isLower x = ord x - 96
    | isUpper x = ord x - 38
    | otherwise = 0

task2 :: [String] -> Int
task2 = (sum . map (getCommon3 . map (sort . map ord')) . group3)
    where
        group3 :: [a] -> [[a]]
        group3 [] = []
        group3 xs = take 3 xs : group3 (drop 3 xs)

        getCommon3 :: (Num a, Ord a) => [[a]] -> a
        getCommon3 [xs, ys, zs] = head (intersectSorted xs (intersectSorted ys zs))
        getCommon3 _ = 0

halve :: [a] -> [[a]]
halve xs = let len = (length xs) `div` 2 in [(take len xs), (drop len xs)]

task1 :: [String] -> Int
task1 = (sum . map (getCommon . map (sort . map ord') . halve))
    where
        getCommon :: (Num a, Ord a) => [[a]] -> a
        getCommon [xs, ys] = head (intersectSorted xs ys)

intersectSorted :: (Num a, Ord a) => [a] -> [a] -> [a]
intersectSorted (x:xs) (y:ys)
 | x == y    = x : intersectSorted xs ys
 | x < y     = intersectSorted xs (y:ys)
 | x > y     = intersectSorted (x:xs) ys
intersectSorted _ _ = [0]
