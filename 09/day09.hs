import System.IO
import Data.List.Split
import Data.List

main = do handle <- openFile "input" ReadMode
          contents <- hGetContents handle
          putStr "Task1: "
          (putStr . show . task1) ((parse . splitOn "\n") contents)
          --(putStr . show . splitOn "\n") contents
          putStr "\nTask2: "
          (putStr . show . task2) (splitOn "\n" contents)
          putStr "\n"
          return ()

parse :: [String] -> [(Char, Int)]
parse [] = []
parse ([]:xs) = parse xs
parse (x:xs) = (head x, (read . drop 2) x) : parse xs

task1 :: [(Char, Int)] -> Int
task1 db = (length . nub . removeIterate . task 0 0) db
    where
        task _ _ [] = []
        task x y ((c, n):xs)
            | c == 'U' = move x y 1 0 n ++ task (x+n) y xs
            | c == 'D' = move x y (-1) 0 n ++ task (x-n) y xs
            | c == 'R' = move x y 0 1 n ++ task x (y+n) xs
            | c == 'L' = move x y 0 (-1) n ++ task x (y-n) xs

        move _ _ _ _ 0 = []
        move x y a b n = (x+a, y+b) : move (x+a) (y+b) a b (n-1)

        removeEdges (a@(x1,y1):b@(_,_):c@(x3,y3):xs)
            | abs (x1-x3) <= 1 && abs (y1-y3) <= 1 = a : c : removeEdges xs
            | otherwise = a : b : c : removeEdges xs
        removeEdges xs = xs

        removeIterate xs = let ys = removeEdges xs in
                           if length ys == length xs then xs
                           else removeIterate ys

task2 :: [String] -> Int
task2 = undefined

