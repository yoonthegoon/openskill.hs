{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE InstanceSigs #-}

module OpenSkill.Types
  ( Distribution (..),
    Rating (..),
    Team,
    Options (..),
    Model (..),
  )
where

import GHC.Generics (Generic)

class Distribution d where
  add :: d -> d -> d

  sumd :: [d] -> d
  sumd [] = error "No distributions to add"
  sumd (x : xs) = foldr add x xs

-- | A rating is a pair of mean and standard deviation
-- * @mu@ - mean
-- * @sigma@ - standard deviation
data Rating = Rating
  { mu :: Double,
    sigma :: Double
  }
  deriving (Show, Generic)

instance Distribution Rating where
  add :: Rating -> Rating -> Rating
  add self other =
    Rating
      { mu = mu self + mu other,
        sigma = sqrt $ sigma self ** 2 + sigma other ** 2
      }

type Team = [Rating]

-- | Options for the model
-- * @muI :: Double@ - player initial mean
-- * @sigmaI :: Double@ - player initial standard deviation
-- * @beta :: Double@ - added uncertainty
-- * @epsilon :: Double@ - draw margin
-- * @kappa :: Double@ - positive lower bound of player variance
-- * @gammaQ :: Double -> Double -> Double@ - function to control how fast player variance is reduced
data Options = Options
  { muI :: Double,
    sigmaI :: Double,
    beta :: Double,
    epsilon :: Double,
    kappa :: Double,
    gammaQ :: Double -> Double -> Double
  }
  deriving (Generic)

class Model m where
  newRating :: m -> Rating
  rate :: m -> [Team] -> [Int] -> [Team]
