{-# LANGUAGE InstanceSigs #-}

module OpenSkill.Models.BradleyTerryPart
  ( bradleyTerryPart,
    BradleyTerryPart (..),
  )
where

import OpenSkill.Types
  ( -- Distribution (..),
    Model (..),
    Options (..),
    Rating (..),
    Team,
  )
import OpenSkill.Utils
  ( defaultOptions,
    initialRating,
    -- update,
  )

bradleyTerryPart :: BradleyTerryPart
bradleyTerryPart = BradleyTerryPart defaultOptions

newtype BradleyTerryPart = BradleyTerryPart {options :: Options}

instance Model BradleyTerryPart where
  newRating :: BradleyTerryPart -> Rating
  newRating self = initialRating $ options self

  rate :: BradleyTerryPart -> [Team] -> [Int] -> [Team]
  rate _ _ _ = error "Not implemented"
