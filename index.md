---
---
# Good Enough Practices for Scientific Computing

> Jenny Bryan, Karen Cranston, Justin Kitzes, Lex Nederbragt, Tracy Teal, and Greg Wilson
>
> December 2015
>
> [https://github.com/swcarpentry/good-enough-practices-in-scientific-computing][repo-url]

Two years ago we wrote a paper called
*[Best Practices for Scientific Computing][best-practices]*
That might have been misguided:
many novices find the catalog intimidating,
and by definition,
the "best" are a minority,
so "best practices" are what only a minority does.

This paper therefore looks instead at "good enough" practices,
i.e.,
at the minimum set of recommendations we address to every researcher.
(Note that English lacks a good word for this:
"mediocre" and "sufficient" aren't exactly right.)
It draws inspiration from several sources, including:

*   William Stafford Noble's
    "[A Quick Guide to Organizing Computational Biology Projects][noble-rules]"
*   Titus Brown's
    "[How to grow a sustainable software development process][brown-sustainable]"
*   Matthew Gentzkow and Jesse Shapiro's
    "[Code and Data for the Social Sciences: A Practitioner's Guide][gentzkow-shapiro]"
*   Hadley Wickham's
    "[Tidy Data][wickham-tidy]"
*   Justin Kitzes' notes on
    "[Creating a Reproducible Workflow][kitzes-reproducible]"
*   Sandve et al's
    "[Ten Simple Rules for Reproducible Computational Research][sandve-reproducible]"
*   Hart et al's
    "[Ten Simple Rules for Digital Data Storage][hart-storage]"

Our audience is researchers who are working alone or with a small number of collaborators,
and who are just starting to move beyond saving spreadsheets called `results-updated-3-revised.xlsx` in Dropbox.
A practice is included in this minimal list if:

1.  We routinely teach the skills needed to implement it in a two-day workshop
    *   No point recommending something people won't be ready to do
2.  The majority of our learners will actually adopt it after a workshop
    *   No point teaching something people aren't going to use

Many rules are for the benefit of your future self,
because your past self doesn't answer email.

## Data Management

### Goals

1.  You should never lose data.
2.  Data should be [findable, accessible, interoperable and reusable][fair-data]
    so that people (including your future self) can use it in ways you didn't anticipate,
    without pestering you with questions.
3.  Data should also be comprehensible (also called "human readable"),
    i.e.,
    potential collaborators should easily be able to understand what the data contains.
4.  Data should be *machine readable*,
    i.e.,
    programs should be able to load data correctly without extra programming effort.

### Rules

1.  Raw data should be stored exactly as it arrived (e.g., raw JPEGs for photographs)
    *   But use common sense:
        if a large volume of data is received
        in a format that is storage-inefficient or computationally inefficient to work with,
        transform it for storage with a lossless, well-documented procedure.
    *   Prefer open non-proprietary formats to closed ones (they'll likely last longer)
        *   See [this guide][uiuc-file-formats]
    *   And don't duplicate contents of stable, long-lived repositories (i.e., don't clone GenBank)
2.  All synthesized data is stored in well-defined widely-used formats:
    *   CSV for simple tabular data
    *   JSON, YAML, or XML for non-tabular data such as graphs (the node-and-arc kind)
    *   Note: prefer structured text for its longevity,
        but HDF5 and other standardized formats should be used where appropriate
3.  All data follows a few basic rules:
    *   Each value is *atomic*, i.e., has no sub-parts
        *   Example: store personal and family names in separate fields
    *   Every record has a unique *key* so that it can be selected precisely
4.  *Normalization* (the process of making data adhere to the rules in the preceding point) is treated as a processing step
    *   Raw data files are stored as they came
    *   Normalization steps are recorded textually in repeatable way
5.  Filenames and directory names are semantically meaningful
    and anticipate the need to list and filter them programmatically,
    e.g. via regular expressions or "globbing".
    *   Files as field-field-field.extension
    *   Dates as yyyy-mm-dd
6.  Metadata is stored explicitly in `data` as well
    *   Source(s) of data
    *   Meanings and units of fields
    *   Stored in machine-readable form whenever possible
        *   E.g., a CSV table of data descriptors, not paragraphs of prose
7.  Submit data to a reputable DOI-issuing repository so that others can access and cite it

### Discussion

Remember that even text---often thought of as a lowest common denominator---can be painful.
[Jenny Bryan][bryan-comment-text] writes:

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

Regarding metadata, [Elizabeth Wickes][wickes-comment-metadata] writes:

> ...two types of metadata that often get conflated in data set discussions:
> metadata about the data set as a whole
> and metadata about the content within the data set.
> Most metadata schemas...are for the former use.
> They are to describe the data set as a unit,
> e.g. author, funder, relevant papers, etc.
>
> Formally structured metadata is often a valueless effort if the data set will be stored independently
> and not somewhere in a formal repository...
> Beautifully filled out metadata files are for ingestion into a repository and/or directory.
> If the audience is humans, write it for humans.
> If the audience includes metadata harvesters,
> fill out the formal metadata and do a README for the humans.

## Software

### Goals

1.  Make it easy for people (again, including your future self) to understand and (re)use your code
    *   The easier software is to use, the more likely people are to do so
    *   Which in turn makes them more likely to collaborate with you and/or give you credit for your work
2.  Modular, comprehensible, reusable, and testable all come together
    *   Building software this way also happens to be the key to productivity

### Rules

1.  Every analysis step is represented textually (complete with parameter values)
    *   Sometimes not possible to store the verb as text (e.g., selection of region of interest in image)
    *   But should still store the result
    *   Quoting Jonah Duckles,
        "Duplicating the weather that generated a temperature log time series isn't going to happen, but we have a log of it.
        I feel the same is true of hand-digitizing an area of interest, we are concerned with the artifact, not necessarily how it came to be."
2.  Every program or script has a brief explanatory comment at the start
    *   Which includes at least one example of use
3.  Programs of all kinds (including "scripts") are broken into functions that:
    *   Are no more than one page long (60 lines, including spaces and comments)
    *   Do not use global variables (constants are OK)
    *   Take no more than half a dozen parameters
4.  No duplication
    *   Write and re-use functions instead of copying and pasting source code
    *   Use data structures, e.g. a list called `scores` instead of lots of variables called `score1`, `score2`, `score3`, etc.
5.  Functions and variables have meaningful names
    *   The larger the scope, the more informative the name
6.  Dependencies and requirements are explicit (e.g., a requirements.txt file)
7.  Commenting/uncommenting are not routinely used to control program behavior
    *   Use if/else to control behavior
    *   Use configuration files or command-line arguments for parameters
8.  Use a simple example or test data set to run to tell if it's working at all and whether it gives a known correct output for a simple known input
    *   A system/integration test that checks the entire program at once for a case similar to the real analysis
9.  Submit code to a reputable DOI-issuing repository upon submission of paper, just like data

### Discussion

FIXME

## Collaboration

### Goals

1.  Again, the easier it is for people to collaborate, the more likely they are to do so
    (and to give you credit)
2.  Two most reported barriers from [Steinmacher et al][steinmacher-newcomers]
    are finding a task to start on
    and problems setting up the local workspace to start work
    *   So remove those
3.  Additional disincentive is uncertainty: what am I allowed to do?
    *   So remove that as well
    *   Lack of an explicit license implies the author is keeping all rights
        and others are not allowed to re-use

### Rules

1.  Every project has a short README file explaining its purpose
    *   Includes a contact address that actually works
2.  And a plain text file (often called notes.txt or todo.txt) containing the to-do list
    *   Aimed at contributors, where README is aimed at users
3.  And a LICENSE file
    *   CC-0 or CC-BY for data and text
    *   Permissive license (e.g., MIT/BSD/Apache) for software
4.  And a CITATION file
    *   How to cite this project overall
    *   Where to find/how to cite data sets, code, figures, and other things that have their own DOIs

### Discussion

The first and second are to help you as well as other people---remember,
your most important collaborator is yourself six months from now.
The third, fourth, and fifth items are there to make it easy for other people to help you
and give you credit for your work.

## Project Organization

### Goals

1.  Convention over configuration
    (why add cognitive load of different layout unless there's significant demonstrable advantage?)
2.  Support the ways tools work and reduce possibility for error
    *   E.g., separating source data from processed data reduces odds of mistakenly re-processing files
3.  Project should be able to grow and be revisited without major reorganization or inconsistency

### Rules

Sub-directories in each project are organized according to Noble's rules:

1.  `doc` for documents (such as manuscripts, if you're storing them in version control)
2.  `src` for source code of programs written in compiled languages like Fortran, C++ and Java (if any)
    *   Within that, obey languages rules or strong conventions about where source files have to go
        (e.g., C++ header files, Python package structure)
3.  `bin` for executable scripts and programs
    *   Footnote: the name is old Unix shorthand for "binary", meaning "the output of the compiler"
4.  `data` for raw data and metadata (including links for fetching data)
    *   Use a sub-directory for each data set if the project uses more than one
    *   Modern file systems can handle hundreds of thousands of files in a directory,
        but displaying contents is problematic
5.  `results` for generated (intermediate) files
    *   Most programmers frown on storing generated files (because you can regenerate them)
    *   Researchers should so that they can easily tell if generated results have changed
    *   Note that figures, tables, and other things expected to go into publications count as generated results

### Discussion

FIXME

## Version Control

### Goals

*   *Reproducibility:*
    for your future self (when you get the referee's report a year from now),
    your lab-mates and collaborators (in case you leave the project),
    and (heaven forbid) the person who accuses you of making up your data.
*   *Efficiency:*
    if data and files are stored in a standard way,
    your future self can come back to a project in 6 months and not have to spend 2 days figuring out what's what.
    Ditto for someone else trying to take what you've done and go in a new direction.
*   *Fixability:*
    version control of code, figures, and data helps you figure out why Figure 4 looks different now from last week.
*   *Sharing and Collaboration:*
    version control tools make it easy to share projects and update them, sometimes simultaneously, with other collaborators

### Rules

1.  Everything created by a human being goes under version control as soon as it's created
    *   With the possible exception of manuscripts (discussed below)
    *   And the possible exception of raw data, especially if large
2.  The repository is mirrored on at least one machine that *isn't* the researcher's computer
    *   E.g., pushed to GitHub or sync'd with a departmental server
3.  The project repository contains a checklist of things that must pass before a change is shared with the world
    *   Style guidelines met, to-do list updated, smoke test(s) pass
    *   Note: "shared with the world" means "pushed to GitHub" or however else changes are copied off the researcher's computer

### Discussion

Many newcomers find version control systems confusing,
in part because some of their benefits only become apparent in large projects with many collaborators.
It can be thefore tempting to revert to using "Save As" with a version number in the file's name,
or to rely on backup systems to save the history of a project.

We nevertheless recommend using version control on all projects,
right from the start,
since its features best address the goals listed above:

*   It facilitates small changes to files that can then be found, discussed, and if necessary undone.
    This is especially useful for isolating bugs in software.
*   It can manage concurrent changes from many different collaborators
    much better than the alternatives.
*   Portals like GitHub make projects discoverable.

Raw data should be backed up,
but may or may not be a good candidate for version control.
If a file is small,
placing it in a version control repository facilitates reproducibility.
On the other hand,
today's version control systems are not designed to handle megabyte-sized files,
never mind gigabytes,
though support for them is emerging.
Very large data sets,
or those subject to legal restrictions which prohibit sharing,
should therefore not be put in a version control repository.

## Manuscripts

### Goals

1.  Make text accessible to yourself and others now and in the future
2.  Reduce chances of work being lost or people overwriting each other's work.
3.  Make it easy to track and combine contributions from multiple collaborators.
4.  Avoid duplication and manual entry of information, particularly in constructing bibliographies, tables of contents, and lists
5.  Make it easy to regenerate the final shared form (e.g., the PDF),
    and to tell if the PDF in hand is up to date.
6.  Make it easy to share the final version with collaborators and submit it to journals

### Rules

We would like to require this for papers, theses, technical reports, and other manuscripts:

1.  Manuscripts are written in a plain text format such as LaTeX or Markdown that plays nicely with version control
2.  Tools needed to compile manuscripts are managed just like tools used to do simulation or analysis

But to quote [Stephen Turner][turner-comment-docs]:

> ...try to explain the notion of compiling a document to an overworked physician you collaborate with.
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
    1.  Manuscripts are written in a plain text format such as LaTeX or Markdown that plays nicely with version control
    2.  Tools needed to compile manuscripts are managed just like tools used to do simulation or analysis
*   *Or:*
    1.  Manuscripts are written using Google Docs or some other online tools with rich formatting and change tracking
    2.  A short text file is added to the `doc` directory with metadata about each online manuscript
        *   Just as the `data` directory might contain links rather than actual data
    3.  The manuscript is downloaded and saved in `doc` in an editable form (e.g., `.docx` or `.odt`) after major changes
*   Either way, use a distributed web-based system for managing the manuscript
    so that the master document is clearly defined and everyone can collaborate on an equal footing

### Discussion

We recommend against traditional desktop tools like LibreOffice and Microsoft Word
because they make collaboration more difficult than either of our recommended alternatives:

*   If the document lives online (Google Docs),
    then everyone's changes are in one place,
    and hence don't need to be merged manually.
*   If the document lives in a version control system,
    it provides good support for finding and merging differences resulting from concurrent changes.

We also believe that researchers should use a bibliography manager of some sort,
but discussion of those is outside the scope of this paper.

[Bernhard Konrad][konrad-comment-tracking] and the lead author had this exchange:

> BK: I'm still not convinced about the necessity to track the manuscript for a single author.
>
> GW: The reviews I'm getting on this outline, and the ease of doing pre-commit review, convinces me.
>
> BK: That's because you have friends who care about and understand what you are writing.
> This intersection is often empty for, say, a grad student.
>
> GW: Maybe if we provide better tools, we can help fix that.

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
[bryan-comment-text]: https://github.com/swcarpentry/good-enough-practices-in-scientific-computing/issues/10#issue-117003028
[dublin-core]: http://dublincore.org/
[fair-data]: http://datafairport.org/fair-principles-living-document-menu
[gentzkow-shapiro]: https://people.stanford.edu/gentzkow/sites/default/files/codeanddata.pdf
[hart-storage]: https://peerj.com/preprints/1448/
[kitzes-reproducible]: http://datasci.kitzes.com/lessons/python/reproducible_workflow.html
[konrad-comment-tracking]: https://github.com/swcarpentry/good-enough-practices-in-scientific-computing/issues/15#issuecomment-158361612
[noble-rules]: http://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1000424
[repo-url]: https://github.com/swcarpentry/good-enough-practices-in-scientific-computing
[sandve-reproducible]: http://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1003285
[steinmacher-newcomers]: http://lapessc.ime.usp.br/work.jsf?p1=15673 "Steinmacher et al, The hard life of open source software project newcomers, Procs. 7th Int. Workshop on Cooperative and Human Aspects of Software Engineering. ACM, 2014."
[turner-comment-docs]: https://github.com/swcarpentry/good-enough-practices-in-scientific-computing/issues/2#issue-116784345
[uiuc-file-formats]: http://www.library.illinois.edu/sc/services/data_management/file_formats.html
[wickes-comment-metadata]: https://github.com/swcarpentry/good-enough-practices-in-scientific-computing/issues/3#issuecomment-157410442
[wickham-tidy]: http://www.jstatsoft.org/article/view/v059i10
