{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

import Data.Aeson
import qualified Data.ByteString.Lazy as B
import GHC.Generics
import Network.HTTP
import Network.URI (parseURI)
import Text.XML.HXT.Core
import Text.HandsomeSoup
import Data.Maybe (fromJust)

-- https://blockchain.info/tobtc?currency=USD&value=27500 // Obtener valor de BTC en CURRENCY
-- https://api.blockchain.info/stats // BTC Stats

let statsUri = fromUrl "https://api.blockchain.info/stats"

data Stats = Stats { market_price_usd :: Float
    , timestamp :: Int
    , hash_rate :: Float
    , total_fees_btc :: Float
    , n_btc_mined :: Int
    , n_tx :: Int
    , n_blocks_mined :: Int
    , minutes_between_blocks :: Float
    , totalbc :: Int
    , n_blocks_total :: Int
    , estimated_transaction_volume_usd :: Float
    , blocks_size :: Int
    , miners_revenue_usd :: Float
    , nextretarget :: Int
    , difficulty :: Int
    , estimated_btc_sent :: Int
    , miners_revenue_btc :: Int
    , total_btc_sent :: Int
    , trade_volume_btc :: Float
    , trade_volume_usd :: Float
    } deriving Generic

data Crypto = Crypto { fifteenminutes :: Float
    , last :: Float
    , buy :: Float
    , sell :: Float
    , symbol :: String
    , name :: String
    } deriving Generic

-- deriving instance FromJSON Crypto
instance FromJSON Stats

{- 
main = do
  input <- B.readFile "crypto.json"
  let cryptomm = decode input :: Maybe Crypto
  case cryptomm of
    Nothing -> print "error parsing crypto.json"
    Just crypto -> (putStrLn.message) crypto
-}
main = do
  input <- B.readFile "stats.json"
  let statsmm = decode input :: Maybe Stats
  case statsmm of
    Nothing -> print "error parsing stats.json"
    Just stats -> (putStrLn.message) stats 
    
-- message crypto = "\n The price of "++(show.name) crypto ++" is $"++ (show.buy) crypto ++ "\n"
message stats = "\nTimestamp "++(show.timestamp) stats 
                ++"Precio de mercado (USD): $"++ (show.market_price_usd) stats ++ "\n"
                ++"Hash rate: "++ (show.hash_rate) stats ++ "\n"
                ++"Comisiones totales (BTC): "++ (show.total_fees_btc) stats ++ "\n"
                ++"Nº BTC minados: "++ (show.n_btc_mined) stats ++ "\n"
                ++"Nº bloques minados: "++ (show.n_blocks_mined) stats ++ "\n"
                ++"Nº total de bloques: "++ (show.n_blocks_total) stats ++ "\n"
                ++"Volúmen estimado de transacciones (USD): $"++ (show.estimated_transaction_volume_usd) stats ++ "\n"
                ++"Tamaño de bloques: "++ (show.blocks_size) stats ++ "\n"
                ++"Ganancias de los mineros (USD): $"++ (show.miners_revenue_usd) stats ++ "\n"
                ++"Ganancias de los mineros (BTC): "++ (show.miners_revenue_btc) stats ++ "\n"
                ++"Total de Bitcoin enviado: "++ (show.total_btc_sent) stats ++ "\n"

