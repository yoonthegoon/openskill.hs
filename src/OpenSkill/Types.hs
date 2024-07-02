{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE InstanceSigs #-}
{-# OPTIONS_GHC -Wno-type-defaults #-}

module OpenSkill.Types
  ( Distribution (..),
    Strength (..),
    Team,
    Match,
    Rank,
    Ranks,
    Gamma,
    Options (..),
    Model (..),
  )
where

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
