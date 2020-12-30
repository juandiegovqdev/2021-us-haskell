{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}
import Data.Aeson
import qualified Data.ByteString.Lazy as B
import GHC.Generics

data Crypto = Crypto { fifteenminutes :: Float
                                   , last :: Float
                                   , buy :: Float
                                   , sell :: Float
                                   , symbol :: String
                                   , name :: String
                                   } deriving Generic

instance FromJSON Crypto

main = do
  input <- B.readFile "input.json"
  let mm = decode input :: Maybe Crypto
  case mm of
    Nothing -> print "error parsing JSON"
    Just m -> (putStrLn.message) m
    
message m = "\n The price of the following cryptocurrency: " ++ (show.name) m ++" is $"++ (show.buy) m ++ "\n"

