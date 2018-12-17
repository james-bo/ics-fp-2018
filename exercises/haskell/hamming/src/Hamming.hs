module Hamming (distance) where

distance :: String -> String -> Maybe Int
distance la lb = if length la /= length lb then Nothing
  else Just (length (filter id (zipWith (/=) la lb)))
