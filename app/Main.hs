module Main where

import OpenSkill (Rating (..), teamPerformance)

main :: IO ()
main = do
  let t1 =
        [ Rating 25 (25 / 6),
          Rating 25 (25 / 6)
        ]
  let r1 = teamPerformance t1
  print $ beta r1
  print [theta rating, beta rating]
  where
    rating =
      teamPerformance
        [ Rating 25 (25 / 6),
          Rating 25 (25 / 6)
        ]
