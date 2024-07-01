{-# LANGUAGE DeriveGeneric #-}

module OpenSkill.Types where

import GHC.Generics (Generic)

data Distribution = Distribution
  { mu :: Float,
    sigma :: Float
  }
  deriving (Show, Generic)

data Rating = Rating
  { theta :: Float,
    beta :: Float
  }
  deriving (Show, Generic)

type Rank = Int

type Ranks = [Rank]

type Team = [Rating]

type Teams = [Team]

defaultDistribution :: Distribution
defaultDistribution = Distribution 25 (25 / 3)

defaultRating :: Rating
defaultRating = Rating 25 (25 / 6)

class Model a where
  newRating :: a -> Rating
  rate :: a -> Teams -> Ranks -> Teams
  winProbability :: a -> Teams -> [Float]
