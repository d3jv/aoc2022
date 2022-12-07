import System.IO
import Data.List.Split

main = do handle <- openFile "input" ReadMode
          contents <- hGetContents handle
          putStr "Task1: "
          (putStr . show . task1) (splitOn "\n" contents)
          putStr "\nTask2: "
          (putStr . show . task2) (splitOn "\n" contents)
          putStr "\n"
          return ()

task1 :: [String] -> Int
task1 = undefined

task2 :: [String] -> Int
task2 = undefined

