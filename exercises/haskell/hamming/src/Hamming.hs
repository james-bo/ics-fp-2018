module Hamming (distance) where

distance :: String -> String -> Maybe Integer
distance xs ys = distance' xs ys 0
		where 
        distance' [] [] c = Just c
        distance' xs [] _ = Nothing
        distance' [] ys _ = Nothing 
        distance' (h1:t1) (h2:t2) c | h1 /= h2 = distance' t1 t2 (c + 1)
                                  | otherwise = distance' t1 t2 c