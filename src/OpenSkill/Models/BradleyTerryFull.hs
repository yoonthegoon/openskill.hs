{-# LANGUAGE InstanceSigs #-}
{-# OPTIONS_GHC -Wno-type-defaults #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

module OpenSkill.Models.BradleyTerryFull
  ( bradleyTerryFull,
    BradleyTerryFull (..),
  )
where

import OpenSkill.Types
  ( Distribution (..),
    Model (..),
    Options (..),
    Rating (..),
    Team,
  )
import OpenSkill.Utils
  ( defaultOptions,
    update,
  )

bradleyTerryFull :: BradleyTerryFull
bradleyTerryFull = BradleyTerryFull defaultOptions

newtype BradleyTerryFull = BradleyTerryFull {options :: Options}

instance Model BradleyTerryFull where
  newRating :: BradleyTerryFull -> Rating
  newRating self = Rating (muI $ options self) (sigmaI $ options self)

  rate :: BradleyTerryFull -> [Team] -> [Team]
  rate self teams = zipWith (curry rateTeam) [0 ..] teams
    where
      beta' = beta $ options self
      kappa' = kappa $ options self
      gammaQ' = gammaQ $ options self

      rateTeam :: (Int, Team) -> Team
      rateTeam (i, teamI) = map ratePlayer teamI
        where
          ratingI = sumd teamI
          filteredTeams = filter (\(q, _) -> q /= i) (zip [0 ..] teams)
          (omegaI, deltaI) = foldl calc (0, 0) filteredTeams

          calc :: (Double, Double) -> (Int, Team) -> (Double, Double)
          calc (accOmega, accDelta) (q, teamQ) = (accOmega + d, accDelta + n)
            where
              ratingQ = sumd teamQ
              cIQ = sqrt (sigma ratingI ** 2 + sigma ratingQ ** 2 + 2 * beta' ** 2)
              pIQ = exp (mu ratingI / cIQ) / (exp (mu ratingI / cIQ) + exp (mu ratingQ / cIQ))
              s = if q > i then 1 else 0
              d = (sigma ratingI ** 2 / cIQ) * (s - pIQ)
              n = gammaQ' (sigma ratingI) cIQ * ((sigma ratingI / cIQ) ** 2) * pIQ * (1 - pIQ)

          ratePlayer :: Rating -> Rating
          ratePlayer ratingIJ = update ratingIJ ratingI omegaI deltaI kappa'
