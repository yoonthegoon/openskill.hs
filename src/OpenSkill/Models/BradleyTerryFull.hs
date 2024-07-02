module OpenSkill.Models.BradleyTerryFull where

import OpenSkill.Types
  ( Model (..),
    Options (..),
    Strength (..),
    defaultOptions,
  )

newtype BradleyTerryFull = BradleyTerryFull {options :: Options}

instance Model BradleyTerryFull where
  newRating self = Strength (mu $ options self) (sigma $ options self)
  drawProbability _ _ = error "Not implemeneted"
  winProbabilities _ _ = error "Not implemented"
  rate _ _ = error "Not implemented"

bradleyTerryFull :: BradleyTerryFull
bradleyTerryFull = BradleyTerryFull defaultOptions
