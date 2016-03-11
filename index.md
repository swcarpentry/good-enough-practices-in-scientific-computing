---
---
# Good Enough Practices for Scientific Computing

*   Jenny Bryan, Karen Cranston, Justin Kitzes, Lex Nederbragt, Tracy Teal, and Greg Wilson
*   January 2016
*   [https://github.com/swcarpentry/good-enough-practices-in-scientific-computing][repo-url]

1.  [Introduction](#introduction)
1.  [Data Management](#data-management)
1.  [Software](#software)
1.  [Collaboration](#collaboration)
1.  [Project Organization](#project-organization)
1.  [Version Control](#version-control)
1.  [Manuscripts](#manuscripts)
1.  [What's Not on This List](#whats-not-on-this-list)
1.  [Conclusion](#conclusion)
1.  [Footnotes](#footnotes)

## Introduction

Two years ago a group of researchers involved in [Software Carpentry][swc-website]
and [Data Carpentry][dc-website]
wrote a paper called "[Best Practices for Scientific Computing][best-practices]".
It was well received,
but in retrospect it might have been misguided:
many novices found its catalog of tools and techniques intimidating,
and by definition,
the "best" are a minority,
so "best practices" are what only a minority does.

This paper therefore looks instead at "good enough" practices ([1](#footnote-1)),
i.e.,
at the minimum set of practices we believe every researcher can and should adopt.
It draws inspiration from several sources, including:

*   Gentzkow and Shapiro's
    "[Code and Data for the Social Sciences: A Practitioner's Guide][gentzkow-shapiro]"
*   Noble's
    "[A Quick Guide to Organizing Computational Biology Projects][noble-rules]"
*   Brown's
    "[How to grow a sustainable software development process][brown-sustainable]"
*   Wickham's
    "[Tidy Data][wickham-tidy]"
*   Kitzes' notes on
    "[Creating a Reproducible Workflow][kitzes-reproducible]"
*   Sandve et al's
    "[Ten Simple Rules for Reproducible Computational Research][sandve-reproducible]"
*   Hart et al's
    "[Ten Simple Rules for Digital Data Storage][hart-storage]"

Our intended audience is researchers who are working alone or with a handful of collaborators
on projects lasting a few days to a few months,
and who are just starting to move beyond saving spreadsheets called `results-updated-3-revised.xlsx` in Dropbox.
A practice is included in our list if large numbers of *computationally competent* ([2](#footnote-2)) researchers use it,
and if large numbers of novices try it after a short introduction,
and are still using it months after first trying it out.
We use these criteria because there's no point recommending things that people
don't actually use,
won't try,
or abandon after a few days or weeks because they don't perceive value.

That last stipulation is important.
Many of our rules are for the benefit of the collaborator every researcher cares about most:
their future self.
(As the joke goes, your past self doesn't answer email...)
If researchers don't see those benefits quickly enough to pay for
the slowdown that inevitably occurs when adopting a new tool or practice,
they will almost certainly switch back to their old way of doing things.
As we discuss [below](#whats-not-on-this-list),
this rules out many practices such as code review
that we feel are essential for larger-scale development.

> ### You're Really Helping Yourself
>
> Many of these rules are phrased in terms of helping other people,
> such as current and future collaborators.
> In all cases,
> though,
> the most important "other person" you're helping is your future self:
> for example,
> a good to-do list will save you time when you come back to your project next year.
> It's always tempting to cut corners,
> but your past self doesn't answer email.

## Data Management

Project data may need to exist in various forms,
ranging from raw to highly processed.
We recommend three guiding principles to manage it:

### Save data in the rawest form available.

Where possible,
save the data file produced by an instrument or raw results from a survey,
with all of its mystifying imperfections.
It is tempting to overwrite raw data files with cleaned-up versions,
but faithful retention is essential to being able to re-run analyses from start to finish.
Being able to produce the raw data also enhances confidence in your final results.
More immediately,
having the raw data helps allows you to recover from analytical mishaps
and allows you to experiment without fear.

### Create the data you wish to see in the world.

Create the dataset you *wish* you had received from the raw data
and use that as the starting point for downstream analyses
(including those you didn't initially think of doing).
This is the time to maximize both machine and human readability,
but *not* to do vigorous data filtering nor to bring in external information.

Approach this initial tidying up as internal to the existing dataset and non-destructive,
both of the data and its general "shape".
Enhance machine readability by converting from proprietary or high-friction formats (e.g., Microsoft Excel or XML)
to open and simple formats (e.g., comma-separated values).
Enhance human readability by replacing inscrutable variable names and artificial data codes with self-explaining alternatives.
For example,
rename the variables `name1` and `name2` to `personal_name` and `family_name`,
recode the treatment variable from `1` vs. `2` to `untreated` vs. `treated`,
and replace artificial codes, such as "-99" for missing data, with proper `NA`s.

Both human and machine readability can be enhanced
by storing especially useful metadata as part of the filename itself,
while keeping the filename regular enough for easy pattern matching.
For example,
a filename like `2016-05-alaska-b.csv` makes it easy for both people and programs to
select by year (`2016-*.csv`),
by location (`*-alaska-*.csv`),
and so on.

### Create analysis-friendly data.

You can do this by reformatting data to eliminate processing steps
between loading the data set and doing the analysis.

1.  Columns that contain more than one variable's worth of information should be split.
    For example,
    the presence of "kg" in "3.4 kg" will cause most analytical environments to read this in as character data
    rather than numeric.
    It should be split into two columns
    (the mass "3.4" and the units "kg"),
    or the units should be recorded in the variable name and/or metadata.
2.  Multiple columns that only contain one variable's worth of information when taken together should be combined.
    This is characteristic of data that has been laid out for human eyeballs or for manual data entry.
    For example, there might be one row per field site and then columns for measurements made at each of several time points.
    It is convenient to store this in a "short and wide" form for data entry and inspection,
    but for most analyses it will be advantageous to gather these columns into a variable of measurements,
    accompanied by a companion variable indicating the time point.
3.  Reformat values as needed to match your environment's built-in parsing rules.
    For example,
    use date-time format that will be recognized automatically.

The goal of this refactoring is to create "tidy data",
which can be a powerful accelerator for analysis ([Tidy Data][wickham-tidy], [Nine simple ways][white-simple-reuse]).
This is the time to make sure your data will play nicely with your analytical environment and plans.
This pass through the data likely does not change the amount of data, but may dramatically alter its form.

> [OpenRefine][openrefine] is an excellent tool for this stage of data cleanup.
> It combines a spreadsheet-like interface to tabular data
> with a large set of cleanup heuristics,
> and can generate a trace of cleanup steps to ensure reproducibility.

### Give every record a unique key.

FIXME: fill in.

### Marshal complementary data in files that meet the same standards.

Raw data frequently does not fully explain itself.
For example,
if each well of a microtitre plate is used to study a specific gene knockout,
the prepared raw data will have a `well` variable taking on values like "A1" and "G12",
but the plate reader cannot possibly know what's in each well.
That information will be absent from the primary data file,
so you must create a supplementary file in order to look this up.
Make sure to use the same names and codes when variables in two datasets refer to the same thing
to simplify merging and lookup (and make them less error-prone).

### Create a dataset purpose-built for specific analyses and figures.

This probably involves filtering rows, selecting relevant variables, and merging with external information.
If the preceding steps have been done,
this can often be surprisingly straightforward.
The basic form of the data was hopefully set earlier,
so the main changes here are likely to be data reduction and the amalgamation of multiple datasets.

### Goals

*I didn't touch these but certainly tried to incorporate in my prose!*

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
    *   Consider restricting file permissions to read-only, even (or especially) for yourself,
        so it is harder to damage raw data by accident or to hand edit it in a moment of weakness.
    *   Don't duplicate contents of stable, long-lived repositories (i.e., don't clone GenBank)
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

The data processing strategy advocated above is divided into steps and produces intermediate data files,
with increasing levels of cleanliness and task-specificity.
While there is growing appreciation for reproducibility---i.e.,
being able to re-run an analysis start to finish---it is also extremely useful
to be able to re-run *parts* of a pipeline.
The reasons are similar to those given for modularity in computer code:
by breaking data preparation into steps,
it becomes easier to revisit later and to only tinker with specific data cleaning operations.

We propose delimited plain text as an appealing "lowest common denominator" data form
that offers high usability across time, people, operating systems, and analytical environments.
We recognize, though, that plain text is not a panacea.
In particular, when collaborating with others, be aware of and, when possible, standardize on
file encoding, line endings, and the elimination of prose-oriented features, such as "smart quotes".
Differences between collaborators in these pesky details can cause the changes between file versions to be large
and therefore substantially less comprehensible.

> [Elizabeth Wickes][wickes-comment-metadata] provides a useful classification for metadata,
> with implications for it how it should be represented.
> She notes it is easy to conflate metadata about the dataset as a whole with metadata about the content,
> e.g., individual columns.
> Most metadata schemas are aimed at the former,
> i.e., they detail the author, funder, related publications, etc.
> When considering how to store metadata, consider the intended audience.
> Is it humans?
> Write a README.
> Is it machines, such as metadata harvesters and formal repositories?
> Create an impeccably formatted metadata file.

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

You may start working on your project by yourself
or with a small group of collaborators whom you now.
But even at an early stage,
you may want to open your project so that you can attract potential new collaborators
whom you *don't* already know.
Even if you choose not to do this at the start of the project,
following a few simple rules will make it easier to do so later.

To enhance collaboration, aim for:

1.  *Simplicity:* the easier it is for people to collaborate, the more likely they are to do so (and to give you credit)
2.  *Low entry:* Remove the two most reported barriers to contributing from [Steinmacher et al][steinmacher-newcomers]:
    *   finding a task to start on
    *   setting up the local workspace to start work
3.  *Clarity:* remove uncertainty around what a potential collaborator is allowed to do

### Create an Overview

Have a short `README` file explaining the project's purpose in an easy-to-find place
(such as the project's home directory).
This file is often the first thing users of your project will look at,
so make it explicit already here that you welcome contributors and point them to the ways to help out.

The `README` file (which may be called that, or `README.txt`, or `README.html`)
should contain:

*   the project's title,
*   a brief description (similar to the abstract of a paper), and
*   contact information that actually works.

You should also create a `CONTRIBUTING` file that describes
what people need to do in order to get the project going and contribute to it:
dependencies that need to be installed,
tests that can be run to ensure the software has been installed correctly,
and guidelines or rules that your project adheres to
(e.g., checklists you may use before accepting a suggested change).

### Create a Shared To-Do List

Have a shared public to-do list.
This could be a plain text file containing the to-do list called `notes.txt` or `todo.txt` or something similar.
Alternatively,
you could use the *issue* functionality on sites such as GitHub or Bitbucket
to create a new issue for each to-do item.
(You can even add labels such as "low hanging fruit" to point newcomers at issues that are good starting points.)
Whatever your system of choice,
make the descriptions of the items clear enough so that they make sense for new collaborators.

### Make the License Explicit

Have a `LICENSE` file in the project's home directory
that clearly states what license(s) apply to the project's software, data, and manuscripts.
Lack of an explicit license does not mean there isn't one;
rather, it implies the author is keeping all rights and others are not allowed to re-use or modify the material.
We recommend:

*   Use Creative Commons licenses for data and text,
    either [CC-0][cc0], the "No Rights Reserved" license,
    or [CC-BY][ccby], the "Attribution" license,
    allowing sharing and reuse but requiring giving appropriate credit to the creator(s).
*   Use a permissive license (e.g., the [MIT, BSD, or Apache][license-descriptions] licenses) for software.

We recommend *against* the "no commercial use" variations of the Creative Commons licenses because
they may impede some forms of re-use.
For example,
if a researcher in a developing country is being paid by her government to compile a public health report,
and wishes to include some of your data,
she will be unable to do so if the license says "non-commercial".
We recommend permissive software licenses rather than the [GNU General Public License][gpl] (GPL)
because it is easier to integrate permissively-licensed software into other projects.
(Note that it is straightforward to switch from a permissive license to the GPL if you should change your mind later
but rather more complicated to go in the other direction.)

### Make the Project Citable

Include a `CITATION` file in the project's home directory that describes:

*   how to cite this project as a whole, and
*   where to find, and how to cite, any data sets, code, figures, and other artifacts that have their own DOIs.

For example,
the `CITATION` file for the Software Carpentry project reads:

~~~
To reference Software Carpentry in publications, please cite:

Greg Wilson: "Software Carpentry: Lessons Learned". F1000Research,
2016, 3:62 (doi: 10.12688/f1000research.3-62.v2).

@online{wilson-software-carpentry-2016,
  author      = {Greg Wilson},
  title       = {Software Carpentry: Lessons Learned},
  version     = {2},
  date        = {2016-01-28},
  url         = {http://f1000research.com/articles/3-62/v2},
  doi         = {10.12688/f1000research.3-62.v2}
}
~~~

For an example of a more detailed `CITATION` file,
see the one for the [khmer project][khmer-citation].

### Discussion

The first and second are to help you as well as other people---remember, your most important collaborator is yourself six months from now.
The third, fourth, and fifth items are there to make it easy for other people to help you and give you credit for your work.

## Project Organization

The previous sections have described practices for creating, naming, and storing
the files that make up a research project.
Organizing these files in a logical and consistent directory structure
will help you keep track of them
and help others review your work more easily.

Our recommendations are drawn from
Noble's "[A Quick Guide to Organizing Computational Biology Projects][noble-rules]"
with a healthy admixture from Gentzkow and Shapiro's
"[Code and Data for the Social Sciences: A Practitioner's Guide][gentzkow-shapiro]".
Each project should be in its own directory,
which should be named after the project,
and should contain the following subdirectories:

1.  `doc` contains text documents associated with the project.
    This may include files for manuscripts,
    documentation for source code,
    and/or an electronic lab notebook recording your experiments.
    Subdirectories may be created for these different classes of files.
2.  `data` contains raw data and metadata, organized into subdirectories if needed.
    Note that this directory contains only unprocessed data:
    cleaned or otherwise modified data files are treated like results.
3.  `src` contains the source code for scripts and programs,
    both that written in interpreted languages such as R or Python
    and that written compiled languages like Fortran, C++, or Java.
    Shell scripts,
    snippets of SQL used to pull information from databases,
    and everything else needed to regenerate the results
    are all managed like source code.
4.  `bin` contains executable scripts and programs that are brought in from other sources
    or compiled from code in the `src` directory.
    Projects that use only interpreted languages,
    such as R, Python, or the Unix shell,
    will not require this directory.
5.  `results` for all files that are generated as part of the project.
    This includes both intermediate results,
    such as cleaned data sets or simulated data,
    as well as final results such as figures and tables.

All files should be named clearly
to reflect their contents (e.g., `bird_count_table.csv`, `manuscript.md`)
or their functionality (e.g., `sightings_analysis.py`),
*not* using sequential numbers (e.g., `result1.csv`, `result2.csv`)
or a location in a final manuscript (e.g., `fig_3_a.png`),
since those numbers will almost certainly change as the project evolves.

> ### What's a "Project"?
>
> FIXME: explain how to decide what's in one project rather than another.

The `src` directory often contains two conceptually distinct types of files
that should be distinguished either by clear file names or by additional subdirectories.
The first type are individual files or related groups of files
that contain functions to perform the core analysis of the research.
One file,
for example,
may contain functions used for data cleaning,
while another contains functions to do certain statistical analyses.
These files can be thought of as the "scientific guts" of the project,
and as the project grows,
they can be organized into additional subdirectories.
If a project were to include formal unit tests
(see [What's Not in This List](#whats-not-on-this-list)),
these are the functions that would be tested.

The second type of file in the `src` directory is controller or driver scripts
that combine the core analytical functions
with particular parameters and data input/output commands
in order to execute the entire project analysis from start to finish.
A controller script for a simple project,
for example,
may read a raw data table,
import and apply several cleanup and analysis functions from the other files in this directory,
and create and save a numeric result.
For a small project with one main output,
a single controller script should be placed in the main `src` directory
and distinguished clearly by a name such as "runall".

The controller script is the glue that holds the analysis together
and allows a single command,
such as `python runall.py`,
to re-run the entire analysis from start to finish.
These scripts should be short (no more than 100-200 lines at most),
and be very easy to understand:
in particular,
while they may contain loops (to process multiple data files or sweep across parameter ranges)
they should contain few if any conditional statements
or new function definitions.
If a control script becomes longer or more complicated than this,
or begins to include code that would require a new collaborator more than a minute or two to understand,
those portions of the code should be moved out of the controller script
and into other core analysis files in this directory.

The `results` directory will generally require additional subdirectories for all but the simplest projects.
Intermediate files such as cleaned data,
statistical tables,
and final publication-ready figures or tables
should be separated clearly by file naming conventions or placed into different subdirectories;
those belonging to different papers or other publications
should be grouped together.

Opinion is divided on whether the `results` directory should be placed under version control.
If we borrow conventions from software development
(just as we borrowed version control itself)
the answer is no.
But there are some benefits to putting results under version control in data analysis projects.
First,
it gives collaborators immediate access to current processed data, results, figures, etc.,
without needing to regenerate it all.
Second, version control facilitates *diffing*,
i.e.,
seeing the differences between old and new states of files.
Diffs can be used to see the downstream effects of actions like upgrading a piece of software,
refactoring a script,
or starting with a slightly different dataset.

If results files are kilobytes or a few megabytes in size,
we therefore recommend keeping them under version control.
Anything more than this,
and something else should be used for management.

The figure below provides a concrete example of how a simple project might be organized following these rules.
The `data` directory contains a single CSV file with tabular data on bird counts,
and an associated `README.txt` file provides documentation for this table
(machine-readable metadata could also be included here).
The `src` directory contains `sightings_analysis.py`,
a Python file containing functions to summarize the tabular data,
and a controller script `runall.py` that loads the data table,
applies functions imported from `sightings_analysis.py`,
and saves a table of summarized results in the `results` directory.

The `bin` directory is empty,
since this project does not rely on any compiled software.
The `doc` directory contains two text files written in Markdown,
one containing a running lab notebook describing various ideas for the project and how these were implemented
and the other containing a running draft of a manuscript describing the project findings. 

~~~
.
|-- bin
|-- data
|   |-- birds_count_table.csv
|   |-- README.txt
|-- doc
|   |-- notebook.md
|   |-- manuscript.md
|-- results
|   |-- summarized_results.csv
|-- src
|   |-- sightings_analysis.py
|   |-- runall.py
~~~

## Version Control

Keeping track of changes that you or your collaborators make to data, software, and manuscripts
is a critical part of research.
Using a version control system makes it easy to see what changed when
and who made the change.

Version control aids *reproducibility*
by allowing you to reference or retrieve a specific version of the entire project.
This is invaluable for your future self (when you finally get the reviews back for your paper),
for your lab-mates and collaborators (in case you leave the project),
and for reviewers, editors, and others who want to convince themselves of the conclusions in your published research.
It also helps your future self come back to a project after a long field season
and *not* have to spend days remembering what you did last
or figuring out what your collaborators have changed while you have been gone.

Version control also aids *fixability*:
having access to every version of code, figures, and data helps you figure out
why Figure 4 looks different now than it did last week.
And finally,
all of this aids *sharing and collaboration*,
particularly by managing the process of merging independent changes made by different people,
and distributing those changes back to everyone in a controlled, traceable way.

> ### Which System?
>
> The most commonly-used version control systems today are Git, Mercurial, and Subversion,
> though there are many others.   
> They all provide the same basic functionality,
> so in the end,
> the best one to choose is whichever one your collaborators are already using.

The first rule for using version control is that
everything created by a human being goes under version control as soon as it is created.
This includes scripts and programs of all kinds,
software packages that your project depends on (with some caveats discussed below),
and documentation.
Files that may *not* be appropriate for version control include:

*   raw and/or synthesized data (also discussed below)
*   manuscripts (depending on the format---see [the discussion of Manuscripts](#manuscripts) below)
*   intermediate files that can be automatically regenerated

Second,
the repository should be mirrored on at least one machine that *isn't* the researcher's computer.
This may be a lab or departmental server,
or a public site such as GitHub or Bitbucket.
Whichever is chosen,
make sure that server is backed up regularly.

Third,
everyone working on the project should share their changes frequently,
and incorporate changes from others just as frequently.
Do not allow local versions of the project repository to drift apart,
as the effort required to merge differences goes up faster than the size of the difference.

Finally,
decide on a checklist for committing and sharing changes to the project,
document the checklist in the repository,
and *use it*.
The list might include:

*   writing commit messages that clearly explain any changes,
*   size and content of single commits,
*   style guidelines for code,
*   updating to-do lists, and
*   bans on committing half-done work or broken code.

Version control is probably the most technical section of this guide,
and the one with the steepest learning curve.
Most newcomers find version control systems confusing,
in part because some of their benefits only become apparent in large projects with many collaborators.
It can therefore be tempting to revert to using "Save As" with a version number in the file's name,
or to rely on backup systems to save the history of a project.

We nevertheless recommend learning version control and using it on all projects,
right from the start,
since its features best address the goals listed above:

*   It facilitates small changes to files that can then be found, discussed, and if necessary undone.
    This is especially useful for isolating bugs in software.
*   It can manage concurrent changes from many different collaborators
    much better than the alternatives.
*   Portals like GitHub make projects discoverable, greatly enhancing reproducibility.

### Version Control for Data?

Data should be backed up,
but may or may not be a good candidate for version control.
The size of data sets can be a problem.
If a file is small,
placing it in a version control repository facilitates reproducibility.
On the other hand,
today's version control systems are not designed to handle megabyte-sized files,
never mind gigabytes,
though support for them is emerging.

Raw data should not change (and therefore should not require version tracking).
Putting synthesized or modified data sets into version control may not be necessary
if you can re-generate these files from raw data and data-cleaning scripts
(which definitely *are* under version control!).  

Unfortunately,
some data formats are not amenable to version control,
which is designed to work with text files where the lines are in a specific order
(such as source code or plain-text documentation).
Binary files (such as HDF5) can be put in a version control system,
but you won't be able to see specific changes.
Similarly, tabular data (such as CSV files) can be put in version control,
but changing the order of the rows or columns will create a big change for the version control system,
even if the data itself has not changed.

Finally,
researchers dealing with data subject to legal restrictions that prohibit sharing (such as medical data)
should be careful not to put data in public version control systems.
Some institutions may provide access to private version control systems,
so it is worth checking with your IT department.

## Manuscripts

Gathering data,
analyzing it,
and figuring out what it means is the first 90% of any project;
writing up is the other 90%.
While this step is often skipped over,
computing has changed it just as much as it has changed the research itself.

A common, but unfortunate, practice is for
the lead author to send successive versions of a manuscript to coauthors to collect feedback,
which is received as multiple documents with changes,
as comments on the document,
in email,
or a mix of all three.
The result is a lot of files to keep track of
and much tedious manual labor to merge all the comments
to create a new master version,
at which point the process begins again.

FIXME: following paragraph will need to be changed if version control is rewritten as either/or.

Instead of an email-based workflow,
we recommend mirroring good practices for managing software and data,
to make writing scalable, collaborative, and reproducible.
In contrast to our other recommendations,
however,
we suggest that groups choose one of two different approaches for managing manuscripts.
The most important rule is
to have all authors agree on one or the other *before* writing starts.

The goals of both of the workflows outlined below are:

1.  Ensure that text is accessible to yourself and others
    now and in the future
    by making a single master document
    that is available to all coauthors at all times.
2.  Reduce the chances of work being lost or people overwriting each other's work.
3.  Make it easy to track and combine contributions from multiple collaborators.
4.  Avoid duplication and manual entry of information,
    particularly in constructing bibliographies, tables of contents, and lists.
5.  Make it easy to regenerate the final published form (e.g., a PDF)
    and to tell if it is up to date.
6.  Make it easy to share that final version with collaborators
    and to submit it to a journal.

The first approach treats papers exactly like software,
and has been used by researchers in mathematics, astronomy, physics, and related disciplines for decades:

1.  The manuscript is written in a plain text format such as
    [LaTeX][latex] or [Markdown][markdown]
    that permits version control of the files involved,
    and then converted to other formats such as PDF as needed
    using scriptable tools.
2.  Tools needed to compile manuscripts (e.g., Makefiles or LaTeX style files)
    are included in the project folder
    and kept under version control
    just like tools used to do simulation or analysis.

This approach re-uses the version control tools and skills used to manage data and software,
and is a good starting point for fully-reproducible research.
However,
as [Stephen Turner commented][turner-comment-docs] during the production of this paper:

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

We therefore also recommend an alternative approach:

1.  A manuscript is written using Google Docs or some other online tool with rich formatting,
    change tracking,
    and reference management.
2.  The project's `doc` directory includes a short text file called PUBLICATIONS
    containing metadata about each online manuscript (e.g., their URLs).
    This is analogous to the `data` directory,
    which might contain links to the location of the data file(s) rather than the actual files.

We realize that in many cases,
even this solution is asking too much from the coauthor who will continue to say,
"Just give me a Word document with tracked changes," or something similar.
To satisfy this person,
the manuscript can be converted to a desktop editor file format
(e.g., Microsoft Word's `.docx` or LibreOffice's `.odt`)
after major changes,
then downloaded and saved in the `doc` folder.

Unfortunately,
this means merging some changes and suggestions manually,
as existing tools cannot always do this automatically
when switching from a desktop file format to text and back
(although `[pandoc][pandoc]` can go a long way).

### Discussion

We recommend against traditional desktop tools like LibreOffice and Microsoft Word
because they make collaboration more difficult than either of our recommended alternatives:

*   If the document lives online (e.g., in Google Docs)
    then everyone's changes are in one place,
    and hence don't need to be merged manually.
*   If the document lives in a version control system,
    it provides good support for finding and merging differences resulting from concurrent changes.
    It also provides a convenient platform for making comments and performing review.
*   Both of our recommendations clearly define the master document
    and allow everyone to contribute to it on an equal footing.

We also believe that researchers should use a bibliography manager of some sort,
but discussion of those is outside the scope of this paper.
Finally,
regardless of the approach you choose the writing,
make sure to agree on a single method to provide feedback,
be it an email thread or mailing list,
an issue tracker (like the ones provided by GitHub and Bitbucket),
or some sort of shared online to-do list.

As an example of an implementation of these recommendations,
this paper was written using a central online repository (GitHub),
the *issue* functionality for discussing the outline and text,
and *pull requests* for reviewing the contributions from different authors,
including collecting comments and suggestions on them,
and other contributors before merging them in.

> ### Supplementary Materials
>
> Supplementary materials often contain much of the work that went into the project,
> such as tables and figures
> or more elaborate descriptions of the algorithms, software, methods, and analyses.
> In order to make these materials as accessible to others as possible,
> do not rely solely on the PDF format,
> since extracting data from PDFs is notoriously hard.
> Instead,
> we recommend separating the results that you may expect others to reuse
> (e.g., data in tables, data behind figures)
> into separate, text-format files.
> The same holds for any commands or code you want to include as supplementary material:
> use the format that most easily enables reuse (source code files, Unix shell scripts etc).

## What's Not on This List

We have deliberately left many good tools and practices off our list,
including some that we use daily.

**Branches**
:   A *branch* is a "parallel universe" within a version control repository.
    Developers create branches so that they can make multiple changes to a project independently.
    They are central to the way that experienced developers use systems like Git,
    but they add an extra layer of complexity to version control for newcomers.
    Programmers got along fine in the days of CVS and Subversion without relying heavily on branching,
    and branching can be adopted without significant disruption after people have mastered a basic edit-commit workflow.

**Build Tools**
:   Tools like [Make][make] were originally developed to recompile pieces of software that had fallen out of date.
    They are now used to regenerate data and entire papers:
    when one or more raw input files change,
    Make can automatically re-run those parts of the analysis that are affected,
    regenerate tables and plots,
    and then regenerate the human-readable PDF that depends on them.
    However,
    novices can achieve the same behavior by writing shell scripts that re-run everything;
    these may do unnecessary work,
    but given the speed of today's machines,
    that is unimportant for small projects.

**Unit Tests**
:   A *unit test* is a small test of one particular feature of a piece of software.
    Projects rely on unit tests to prevent *regression*,
    i.e.,
    to ensure that a change to one part of the software doesn't break other parts.
    While unit tests are essential to the health of large libraries and programs,
    we have found that they usually aren't compelling for solo exploratory work.
    (Note, for example, the lack of a `test` directory in [Noble's rules][noble-rules].)
    Rather than advocating something which people are unlikely to adopt,
    we have left unit testing off this list.

**Continuous Integration**
:   Tools like [Travis-CI][travis] automatically run a set of user-defined commands
    whenever changes are made to a version control repository.
    These commands typically execute tests to make sure that software hasn't regressed,
    i.e., that things which used to work still do.
    These tests can be run either before the commit takes place
    (in which case the changes can be rejected if something fails)
    or after
    (in which case the project's contributors can be notified of the breakage).
    CI systems are invaluable in large projects with many contributors,
    but pay fewer dividends in smaller projects where code is being written to do specific analyses.

**Profiling and Performance Tuning**
:   *Profiling* is the act of measuring where a program spends its time,
    and is an essential first step in *tuning* the program
    (i.e., making it run faster).
    Both are worth doing,
    but only when the program's performance is actually a bottleneck:
    in our experience,
    most users spend more time getting the program right in the first place.

**Coverage**
:   Every modern programming language comes with tools to report
    the *coverage* of a set of test cases,
    i.e.,
    the set of lines that are and aren't actually executed when those tests are run.
    Mature projects run these tools periodically to find code that isn't being used any more,
    but as with unit testing,
    this only starts to pay off once the project grows larger,
    and is therefore not recommended here.

**The Semantic Web**
:   Ontologies and other formal definitions of data are useful,
    but in our experience,
    even simplified things like [Dublin Core][dublin-core] are rarely encountered in the wild.

**Data Structures**
:   Associative data structures (e.g., Python's dictionaries),
    graphs (of the node-and-arc kind),
    Bloom filters,
    and many other data structures are essential to making programs both correct and efficient,
    but there are too many,
    and they are too specific to particular problems,
    for us to single any out for this list.

**Documentation**
:   Good documentation is a key factor in software adoption,
    but in practice,
    people won't write comprehensive documentation until they have collaborators who will use it.
    They will,
    however,
    quickly see the point of a brief explanatory comment at the start of each script,
    so we have recommended that as a first step.

**Code Reviews and Pair Programming**
:   These practices are valuable in projects with multiple contributors,
    but are hard to adopt in single-author/single-user situations,
    which includes most of the intended audience for this paper.

One important observation about this list is that
many experienced programmers actually do some or all of these things
even for small projects.
It makes sense for them to do so because
(a) they've already paid the learning cost of the tool,
so the time required to implement for the "next" project is small,
and (b) they understand that their project will need some or all of these things as it scales,
so they might as well put it in place now.

The problem comes when those experienced developers give advice to novices
who *haven't* already mastered the tools,
and *don't* realize (yet) that they will save time if and when their project grows.
In that situation,
advocating unit testing with coverage checking and continuous integration
is as likely to scare novices off than to aid them.

## Conclusion

FIXME

## Footnotes

<a name="footnote-1">(1)</a>
Note that English lacks a good word for this:
"mediocre", "adequate", and "sufficient" aren't exactly right.

<a name="footnote-2">(2)</a>
We use the term "computationally competent"
(a) to make it clear that we're trying to inculcate the equivalent good lab skills,
rather than turn researchers into professional programmers,
and (b) because the terms "computational literacy" and "computational thinking" have been used in so many ways
that it's hard to know what they mean any more.

[best-practices]: http://journals.plos.org/plosbiology/article?id=10.1371/journal.pbio.1001745
[brown-sustainable]: http://ivory.idyll.org/blog/2015-growing-sustainable-software-development-process.html
[bryan-comment-text]: https://github.com/swcarpentry/good-enough-practices-in-scientific-computing/issues/10#issue-117003028
[cc0]: https://creativecommons.org/about/cc0/
[ccby]: https://creativecommons.org/licenses/by/4.0/
[dc-website]: http://datacarpentry.org/
[dublin-core]: http://dublincore.org/
[fair-data]: http://datafairport.org/fair-principles-living-document-menu
[gentzkow-shapiro]: https://people.stanford.edu/gentzkow/sites/default/files/codeanddata.pdf
[gpl]: https://www.safaribooksonline.com/library/view/understanding-open-source/0596005814/ch03.html
[hart-storage]: https://peerj.com/preprints/1448/
[khmer-citation]: https://github.com/dib-lab/khmer/blob/master/CITATION
[kitzes-reproducible]: http://datasci.kitzes.com/lessons/python/reproducible_workflow.html
[konrad-comment-tracking]: https://github.com/swcarpentry/good-enough-practices-in-scientific-computing/issues/15#issuecomment-158361612
[latex]: http://www.latex-project.org/
[license-descriptions]: https://www.safaribooksonline.com/library/view/understanding-open-source/0596005814/ch02.html
[make]: https://www.gnu.org/software/make/
[markdown]: http://daringfireball.net/projects/markdown/
[noble-rules]: http://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1000424
[openrefine]: http://openrefine.org/
[pandoc]: http://pandoc.org/
[repo-url]: https://github.com/swcarpentry/good-enough-practices-in-scientific-computing
[sandve-reproducible]: http://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1003285
[steinmacher-newcomers]: http://lapessc.ime.usp.br/work.jsf?p1=15673
[swc-website]: http://software-carpentry.org/
[travis]: https://travis-ci.org/
[turner-comment-docs]: https://github.com/swcarpentry/good-enough-practices-in-scientific-computing/issues/2#issue-116784345
[uiuc-file-formats]: http://www.library.illinois.edu/sc/services/data_management/file_formats.html
[white-simple-reuse]: http://library.queensu.ca/ojs/index.php/IEE/article/view/4608
[wickes-comment-metadata]: https://github.com/swcarpentry/good-enough-practices-in-scientific-computing/issues/3#issuecomment-157410442
[wickham-tidy]: http://www.jstatsoft.org/article/view/v059i10
