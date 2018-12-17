module Hamming (distance) where

distance :: String -> String -> Maybe Int

distance (x:xs) (y:ys) | x /= y = fmap (+1) dist
                       | otherwise = dist
    where dist = distance xs ys
distance [] [] = Just 0
distance [] _ = Nothing
distance _ [] = Nothing