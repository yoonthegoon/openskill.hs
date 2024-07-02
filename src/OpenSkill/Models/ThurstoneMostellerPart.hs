{-# LANGUAGE InstanceSigs #-}

module OpenSkill.Models.ThurstoneMostellerPart where

import OpenSkill.Types
  ( Match,
    Model (..),
    Options (..),
    Strength (..),
    defaultOptions,
  )

newtype ThurstoneMostellerPart = ThurstoneMostellerPart {options :: Options}

instance Model ThurstoneMostellerPart where
  newRating :: ThurstoneMostellerPart -> Strength
  newRating self = Strength (mu $ options self) (sigma $ options self)
  drawProbability :: ThurstoneMostellerPart -> Match -> Double
  drawProbability _ _ = error "Not implemeneted"
  winProbabilities :: ThurstoneMostellerPart -> Match -> [Double]
  winProbabilities _ _ = error "Not implemented"
  rate :: ThurstoneMostellerPart -> Match -> Match
  rate _ _ = error "Not implemented"

thurstoneMostellerPart :: ThurstoneMostellerPart
thurstoneMostellerPart = ThurstoneMostellerPart defaultOptions
