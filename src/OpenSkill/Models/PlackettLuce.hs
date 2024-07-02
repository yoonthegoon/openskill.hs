{-# LANGUAGE InstanceSigs #-}

module OpenSkill.Models.PlackettLuce where

import OpenSkill.Types
  ( Match,
    Model (..),
    Options (..),
    Strength (..),
  )
import OpenSkill.Utils (defaultOptions)

newtype PlackettLuce = PlackettLuce {options :: Options}

instance Model PlackettLuce where
  newRating :: PlackettLuce -> Strength
  newRating self = Strength (mu $ options self) (sigma $ options self)

  drawProbability :: PlackettLuce -> Match -> Double
  drawProbability _ _ = error "Not implemeneted"

  winProbabilities :: PlackettLuce -> Match -> [Double]
  winProbabilities _ _ = error "Not implemented"

  rate :: PlackettLuce -> Match -> Match
  rate _ _ = error "Not implemented"

plackettLuce :: PlackettLuce
plackettLuce = PlackettLuce defaultOptions
