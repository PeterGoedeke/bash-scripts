import System.IO ( openFile, hGetContents, IOMode(ReadMode) )
import System.Directory
    ( canonicalizePath, doesDirectoryExist, getDirectoryContents )
import Data.List (isSuffixOf)
import System.FilePath ( (</>) )

main :: IO ()
main = do
    path <- getLine
    count <- dirWords path
    print count

dirWords :: String -> IO Integer
dirWords a = do
    isDir <- doesDirectoryExist a
    if isDir
        then do
            contents <- getAbsDirectoryContents a
            sum <$> mapM dirWords (filter (\n -> length n > length a) contents)
        else do
            if ".md" `isSuffixOf` a
                then wordCount a else return 0

getAbsDirectoryContents :: FilePath -> IO [FilePath]
getAbsDirectoryContents dir =
  getDirectoryContents dir >>= mapM (canonicalizePath . (dir </>))

wordCount :: String -> IO Integer
wordCount a = do
    handle <- openFile a ReadMode
    contents <- hGetContents handle
    return $ fromIntegral $ length $ words contents