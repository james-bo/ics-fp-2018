module Hamming (distance) where

import Data.Maybe

distance :: String -> String -> Maybe Int
distance [] [] = Just 0
distance [] y = Nothing
distance x [] = Nothing

distance (x:xs) (y:ys)
    | hammingDistance == Nothing = Nothing
    | x /= y = Just (1 + (fromMaybe 0 hammingDistance))
    | otherwise = hammingDistance
    where
        hammingDistance = distance xs ys