---
---
# Good Enough Practices for Scientific Computing

## Greg Wilson

## December 2015

Two years ago we wrote a paper called
*[Best Practices for Scientific Computing][best-practices]*
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
    "[A Quick Guide to Organizing Computational Biology Projects rules][noble-rules]"
*   Titus Brown's
    "[How to grow a sustainable software development process][brown-sustainable]"
*   Matthew Gentzkow and Jesse Shapiro's
    "[Code and Data for the Social Sciences: A Practitioner's Guide][gentzkow-shapiro]"
*   Hadley Wickham's
    "[Tidy Data][wickham-tidy]"
*   Justin Kitzes' notes on
    "[Creating a Reproducible Workflow][kitzes-reproducible]"

A practice is included in this minimal list if:

1.  We routinely teach the skills needed to implement it in a two-day workshop
    *   No point recommending something people won't be ready to do
2.  The majority of our learners will actually adopt it after a workshop
    *   No point teaching something people aren't going to use

## Data Management

1.  All raw data is stored in the format it came in (JPEG for photographs, WAV for birdsong recordings)
2.  All syntheiszed data is stored in well-defined widely-used formats:
    *   CSV or HDF5 for tabular data
    *   JSON or YAML for referential data
3.  All data is normalized:
    *   Atomic values
    *   Keys to identify and correct records
4.  Normalization is treated as a processing step
    *   Raw data files are stored as they came
    *   Normalization steps are recorded textually in repeatable way
5.  Filenames and directory names are semantically meaningful and structured to facilitate globbing
    *   Files as field-field-field.type
    *   Dates as yyyy-mm-dd
6.  Metadata is stored explicitly in `data` as well
    *   Source(s) of data
    *   Meanings and units of fields
    *   Stored as data not as text (e.g., a CSV table of data descriptors, not paragraphs of prose)

Remember that even text---often thought of as a lowest common denominator---can be painful.
[Jenny Bryan][bryan-rebuttal] writes:

> Text is an area of consistent agony for me,
> even when collaborating with people who have bought in to plain text,
> version control, etc.
> It is exacerbated when I have a collaborator who has never even heard of line endings or encoding.
>
> Those plain text files we all love?
> If you've got people editing or even opening/closing them on different platforms,
> possibly with locale set to something other than US English,
> things can get weird.
> Line endings cycle through \n, \r\n, and \r and "smart quotes" drive you crazy.
>
> Then you get large and uninformative diffs or the dreaded �.

## Software

1.  Every analysis step is represented textually (complete with parameter values)
    *   Sometimes not possible to store the verb as text (e.g., selection of region of interest in image)
    *   But should still store the result
    *   Quoting Jonah Duckles,
        "Duplicating the weather that generated a temperature log timeseries isn't going to happen, but we have a log of it.
        I feel the same is true of hand-digitizing an AOI, we are concerned with the artifact, not necessarily how it came to be."
2.  Every program or script has a brief explanatory comment at the start
    *   Which includes at least one example of use
3.  Programs of all kinds (including "scripts") are broken into functions that:
    *   Are no more than one page long (60 lines, including spaces and comments)
    *   Do not use global variables (constants are OK)
    *   Take no more than half a dozen parameters
4.  Functions are re-used, not duplicated
5.  Functions and variables have meaningful names
    *   The larger the scope, the more informative the name
6.  Dependencies and requirements are explicit (e.g., a requirements.txt file)

## Collaboration

1.  Every project has a short README file explaining its purpose
    *   Includes a contact address that actually works
2.  And a LICENSE file
    *   CC-0 or CC-BY for data and text
    *   MIT/BSD for code
3.  And a CITATION file
4.  And a notes.txt file containing the to-do list and things people really need to know

## Project Organization

Sub-directories in each project are organized according to Noble's rules:

