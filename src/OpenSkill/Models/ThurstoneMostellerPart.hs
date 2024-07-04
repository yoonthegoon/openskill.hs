{-# LANGUAGE InstanceSigs #-}

module OpenSkill.Models.ThurstoneMostellerPart
  ( thurstoneMostellerPart,
    ThurstoneMostellerPart,
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

thurstoneMostellerPart :: ThurstoneMostellerPart
thurstoneMostellerPart = ThurstoneMostellerPart defaultOptions

newtype ThurstoneMostellerPart = ThurstoneMostellerPart {options :: Options}

instance Model ThurstoneMostellerPart where
  newRating :: ThurstoneMostellerPart -> Rating
  newRating self = initialRating $ options self

  rate :: ThurstoneMostellerPart -> [Team] -> [Int] -> [Team]
  rate _ _ _ = error "Not implemented"
