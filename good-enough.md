---
---
# Good Enough Practices for Scientific Computing
## Greg Wilson
## December 2015

* Two years ago we wrote a paper called *Best Practices in Scientific Computing*
* That might have been misguided: many people find the whole catalog intimidating
* By definition, the "best" are a minority, so "best practices" are what only a minority does
* This paper therefore looks instead at "good enough" practices
  * English lacks a good word for this: "mediocre" isn't appropriate
* The world according to Titus Brown
  * Version control
  * Checklists
* A few more things
  * Use a syntax-aware editor that handles indentation and tab completion
  * Name files so that pattern-matching is reliable
  * Store numerical data as CSV with column headers that include units
  * Normalize that data
    * Atomic values
    * Keys for records
    * Each fact stored once
    * Use foreign keys to connect data sets
    * Note: this is unnatural extra work if you're using a spreadsheet
  * Break code into functions that:
    * Are no more than 30 lines long
    * Do not use global variables (constants are OK)
    * Take no more than half a dozen parameters
  * Learn a second data structure
    * E.g., in Python, learn how to use a dictionary
  * Write papers in plain text
    * LaTeX, Markdown - doesn't matter
    * Sad that this is necessary to play nicely with version control
  * Write and save small programs (possibly shell scripts) to do every step
    * Fetching data
    * Deriving new data
    * Generating figures
    * Formatting the paper
  * Treat parameters as data
  * Verison control: everything branches from main and is merged with it
* What's not on this list
  * Build tools like Make: useful, but you can get there with a shell script that runs programs
  * Defensive programming: not as useful for one-off exploratory work
  * Unit tests: ditto
  * Profiling: performance tuning is an engineering task
  * Documentation: you'll start doing it as your work grows
  * Code reviews: you're probably not sharing
  * Pair programming: ditto
  * Issue tracking: a notes file in version control is enough
