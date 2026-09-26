# Childhood exposure to substance use and mental illness (CDC BRFSS 2021)

My first SQL project. I cleaned and queried the CDC's 2021 Behavioral Risk Factor Surveillance System (BRFSS) to look at adverse childhood experiences, depression and drinking, in preparation for a Model WHO simulation on reframing the global response to substance use.

## Data
- Source: [CDC BRFSS 2021](https://www.cdc.gov/brfss/annual_data/annual_2021.html)
- 438,693 survey responses across 303 columns
- The data file is not included here because of its size. Download it from the CDC link above.

## What I did
- Recoded "none" codes to 0 (88 for mental health days, 888 for drinking days)
- Converted alcohol frequency from a mixed weekly/monthly format into days per month
- Kept "don't know" and "refused" answers in the data but excluded them at analysis time, rather than deleting them
- Separated genuinely missing answers from questions respondents never saw, since the adverse childhood experiences (ACE) module was optional by state
- Cross-checked results against the CDC's published codebook figures

## Findings
Among respondents asked about adverse childhood experiences (n = 56,655):
- 23.5% recalled alcohol use disorder in the home
- 17.9% recalled mental illness or depression in the home
- 9.3% recalled illegal drug use in the home

Adults with a diagnosed depressive disorder averaged 4.5 drinking days per month, compared with 5.0 for those without one. These averages include non-drinkers (coded as 0 days).

## Limitations
- Figures are unweighted sample proportions, not population estimates. A next step is to apply the BRFSS survey weights.
- The drinking-days difference has not been tested for statistical significance.
- The ACE module was optional across states, so results represent participating respondents only.
- 2021 data reflects the COVID-19 period, when mental health indicators were likely elevated.
- The survey does not distinguish between types of substance use.

## Tools
SQL · DB Browser for SQLite · Python (to add column headers before import)

## Files
- `brfss_2021_ace_analysis.sql`: all cleaning and analysis queries, with comments
- Infographic and query screenshot
