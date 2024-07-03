{-# LANGUAGE InstanceSigs #-}
{-# OPTIONS_GHC -Wno-type-defaults #-}

module OpenSkill.Models.PlackettLuce where

import OpenSkill.Types
  ( -- Distribution (..),
    Model (..),
    Options (..),
    Rating (..),
    Team,
  )
import OpenSkill.Utils
  ( defaultOptions,
  -- update,
  )

plackettLuce :: PlackettLuce
plackettLuce = PlackettLuce defaultOptions

newtype PlackettLuce = PlackettLuce {options :: Options}

instance Model PlackettLuce where
  newRating :: PlackettLuce -> Rating
  newRating self = Rating (muI $ options self) (sigmaI $ options self)

  rate :: PlackettLuce -> [Team] -> [Team]
  rate _ _ = error "Not implemented"
