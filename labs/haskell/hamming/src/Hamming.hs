module Hamming (distance) where

distance :: String -> String -> Maybe Int
distance xs ys  | (length xs) /= (length ys) = Nothing | otherwise = distan 0 xs ys                
  where
    distan count [] [] = Just count
    distan count (k:xs) (n:ys) = 
      if k /= n
        then distan (count+1) xs ys
      else distan count xs ys
