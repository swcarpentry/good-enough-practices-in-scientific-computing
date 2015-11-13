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

## Version Control

1.  Everything created by a human being goes under version control
2.  Sub-directories in each project are organized according to Noble's rules:
    *   `doc` for documents (such as papers)
    *   `src` for source code of compiled programs (if any)
    *   `bin` for executable scripts and programs
    *   `data` for raw data files (or metadata needed to fetch data)
    *   `results` for generated (intermediate) files
3.  New development is done on branches
    1.  All branches are created from master and merged to master
    2.  If two or more people are working on the project, all changed are reviewed by someone other than their author before merging
4.  The project repository contains a checklist of things that must pass before the merge can be done
    1.  Style guidelines met
    2.  Tests pass

## Data Management

1.  All data is stored in well-defined widely-used formats:
    *   CSV or HDF5 for tabular data
    *   JSON or YAML for referential data
2.  All data is normalized:
    *   Atomic values
    *   Explicit units
    *   Each fact stored once
    *   Keys to identify and correct records
3.  Filenames and directory names are semantically meaningful and structured to facilitate globbing
    *   Files as field-field-field.type
    *   Dates as yyyy-mm-dd

## Software

1.  Every analysis step is represented textually (complete with parameter values)
2.  Programs of all kinds (including "scripts") are broken into functions that:
    *   Are no more than one page long (60 lines, including spaces and comments)
    *   Do not use global variables (constants are OK)
    *   Take no more than half a dozen parameters
3.  Functions are re-used, not duplicated
4.  Functions and variables have meaningful names
    *   The larger the scope, the more informative the name
5.  Dependencies and requirements are explicit (e.g., a requirements.txt file)

## Papers

1.  Papers are written in a plain text format such as LaTeX or Markdown
    *   Sadly necessary to play nicely with version control
2.  Tools needed to compile paper are managed just like tools used to do simulation or analysis

## Collaboration

1.  Every project has a short README file explaining its purpose
    *   Includes a contact address that actually works
2.  And a LICENSE file
    *   CC-0 or CC-BY for data and text
    *   MIT/BSD for code
3.  And a CITATION file

## What's Not on This List

*   Build tools: you can get there with a shell script that re-runs programs
*   Defensive programming and unit tests: don't always pay off for one-off exploratory work
*   Profiling: performance tuning is an engineering task
*   Data structures (e.g. dictionaries in Python): too many/too language-specific to single out
*   Documentation: don't write until you have collaborators who will read it
*   Code reviews and pair programming: you're probably not sharing
*   Issue tracking: a notes file in version control is enough to start with
