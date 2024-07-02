{-# LANGUAGE InstanceSigs #-}

module OpenSkill.Models.ThurstoneMostellerFull where

import OpenSkill.Types
  ( Match,
    Model (..),
    Options (..),
    Strength (..),
  )
import OpenSkill.Utils (defaultOptions)

newtype ThurstoneMostellerFull = ThurstoneMostellerFull {options :: Options}

instance Model ThurstoneMostellerFull where
  newRating :: ThurstoneMostellerFull -> Strength
  newRating self = Strength (mu $ options self) (sigma $ options self)

  drawProbability :: ThurstoneMostellerFull -> Match -> Double
  drawProbability _ _ = error "Not implemeneted"

  winProbabilities :: ThurstoneMostellerFull -> Match -> [Double]
  winProbabilities _ _ = error "Not implemented"

  rate :: ThurstoneMostellerFull -> Match -> Match
  rate _ _ = error "Not implemented"

thurstoneMostellerFull :: ThurstoneMostellerFull
thurstoneMostellerFull = ThurstoneMostellerFull defaultOptions
