module OpenSkill.Models.BradleyTerryPart where

import OpenSkill.Types
  ( Model (..),
    Options (..),
    Strength (..),
    defaultOptions,
  )

newtype BradleyTerryPart = BradleyTerryPart {options :: Options}

instance Model BradleyTerryPart where
  newRating self = Strength (mu $ options self) (sigma $ options self)
  drawProbability _ _ = error "Not implemeneted"
  winProbabilities _ _ = error "Not implemented"
  rate _ _ = error "Not implemented"

bradleyTerryPart :: BradleyTerryPart
bradleyTerryPart = BradleyTerryPart defaultOptions
