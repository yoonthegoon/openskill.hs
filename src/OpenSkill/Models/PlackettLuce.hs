{-# LANGUAGE InstanceSigs #-}

module OpenSkill.Models.PlackettLuce where

import OpenSkill.Types
  ( Model (..),
    Options (..),
    Rating (..),
    Team,
  )
import OpenSkill.Utils (defaultOptions)

newtype PlackettLuce = PlackettLuce {options :: Options}

instance Model PlackettLuce where
  newRating :: PlackettLuce -> Rating
  newRating self = Rating (muI $ options self) (sigmaI $ options self)

  rate :: PlackettLuce -> [Team] -> [Team]
  rate _ _ = error "Not implemented"

plackettLuce :: PlackettLuce
plackettLuce = PlackettLuce defaultOptions
