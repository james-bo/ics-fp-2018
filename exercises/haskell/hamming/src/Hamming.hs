module Hamming (distance) where

distance :: String -> String -> Maybe Int

distance "" "" = Just 0
distance x y 
    | (length x /= length y) = Nothing
    | (last x ==  last y) = dst
    | otherwise = fmap (+1) dst
    where dst = distance (init x) (init y)