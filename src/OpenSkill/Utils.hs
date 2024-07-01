module OpenSkill.Utils where

import OpenSkill.Types (Rating (..), Team)

teamPerformance :: Team -> Rating
-- ^ Get the strength of a team and the uncertainty of its performance.
--
-- @
-- teamPerformance Team -> Rating
-- @
-- * @Team@: A list of ratings.
-- * @Rating@: The strength of the team and the uncertainty of its performance.
teamPerformance team =
  Rating
    { theta = sum (map theta team),
      beta = sqrt $ sum (map (\r -> beta r ^ (2 :: Int)) team)
    }
