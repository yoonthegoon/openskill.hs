{-# LANGUAGE InstanceSigs #-}

module OpenSkill.Models.BradleyTerryFull
  ( BradleyTerryFull (..),
    bradleyTerryFull,
  )
where

import OpenSkill.Types
  ( Distribution (sumd),
    Model (..),
    Options (beta, gammaQ, kappa),
    Rating (mu, sigma),
    Team,
  )
import OpenSkill.Utils
  ( defaultOptions,
    initialRating,
    update,
  )

bradleyTerryFull :: BradleyTerryFull
bradleyTerryFull = BradleyTerryFull defaultOptions

newtype BradleyTerryFull = BradleyTerryFull {options :: Options}

instance Model BradleyTerryFull where
  newRating :: BradleyTerryFull -> Rating
  newRating self = initialRating $ options self

  rate :: BradleyTerryFull -> [Team] -> [Int] -> [Team]
  rate self teams ranks = zipWith (curry rateTeam) [0 ..] (zip teams ranks)
    where
      beta' = beta $ options self
      kappa' = kappa $ options self
      gammaQ' = gammaQ $ options self

      rateTeam :: (Int, (Team, Int)) -> Team
      rateTeam (i, (teamI, rankI)) = map ratePlayer teamI
        where
          ratingI = sumd teamI
          filteredTeams = filter (\(q, _) -> q /= i) (zip [0 ..] (zip teams ranks))
          (omegaI, deltaI) = foldl calc (0, 0) filteredTeams

          calc :: (Double, Double) -> (Int, (Team, Int)) -> (Double, Double)
          calc (accOmega, accDelta) (_, (teamQ, rankQ)) = (accOmega + d, accDelta + n)
            where
              ratingQ = sumd teamQ
              cIQ = sqrt (sigma ratingI ** 2 + sigma ratingQ ** 2 + 2 * beta' ** 2)
              pIQ = exp (mu ratingI / cIQ) / (exp (mu ratingI / cIQ) + exp (mu ratingQ / cIQ))
              d = (sigma ratingI ** 2 / cIQ) * (s - pIQ)
                where
                  s
                    | rankQ > rankI = 1
                    | rankQ < rankI = 0
                    | otherwise = 0.5
              n = gammaQ' (sigma ratingI) cIQ * ((sigma ratingI / cIQ) ** 2) * pIQ * (1 - pIQ)

          ratePlayer :: Rating -> Rating
          ratePlayer ratingIJ = update ratingIJ ratingI omegaI deltaI kappa'
