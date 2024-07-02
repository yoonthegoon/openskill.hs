# openskill.hs

![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/yoonthegoon/openskill.hs/haskell.yml)
![Hackage Version](https://img.shields.io/hackage/v/openskill)
![GitHub License](https://img.shields.io/github/license/yoonthegoon/openskill.hs)

Haskell implementation of OpenSkill

## Installation

<!-- ```bash
cabal install openskill
``` -->

```bash
git clone git@github.com:yoonthegoon/openskill.hs.git
cd openskill.hs
cabal install
```

## Usage

<!-- TODO: actually make it this usable -->

```haskell
ghci> import OpenSkill
ghci> rating = newRating plackettLuce
ghci> rating
Rating {theta = 25.0, beta = 8.3333333}
ghci> team1 = [rating, rating]
ghci> team2 = team1
ghci> teams = [team1, team2]
ghci> winProbabilities plackettLuce teams
[0.5,0.5]
ghci> rate plackettLuce teams
[[Rating {theta = 26.964295, beta = 8.1779626},Rating {theta = 26.964295, beta = 8.1779626}],[Rating {theta = 23.035705, beta = 8.1779626},Rating {theta = 23.035705, beta = 8.1779626}]]
```

## Implementations in other languages

- [JavaScript](https://github.com/philihp/openskill.js)
- [Python](https://github.com/vivekjoshy/openskill.py)
- [Kotlin](https://github.com/brezinajn/openskill.kt)
- [Elixir](https://github.com/philihp/openskill.ex)
- [Lua](https://github.com/bstummer/openskill.lua)
- [Google Sheets](https://docs.google.com/spreadsheets/d/12TA1ZG_qpBi4kDTclaOGB4sd5uJK8w-0My6puMd2-CY/view)
- [Google Apps Script](https://github.com/haya14busa/gas-openskill)
