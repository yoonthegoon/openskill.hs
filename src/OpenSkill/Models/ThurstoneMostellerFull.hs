{-# LANGUAGE InstanceSigs #-}

module OpenSkill.Models.ThurstoneMostellerFull where

import OpenSkill.Types
  ( Model (..),
    Options (..),
    Rating (..),
    Team,
  )
import OpenSkill.Utils (defaultOptions)

newtype ThurstoneMostellerFull = ThurstoneMostellerFull {options :: Options}

instance Model ThurstoneMostellerFull where
  newRating :: ThurstoneMostellerFull -> Rating
  newRating self = Rating (muI $ options self) (sigmaI $ options self)

  rate :: ThurstoneMostellerFull -> [Team] -> [Team]
  rate _ _ = error "Not implemented"

thurstoneMostellerFull :: ThurstoneMostellerFull
thurstoneMostellerFull = ThurstoneMostellerFull defaultOptions
