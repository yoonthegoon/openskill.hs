module Main where

import OpenSkill

main :: IO ()
main = do
  let rating = newRating bradleyTerryFull
  let teamI = [rating, rating]
  let teamsQ = teamI
  print $ rate bradleyTerryFull [teamI, teamsQ]
