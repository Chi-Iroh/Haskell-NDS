import Data.Char (chr)
import Foreign.C.String
import Random

foreign import ccall "helpers.h iputs" iputs :: CString -> IO ()

foreign import ccall "nds.h consoleDemoInit" consoleDemoInit :: IO ()
foreign import ccall "nds.h consoleClear" consoleClear :: IO ()
foreign import ccall "nds.h swiWaitForVBlank" swiWaitForVBlank :: IO ()

foreign import ccall "nds.h keyboardDemoInit" keyboardDemoInit :: IO ()
foreign import ccall "nds.h keyboardShow" keyboardShow :: IO ()
foreign import ccall "nds.h keyboardUpdate" keyboardUpdate :: IO Int

foreign import ccall "nds.h soundEnable" soundEnable :: IO ()
foreign import ccall "nds.h soundPlayPSG" soundPlayPSG :: Int -> Int -> Int -> Int -> IO Int
foreign import ccall "nds.h soundSetFreq" soundSetFreq :: Int -> Int -> IO ()

foreign import ccall "nds.h scanKeys" scanKeys :: IO ()
foreign import ccall "helpers.h isTouching" isTouching :: Bool
foreign import ccall "helpers.h getTouchX" getTouchX :: Int
foreign import ccall "helpers.h getTouchY" getTouchY :: Int

foreign import ccall "helpers.h oamMainInit" oamMainInit :: IO ()
foreign import ccall "helpers.h oamMainSet" oamMainSet :: Int -> Int -> IO ()
foreign import ccall "helpers.h oamMainColor" oamMainColor :: Int -> Int -> Int -> IO ()
foreign import ccall "helpers.h oamMainUpdate" oamMainUpdate :: IO ()

foreign import primitive "const.DutyCycle_50" dutyCycle_50 :: Int

printFreq :: Int -> IO ()
printFreq freq = do
    consoleClear
    print freq

setSound :: Int -> Int -> IO ()
setSound sound freq = do
    soundSetFreq sound freq
    printFreq freq

keyLoop :: Int -> IO ()
keyLoop sound = do
    x <- keyboardUpdate
    scanKeys
    if x > 0 then do
            setSound sound $ x * 100
            putChar $ chr x
        else if isTouching then do
            if getTouchY < 110 then do
                    setSound sound $ getTouchY * 100
                    print getTouchY
                else
                    return ()
            r <- randomRIO (0, 31)
            oamMainColor r 0 0
            oamMainSet getTouchX getTouchY
        else
            return ()

    swiWaitForVBlank
    oamMainUpdate
    keyLoop sound

main :: IO ()
main = do
    consoleDemoInit
    withCString "Hello, World!" iputs
    keyboardDemoInit
    keyboardShow
    soundEnable
    sound <- soundPlayPSG dutyCycle_50 10000 127 64
    oamMainInit
    keyLoop sound
