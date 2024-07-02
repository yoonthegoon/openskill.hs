{-# LANGUAGE InstanceSigs #-}

module OpenSkill.Models.BradleyTerryPart where

import OpenSkill.Types
  ( Match,
    Model (..),
    Options (..),
    Strength (..),
  )
import OpenSkill.Utils (defaultOptions)

newtype BradleyTerryPart = BradleyTerryPart {options :: Options}

instance Model BradleyTerryPart where
  newRating :: BradleyTerryPart -> Strength
  newRating self = Strength (mu $ options self) (sigma $ options self)

  drawProbability :: BradleyTerryPart -> Match -> Double
  drawProbability _ _ = error "Not implemeneted"

  winProbabilities :: BradleyTerryPart -> Match -> [Double]
  winProbabilities _ _ = error "Not implemented"

  rate :: BradleyTerryPart -> Match -> Match
  rate _ _ = error "Not implemented"

bradleyTerryPart :: BradleyTerryPart
bradleyTerryPart = BradleyTerryPart defaultOptions
