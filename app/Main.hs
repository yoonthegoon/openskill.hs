module Main where

import Data.Time.Clock (diffUTCTime, getCurrentTime)
import OpenSkill.Models.BradleyTerryFull
import OpenSkill.Models.ThurstoneMostellerFull
import OpenSkill.Types

main :: IO ()
main = do
  let model = bradleyTerryFull
  let rating = newRating model
  let team = [rating, rating, rating, rating]
  let teams = [team, team, team, team]
  start <- getCurrentTime
  let teams' = iterate (\t -> rate model t [0 ..]) teams !! 100000
  print teams'
  end <- getCurrentTime
  print $ diffUTCTime end start
  print $ sumd $ map sumd teams'
