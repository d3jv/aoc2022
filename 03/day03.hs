import Data.List.Split
import Data.List.Split.Internals
import Data.List (sort)

main = do handle <- openFile "input" ReadMode
          contents <- hGetContents handle
          xs <- splitOn "\n" contents
          putStr "Task1: "
          (putStr . task1 xs)
          return ()

halve :: [a] -> [[a]]
halve xs = let len = (length xs) `div` 2 in [(take len xs), (drop len xs)]

task1 :: [[a]] -> Int
task1 = (sum . map intersectSorted . map ((map (sort . map ord) . halve)))

getCommon :: [a] -> [a] -> a
getCommon xs ys = (head . intersectSorted) xs ys

intersectSorted :: Ord a => [a] -> [a] -> [a]
intersectSorted (x:xs) (y:ys)
 | x == y    = x : intersectSorted xs ys
 | x < y     = intersectSorted xs (y:ys)
 | x > y     = intersectSorted (x:xs) ys
intersectSorted _ _ = []
