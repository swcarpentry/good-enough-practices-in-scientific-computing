---
---
# Good Enough Practices for Scientific Computing

## Greg Wilson

## December 2015

Two years ago we wrote a paper called
*[Best Practices for Scientific Computing](http://journals.plos.org/plosbiology/article?id=10.1371/journal.pbio.1001745)*
That might have been misguided:
many novices find the catalog intimidating,
and by definition,
the "best" are a minority,
so "best practices" are what only a minority does.

This paper therefore looks instead at "good enough" practices,
i.e.,
at the minimum every researcher should do.
(Note that English lacks a good word for this:
"mediocre" and "sufficient" aren't exactly right.)
It draws inspiration from several sources, including:

*   William Stafford Noble's
    "[A Quick Guide to Organizing Computational Biology Projects rules](http://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1000424)"
*   Titus Brown's
    "[How to grow a sustainable software development process](http://ivory.idyll.org/blog/2015-growing-sustainable-software-development-process.html)"
*   Matthew Gentzkow and Jesse Shapiro's
    "[Code and Data for the Social Sciences: A Practitioner's Guide](https://people.stanford.edu/gentzkow/sites/default/files/codeanddata.pdf)"
*   Hadley Wickham's
    "[Tidy Data](http://vita.had.co.nz/papers/tidy-data.pdf)"

1.  Use version control to manage everything created directly by a human being.

* minimum
  * Version control
  * Develop on branches
  * Checklists for merging
    * Tests passed
    * Style guidelines are met
    * Two-person rule (if you have collaborators)
  * Key concept is *[technical debt](https://en.wikipedia.org/wiki/Technical_debt)*
* What to add (in order)
  * Use a syntax-aware editor
    * Life is too short for people to indent code manually
    * Tab completion is your friend
  * Name files so that pattern-matching is reliable
    * Field-field-field.type
    * Dates as yyyy-mm-dd
    * Same directory structure for everything
    * 
  * Store numerical data as normalized CSV
    * 
    * Atomic values
    * Column headers that include units
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
