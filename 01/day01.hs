import System.IO

main = do handle <- openFile "input" ReadMode
          contents <- hGetContents handle
          putStr "Task01: "
          (putStr . show . maximum . sumCalories) contents
          putStr "\nTask02: "
          (putStr . show . sum . maxN 3 . sumCalories) contents 
          putStr "\n"
          return ()

maxN :: Integer -> [Integer] -> [Integer]
maxN 0 _ = []
maxN n xs = let m = maximum xs in m : maxN (n-1) (remove m xs)

remove :: Eq a => a -> [a] -> [a]
remove x = filter (/=x) 

sumCalories :: String -> [Integer]
sumCalories [] = []
sumCalories xs = sumOne xs : sumCalories (dropElf xs)
    where
        getline :: String -> String
        getline = takeWhile (/='\n')

        dropline :: String -> String
        dropline = (drop 1 . dropWhile (/='\n'))

        dropElf :: String -> String
        dropElf [] = []
        dropElf [_] = []
        dropElf (x:y:xs) = if x == y && x == '\n' then xs else dropElf (y:xs)

        sumOne :: String -> Integer
        sumOne [] = 0
        sumOne xs@(x:_) = if x == '\n' then 0 else (read . getline) xs + sumOne (dropline xs)
