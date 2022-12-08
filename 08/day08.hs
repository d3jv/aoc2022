import System.IO
import Data.List.Split
import Data.Char

main = do handle <- openFile "input" ReadMode
          contents <- hGetContents handle
          putStr "Task1: "
          (putStr . show . task1) (splitOn "\n" contents)
          putStr "\nTask2: "
          (putStr . show . task2) (splitOn "\n" contents)
          putStr "\n"
          return ()

parse :: [String] -> [[(Int, Bool)]]
parse = map (map (\x -> (x, False)) . map digitToInt)

isVisible :: Int -> Int -> [[(Int, Bool)]] -> Bool
isVisible x y xs = isVisibleCol x y xs && isVisibleRow y (xs !! x)
    where
        isVisibleCol :: Int -> Int -> [[(Int, Bool)]] -> Bool
        isVisibleCol x i = (isVisibleRow x . map (!!i))

        isVisibleRow :: Int -> [(Int, Bool)] -> Bool
        isVisibleRow i xs = let ys = unPair xs
                                x = ys !! i 
                            in 
                            allSmaller x (take i ys) && allSmaller x (drop (i+1) ys)

        allSmaller :: Ord a => a -> [a] -> Bool
        allSmaller _ [] = True
        allSmaller x = (and . map (<x))

        unPair :: [(a, b)] -> [a]
        unPair = map (\(x, _) -> x)

task1 :: [[(Int, Bool)]] -> Int
task1 = 
    where
        setVisible 

task2 :: [String] -> Int
task2 = undefined

