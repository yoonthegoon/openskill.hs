module OpenSkill.Models.ThurstoneMostellerPart where

import OpenSkill.Types
  ( Model (..),
    Options (..),
    Strength (..),
    defaultOptions,
  )

newtype ThurstoneMostellerPart = ThurstoneMostellerPart {options :: Options}

instance Model ThurstoneMostellerPart where
  newRating self = Strength (mu $ options self) (sigma $ options self)
  drawProbability _ _ = error "Not implemeneted"
  winProbabilities _ _ = error "Not implemented"
  rate _ _ = error "Not implemented"

thurstoneMostellerPart :: ThurstoneMostellerPart
thurstoneMostellerPart = ThurstoneMostellerPart defaultOptions
