import System.IO
import Data.List.Split
import Data.List

main = do handle <- openFile "input" ReadMode
          contents <- hGetContents handle
          putStr "Task1: "
          (putStr . show . task1) contents
          putStr "\nTask2: "
          (putStr . show . task2) contents
          putStr "\n"
          return ()

task1 :: String -> Int
task1 = uniqueSeq 4

task2 :: String -> Int
task2 = uniqueSeq 14 

uniqueSeq :: Eq a => Int -> [a] -> Int
uniqueSeq n xs = if allDifferent (take n xs)
                 then n else 1 + uniqueSeq n (tail xs)

allDifferent :: Eq a => [a] -> Bool
allDifferent xs = length xs == (length . nub) xs
