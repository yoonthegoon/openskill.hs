module OpenSkill.Types where

-- | A team's rank in a match; lower is better.
type Rank = Int

type Ranks = [Rank]

-- | Assumed distribution of players' skill.
data Distribution = Distribution
  { -- | The mean of the distribution.
    mu :: Float,
    -- | The standard deviation of the distribution.
    sigma :: Float
  }
  deriving (Show)

-- | A player's skill.
data Rating = Rating
  { -- | Strength of the player.
    theta :: Float,
    -- | Uncertainty of the player's performance.
    beta :: Float
  }
  deriving (Show)

-- | A team is a list of ratings.
type Team = [Rating]

type Teams = [Team]

class Model m where
  -- | Update the ratings of the teams after a match.
  rate :: m -> Teams -> Teams

  -- | Compute the probability of each team winning.
  winProbability :: m -> Teams -> [Float]

data BradleyTerry = BradleyTerry

data PlackettLuce = PlackettLuce

data ThurstoneMosteller = ThurstoneMosteller
