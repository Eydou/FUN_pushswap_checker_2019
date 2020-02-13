import System.Environment
import System.Exit
import Data.List

myFailExit = exitWith (ExitFailure 84)

echochecker :: [String] -> Bool
echochecker [] = True
echochecker (a:as) = case a of
    "sa" -> echochecker as
    "sb" -> echochecker as
    "sc" -> echochecker as
    "pa" -> echochecker as
    "pb" -> echochecker as
    "ra" -> echochecker as
    "rb" -> echochecker as
    "rr" -> echochecker as
    "rra" -> echochecker as
    "rrb" -> echochecker as
    "rrr" -> echochecker as
    _ -> False

intchecker :: [String] -> Bool
intchecker [] = True
intchecker (a:as)
    | length (filter (\x -> x >= '0' && x <= '9' || x == '-') a) == length a = intchecker as
    | otherwise = False

convertparams :: [String] -> [Int]
convertparams params = map read params

deleteN :: [Int] -> Int -> [Int]
deleteN list n = mappend (take (n - 1) list) (drop n list)

rotateElem :: Int -> [Int] -> [Int]
rotateElem _ [] = []
rotateElem elem list = take (length list) (drop elem (cycle list))

swapelem2list :: [Int] -> Int -> [Int]
swapelem2list list elem = [elem] ++ list

swap2elem :: [Int] -> [Int]
swap2elem list = [list !! 1] ++ (deleteN list 2)

moove :: [Int] -> [Int] -> [String] -> IO ()
moove la lb [] = do
    if (la /= []) && la == (sort la) then putStrLn "OK"
    else if (lb /= []) && lb == (sort lb) then putStrLn "OK"
    else putStrLn "KO"
moove la lb (action:actions) 
    | action == "sa" && (length la) > 1 = moove (swap2elem la) lb actions
    | action == "sb" && (length lb) > 1 = moove la (swap2elem lb) actions
    | action == "sc" && (length la) > 1 = moove (swap2elem la) (swap2elem lb) actions
    | action == "pa" && (length lb) > 0 = moove (swapelem2list la (lb !! 0)) (tail lb) actions
    | action == "pb" && (length la) > 0 = moove (tail la) (swapelem2list lb (la !! 0)) actions
    | action == "ra" = moove (rotateElem 1 la) lb actions
    | action == "rb" = moove la (rotateElem 1 lb) actions
    | action == "rr" = moove (rotateElem 1 la) (rotateElem 1 lb) actions
    | action == "rra" = moove (rotateElem (length la - 1) la) lb actions
    | action == "rrb" = moove la (rotateElem (length lb - 1) lb) actions
    | action == "rrr" = moove (rotateElem (length la - 1) la) (rotateElem (length lb - 1) lb) actions
    | otherwise = moove la lb actions

myecho params = do
    str <- getLine
    if (echochecker (words str)) == False || (intchecker (params)) == False
        then myFailExit
    else moove (convertparams params) [] (words str)

myParams [] = myFailExit
myParams params = do
    myecho params

main = getArgs >>= myParams