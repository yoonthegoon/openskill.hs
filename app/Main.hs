module Main where

import OpenSkill (Rating (..), sumRatings)

main :: IO ()
main = do
  print rating
  where
    rating =
      sumRatings
        [ Rating 25 (25 / 6),
          Rating 25 (25 / 6)
        ]
