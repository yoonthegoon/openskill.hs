module OpenSkill.Models.ThurstoneMostellerFull where

import OpenSkill.Types
  ( Model (..),
    Options (..),
    Strength (..),
    defaultOptions,
  )

data ThurstoneMostellerFull = ThurstoneMostellerFull {options :: Options}

instance Model ThurstoneMostellerFull where
  newRating self = Strength (mu $ options self) (sigma $ options self)
  drawProbability _ _ = error "Not implemeneted"
  winProbabilities _ _ = error "Not implemented"
  rate _ _ = error "Not implemented"

thurstoneMostellerFull :: ThurstoneMostellerFull
thurstoneMostellerFull = ThurstoneMostellerFull defaultOptions
