{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE InstanceSigs #-}
{-# OPTIONS_GHC -Wno-type-defaults #-}

module OpenSkill.Types where

import GHC.Generics (Generic)

class Distribution d where
  add :: d -> d -> d
  sumd :: [d] -> d
  sumd [] = error "No distributions to add"
  sumd (d : ds) = foldr add d ds
  sub :: d -> d -> d

data Strength = Strength
  { mu' :: Double,
    sigma' :: Double
  }
  deriving (Show, Generic)

instance Distribution Strength where
  add :: Strength -> Strength -> Strength
  add self other =
    Strength
      { mu' = mu' self + mu' other,
        sigma' = sqrt $ sigma' self ^ 2 + sigma' other ^ 2
      }
  sub :: Strength -> Strength -> Strength
  sub self other =
    Strength
      { mu' = mu' self - mu' other,
        sigma' = sqrt $ sigma' self ^ 2 + sigma' other ^ 2
      }

type Team = [Strength]

type Match = [Team]

type Rank = Integer

type Ranks = [Rank]

type Gamma = Double -> Integer -> Double -> Double -> Team -> Integer -> Double

instance Show Gamma where
  show :: Gamma -> String
  show _ = "swappable gamma function"

data Options = Options
  { mu :: Double,
    sigma :: Double,
    beta :: Double,
    epsilon :: Double,
    kappa :: Double,
    gamma :: Maybe Gamma
  }
  deriving (Show, Generic)

class Model m where
  newRating :: m -> Strength
  drawProbability :: m -> Match -> Double
  winProbabilities :: m -> Match -> [Double]
  rate :: m -> Match -> Match

defaultOptions :: Options
defaultOptions =
  Options
    { mu = 25,
      sigma = 25 / 3,
      beta = 25 / 6,
      epsilon = 0.1,
      kappa = 0.0001,
      gamma = Nothing
    }
