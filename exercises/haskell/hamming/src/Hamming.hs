module Hamming (distance) where

distance :: String -> String -> Maybe Int
distance la lb = length (filter id (zipWith (/=) la lb))
