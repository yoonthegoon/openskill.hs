{-# LANGUAGE InstanceSigs #-}

module OpenSkill.Models.BradleyTerryPart where

import OpenSkill.Types
  ( Model (..),
    Options (..),
    Rating (..),
    Team,
  )
import OpenSkill.Utils (defaultOptions)

newtype BradleyTerryPart = BradleyTerryPart {options :: Options}

instance Model BradleyTerryPart where
  newRating :: BradleyTerryPart -> Rating
  newRating self = Rating (muI $ options self) (sigmaI $ options self)

  rate :: BradleyTerryPart -> [Team] -> [Team]
  rate _ _ = error "Not implemented"

bradleyTerryPart :: BradleyTerryPart
bradleyTerryPart = BradleyTerryPart defaultOptions
