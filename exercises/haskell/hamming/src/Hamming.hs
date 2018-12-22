module Hamming (distance) where

distance :: String -> String -> Int

distance xs ys
    | length xs /= length ys = error("lists are not the same length")
    | otherwise = equalChar 0 xs ys
        where equalChar n xs ys = if xs == [] && ys == []
                           then n
                           else
                              if (head xs) /= (head ys)
                                   then equalChar (n + 1) (tail xs) (tail ys)
                                   else equalChar n (tail xs) (tail ys)
