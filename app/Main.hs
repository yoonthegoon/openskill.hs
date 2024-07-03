module Main where

import Data.Time.Clock (diffUTCTime, getCurrentTime)
import OpenSkill

main :: IO ()
main = do
  let rating = newRating bradleyTerryFull
  let team = [rating, rating, rating, rating]
  let teams = [team, team, team, team]
  start <- getCurrentTime
  print $ iterate (rate thurstoneMostellerFull) teams !! 32
  end <- getCurrentTime
  print $ diffUTCTime end start
