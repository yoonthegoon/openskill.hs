# openskill.hs

<svg id="logo_OSI" width="480" height="520" xmlns="http://www.w3.org/2000/svg">
  <mask id="sigmaMask">
    <rect width="100%" height="100%" fill="white"/>
    <text x="90" y="360" font-size="480px" font-weight="bold" font-family="Monospace"
    stroke="black" stroke-width="40px" stroke-linejoin="round" fill="black">ς </text>
  </mask>
  <path
    id="shape"
    d="M267.24612 313.264848c32.9039662-12.2200794 50.079603-35.7517944 50.079603-76.2527674s-34.1301486-76.1892162-76.7759206-76.2619426c-44.9435118-0.071706-78.9503868 35.6123514-78.4085118 76.2619426s19.9298412 67.6905456 50.9561706 77.4682044l-54.9644544 135.221706c-73.5635318-19.0453244-148.382154-105.828978-148.382154-212.68989 0-126.567618 101.6971926-229.173294 229.165338-229.173294s230.798868 102.605676 230.798868 229.173294c0 108.52239-74.109375 194.09886-149.242728 213.068412zm0 0
"
    style="fill:#5e4f87;stroke-linecap:round;stroke-linejoin:round;stroke-width:15.3697;stroke:#433762"
    mask="url(#sigmaMask)"
  />
  <text
    x="90" y="360" font-size="480px" font-weight="bold" font-family="Monospace" fill="#904d8c"
  >ς </text>
</svg>

Haskell implimentation of OpenSkill.

![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/yoonthegoon/openskill.hs/haskell.yml)
![Hackage Version](https://img.shields.io/hackage/v/openskill)
![GitHub License](https://img.shields.io/github/license/yoonthegoon/openskill.hs)

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
