{-# LANGUAGE InstanceSigs #-}

module OpenSkill.Models.ThurstoneMostellerPart where

import OpenSkill.Types
  ( Model (..),
    Options (..),
    Rating (..),
    Team,
  )
import OpenSkill.Utils (defaultOptions)

newtype ThurstoneMostellerPart = ThurstoneMostellerPart {options :: Options}

instance Model ThurstoneMostellerPart where
  newRating :: ThurstoneMostellerPart -> Rating
  newRating self = Rating (muI $ options self) (sigmaI $ options self)

  rate :: ThurstoneMostellerPart -> [Team] -> [Team]
  rate _ _ = error "Not implemented"

thurstoneMostellerPart :: ThurstoneMostellerPart
thurstoneMostellerPart = ThurstoneMostellerPart defaultOptions
