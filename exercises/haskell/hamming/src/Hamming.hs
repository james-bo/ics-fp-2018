module Hamming (distance) where

distance :: String -> String -> Maybe Int
distance xs ys  | (length xs) /= (length ys) = Nothing | otherwise = distant 0 xs ys                
  where
    distant count [] [] = Just count
    distant count (j:xs) (i:ys) = 
      if j /= i
        then distant (count+1) xs ys
      else distant count xs ys
