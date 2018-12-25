module Hamming (distance) where

-- если Guard используем, то не надо (=) ставить. (чтобы закомментировать пришлось взять = в скобочки)
-- Guard - потому что в туториале говорят, что это тру, а скобочки хрень. что на деле - хз
-- distance xs ys (=)
-- All program code that belongs to a function definition has to be further to the right than the first character of that definition (i.e., the first character of the function name). In the case of distance, all code has to be further to the right than the column in which the character d of the function name distance is located.
-- Similarly, all code of a local definition in a where clause must be further to the right than the first character of the name of the variable defined by the binding.
-- All definitions within a where clause must be aligned — e.g., above the definitions of dx and dy start in the same column.
distance :: String -> String -> Maybe Int
distance xs ys 
    | (length xs) /= (length ys)    = Nothing
    | otherwise                     = Just $ distance_ xs ys 0 -- or Just (dist xs ys 0)

    -- . - function composition !!! right associative !!!
    -- putStr . checkLocalhost $ "173.194.22.100"
    -- String ->│checkLocalhost│-> String ->│putStrLn│-> ...
    -- dot operator: composedFunc = String ->│checkLocalhost and putStrLn│-> ...
    -- $ - application operator
    -- composedFunct применяется к аргументу "173.194.22.100"
    --    putStrLn . checkLocalhost $ "173.194.22.100"
    -- <-         <-               <- arg
    -- 
    -- (putStrLn . show) (1 + 1)
    -- same
    -- putStrLn . show $ 1 + 1

distance_ :: String -> String -> Int -> Int
distance_ [] [] dist            -- base case
    = dist
distance_ (x:xs) (y:ys) dist    -- recursive/stepping case (эт как в прологе)
    | x == y    = distance_ xs ys dist      -- Partial Functions [x:xs]
    | otherwise = distance_ xs ys (dist+1)