1.  `doc` for documents (such as papers, if you're storing them in version control)
2.  `src` for source code of programs written in compiled languages like Fortran and Java (if any)
3.  `bin` for executable scripts and programs
    *   Footnote: the name is old Unix shorthand for "binary", meaning "the output of the compiler"
4.  `data` for raw data and metadata (including links for fetching data)
5.  `results` for generated (intermediate) files
    *   Most programmers frown on storing generated files (because you can regenerate them)
    *   Researchers should so that they can easily tell if generated results have changed
    *   Note that figures, tables, and other things expected to go into publications count as generated results

## Version Control

1.  Everything created by a human being goes under version control
    *   With the possible exception of papers (discussed below)
2.  The repository is mirrored on at least one machine that *isn't* the researcher's computer
    *   E.g., pushed to GitHub or sync'd with a departmental server
3.  The project repository contains a checklist of things that must pass before a change is shared with the world
    *   Style guidelines met, to-do list updated, automated tests pass (if there are any)
    *   Note: "shared with the world" means "pushed to GitHub" or however else changes are copied off the researcher's computer

## Papers

We would like to require this:

1.  Papers are written in a plain text format such as LaTeX or Markdown that plays nicely with version control
2.  Tools needed to compile paper are managed just like tools used to do simulation or analysis

But to quote [Stephen Turner][turner-rebuttal]:

> ...try explain the notion of compiling a document to an overworked physician you collaborate with.
> Oh, but before that, you have to explain the difference between plain text and word processing.
> And text editors.
> And markdown/LaTeX compilers.
> And BiBTeX.
> And Git.
> And GitHub. Etc.
> Meanwhile he/she is getting paged from the OR...
>
> ...as much as we want to convince ourselves otherwise,
> when you have to collaborate with those outside the scientific computing bubble,
> the barrier to collaborating on papers in this framework is simply too high to overcome.
> Good intentions aside,
> it always comes down to "just give me a Word document with tracked changes," or similar.
> There's always a least common denominator who just isn't going to be on board for writing like this.

We therefore recommend:

*   *Either:*
    1.  Papers are written in a plain text format such as LaTeX or Markdown that plays nicely with version control
    2.  Tools needed to compile paper are managed just like tools used to do simulation or analysis
*   *Or:*
    1.  Papers are written using Google Docs or some other online tools with rich formatting and change tracking
    2.  A short text file is added to the `doc` directory with metadata about each online paper
        *   Just as the `data` directory might contain links rather than actual data
    3.  The paper is downloaded and saved in `doc` in an editable form (e.g., `.docx` or `.odt`) after major changes
*   Either way, use a distributed web-based system for managing the paper so that the master document is clearly defined and everyone can collaborate on an equal footing

## What's Not on This List

*   Branches:
    *   We got along fine without them in the days of CVS and Subversion
    *   And they can be added later without disrupting anything
*   Build tools: you can get there with a shell script that re-runs programs
*   Automated pre-commit checks: will emerge naturally as people become comfortable with automating repetitive tasks
*   Continuous integration: comes after use of build tools and automating pre-commit checks
*   Defensive programming and unit tests: usually aren't compelling for solo exploratory work at this stage in people's careers
    *   Note the lack of a `test` directory in [Noble's rules][noble-rules]
*   Profiling: performance tuning is an engineering task
*   Semantic Web: even simplified things like [Dublin Core][dublin-core] are rarely encountered in the wild
*   Data structures (e.g. dictionaries in Python): too many/too language-specific to single out
*   Documentation:
    *   In practice, people won't write comprehensive docs until they have collaborators who will read it
    *   But they will quickly see the point of a brief explanatory comment at the start of each script
*   Code reviews and pair programming: you're probably not sharing or collaborating at this stage
*   Issue tracking: a notes file in version control is enough to start with

[best-practices]: http://journals.plos.org/plosbiology/article?id=10.1371/journal.pbio.1001745
[brown-sustainable]: http://ivory.idyll.org/blog/2015-growing-sustainable-software-development-process.html
[bryan-rebuttal]: https://github.com/swcarpentry/good-enough-practices-in-scientific-computing/issues/10#issue-117003028
[dublin-core]: http://dublincore.org/
[gentzkow-shapiro]: https://people.stanford.edu/gentzkow/sites/default/files/codeanddata.pdf
[kitzes-reproducible]: http://datasci.kitzes.com/lessons/python/reproducible_workflow.html
[noble-rules]: http://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1000424
[turner-rebuttal]: https://github.com/swcarpentry/good-enough-practices-in-scientific-computing/issues/2#issue-116784345
[wickham-tidy]: http://vita.had.co.nz/papers/tidy-data.pdf
