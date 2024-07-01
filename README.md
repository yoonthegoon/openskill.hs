# openskill.hs

![image](https://github.com/yoonthegoon/openskill.hs/assets/71526721/c26aa0e9-7d0f-4282-a329-c0cf2320a4c3)

Haskell implimentation of OpenSkill.

![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/yoonthegoon/openskill.hs/haskell.yml)
![Hackage Version](https://img.shields.io/hackage/v/openskill)
![GitHub License](https://img.shields.io/github/license/yoonthegoon/openskill.hs)

## Installation

<!-- ```bash
cabal install openskill
``` -->

```bash![Uploading tmp.svg…]()

git clone git@github.com:yoonthegoon/openskill.hs.git
cd openskill.hs
cabal install
```

## Usage

<!-- TODO: actually make it this usable -->

```haskell
import OpenSkill
  ( PlackettLuce (..), -- or any other ranking model
    Rating (..)
  )

main :: IO ()
main = do
  let pl = PlackettLuce (25, 25 / 3)
  let team1 =
    [ Rating 25 (25 / 6),
      Rating 25 (25 / 6)
    ]
  let team2 =
    [ Rating 25 (25 / 6),
      Rating 25 (25 / 6)
    ]
  let teams = [team1, team2]
  print $ rate pl teams [0, 1]
  print $ winProbability pl teams
```

```
[[Rating {theta = 26.964295, beta = 8.1779626},Rating {theta = 26.964295, beta = 8.1779626}],[Rating {theta = 23.035705, beta = 8.1779626},Rating {theta = 23.035705, beta = 8.1779626}]]
[0.5,0.5]
```

<!-- TODO: add console usage -->

## Implementations in other languages

- [JavaScript](https://github.com/philihp/openskill.js)
- [Python](https://github.com/vivekjoshy/openskill.py)
- [Kotlin](https://github.com/brezinajn/openskill.kt)
- [Elixir](https://github.com/philihp/openskill.ex)
- [Lua](https://github.com/bstummer/openskill.lua)
- [Google Sheets](https://docs.google.com/spreadsheets/d/12TA1ZG_qpBi4kDTclaOGB4sd5uJK8w-0My6puMd2-CY/view)
- [Google Apps Script](https://github.com/haya14busa/gas-openskill)
