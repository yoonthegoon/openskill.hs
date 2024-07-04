{-# OPTIONS_GHC -Wno-type-defaults #-}

module OpenSkill.Utils
  ( defaultOptions,
    initialRating,
    ordinal,
    update,
  )
where

import OpenSkill.Types
  ( Options (Options, muI, sigmaI),
    Rating (..),
  )

-- | Default options for the model
--
-- Schölkopf, B., Platt, J. C., & Hofmann, T. (2007a). Advances in neural information processing systems 19: Proceedings of the 2006 conference. MIT Press.
--
-- https://doi.org/10.7551/mitpress/7503.001.0001
--
-- Returns: @Options@ - default options
defaultOptions :: Options
defaultOptions = Options 25 (25 / 3) (25 / 6) 0.1 0.0001 (/)

-- | Initial rating for a player
--
-- @
-- rating <- initialRating options
-- @
-- Arguments:
-- * @options :: Options@ - options for the model
--
-- Returns: @Rating@ - initial rating
initialRating :: Options -> Rating
initialRating options = Rating (muI options) (sigmaI options)

-- | Strength a player is 99.7% likely to be better than
--
-- @
-- o <- ordinal rating
-- @
-- Arguments:
-- * @rating :: Rating@ - rating to convert
--
-- Returns: @Double@ - @µ - 3σ@
ordinal :: Rating -> Double
ordinal rating = mu rating - 3 * sigma rating

-- | Update a rating
--
-- @
-- ratingIJ <- update ratingIJ ratingI omegaI deltaI kappa
-- @
-- Arguments:
-- * @ratingIJ :: Rating@- rating to update
-- * @ratingI :: Rating@ - strength of team i
-- * @omegaI :: Double@ - constant to update muIJ
-- * @deltaI :: Double@ - constant to update sigmaIJ
-- * @kappa :: Double@ - positive lower bound of player variance
--
-- Returns: @Rating@ - updated rating
update :: Rating -> Rating -> Double -> Double -> Double -> Rating
update ratingIJ ratingI omegaI deltaI kappa = Rating muIJ sigmaIJ
  where
    muIJ = mu ratingIJ + sigma ratingIJ ^ 2 / sigma ratingI ^ 2 * omegaI
    sigmaIJ = sqrt $ sigma ratingIJ ^ 2 * max (1 - sigma ratingIJ ^ 2 / sigma ratingI ^ 2 * deltaI) kappa
