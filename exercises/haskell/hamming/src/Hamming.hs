module Hamming (distance) where

distance :: String -> String -> Maybe Int
distance [] [] = Just 0
distance _ _ = Nothing
distance (h:xs) (m:ys)
	| h /= m = fmap (1 +)(distance xs ys)
	| otherwise = distance xs ys
