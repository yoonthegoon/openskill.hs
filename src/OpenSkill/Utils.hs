module OpenSkill.Utils where

import OpenSkill.Types

addRatings :: Rating -> Rating -> Rating
-- ^ Add two ratings together.
--
-- @
-- addRatings Rating -> Rating -> Rating
-- @
-- * @Rating@: The strength of the player and the uncertainty of their performance.
addRatings r1 r2 = Rating (theta r1 + theta r2) (sqrt $ beta r1 ^ (2 :: Int) + beta r2 ^ (2 :: Int))

sumRatings :: Team -> Rating
-- ^ Sum the ratings of a team.
--
-- @
-- sumRatings Team -> Rating
-- @
-- * @Team@: @[Rating]@ The team whose ratings are to be summed.
-- * @Rating@: The strength of the team and the uncertainty of its performance.
sumRatings = foldr addRatings (Rating 0 0)
