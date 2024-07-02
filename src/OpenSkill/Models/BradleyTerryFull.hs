{-# LANGUAGE InstanceSigs #-}

module OpenSkill.Models.BradleyTerryFull where

import OpenSkill.Types
  ( Match,
    Model (..),
    Options (..),
    Strength (..),
    defaultOptions,
  )

newtype BradleyTerryFull = BradleyTerryFull {options :: Options}

instance Model BradleyTerryFull where
  newRating :: BradleyTerryFull -> Strength
  newRating self = Strength (mu $ options self) (sigma $ options self)
  drawProbability :: BradleyTerryFull -> Match -> Double
  drawProbability _ _ = error "Not implemeneted"
  winProbabilities :: BradleyTerryFull -> Match -> [Double]
  winProbabilities _ _ = error "Not implemented"
  rate :: BradleyTerryFull -> Match -> Match
  rate _ _ = error "Not implemented"

bradleyTerryFull :: BradleyTerryFull
bradleyTerryFull = BradleyTerryFull defaultOptions
