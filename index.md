---
---
# Good Enough Practices for Scientific Computing

*   Jenny Bryan, Karen Cranston, Justin Kitzes, Lex Nederbragt, Tracy Teal, and Greg Wilson
*   January 2016
*   [https://github.com/swcarpentry/good-enough-practices-in-scientific-computing][repo-url]

## Introduction

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

Your project data may need to exist in various forms, ranging from raw to highly processed.
Here are some guiding principles to help you move data through this developmental process:

**First, do no harm.**
Save data in the rawest form available and resist the temptation to overwrite these files with cleaner versions.
This could be the data file produced by an instrument or raw results from a survey,
with all of their mystifying imperfections.
Faithful retention guarantees you can re-run your analysis, nachos to cheesecake, in the future.
Long-term, this level of reproducibility enhances everyone's confidence in your final results.
The more immediate payoff is the ability to recover gracefully from analytical mishaps and the freedom to experiment without fear.

**Be the raw data you wish to see in the world.**
From the raw data, make the dataset you *wish* you had received
and that you will enjoy having as the start point for downstream analyses,
some of which you have not even dreamed of yet.
This is the place to maximize machine and human readability,
preferably at the same time.
It is neither the place to do vigorous data filtering nor to the time to bring in external information.
Approach this initial preparation as internal to the existing dataset and non-destructive,
both of the data and its general "shape".
Enhance machine readability by converting from proprietary or high-friction formats (e.g., Microsoft Excel or XML)
to open and simple formats (e.g., comma delimited plain text).
Enhance human readability by replacing inscrutable variable names and artificial data codes with self-explaining alternatives.
For example, rename the variables `name1` and `name2` to `personal_name` and `family_name`,
recode the treatment variable from `1` vs. `2` to `untreated` vs. `treated`,
and replace artificial codes, such as "-99" for missing data, with proper `NA`s.
Both human and machine readability can be enhanced by storing especially useful metadata as part of the filename itself,
while keeping the filename regular enough for easy pattern matching.

**Create analysis-friendly data.**
Well-prepared raw data can still present many barriers to analysis and visualization.
For example, columns in the dataset may not represent the variables that are most conducive to analysis.
There are (at least!) two classes of problems:

1.  Columns that contain more than one variable's worth of information.
    For example, the inclusion of units is problematic, e.g., "3.4 kg".
    The presence of "kg" will cause most analytical environments to read this in as character data,
    whereas you'll probably want to do numeric things with it, like take averages and use in plots.
    This should be split into two variables, the mass "3.4" and the units "kg",
    or the units should be recorded in the variable name and/or metadata.
    When in doubt, try to make each variable correspond to an atomic, imminently usable piece of information.
2.  Multiple columns that only contain one variable's worth of information when taken together.
    This is characteristic of data that has been laid out for human eyeballs or for manual data entry.
    For example, there might be one row per study site and then columns for measurements made at each of several time points.
    It is convenient to store this in a "short and wide" form for data entry and inspection,
    but for most analyses it will be advantageous to gather these columns into a variable of measurements at each time point,
    accompanied by a companion variable indicating the study site, even if this means repeating the site values in that column. {# A simple figure here would be very helpful #}

The goal of all this variable splitting, combining, spreading, and gathering is to create so-called "tidy data",
which can be a powerful accelerator for analysis ([Tidy Data][wickham-tidy], [Nine simple ways][white-simple-reuse]).
This is a good place to make sure your data will play nicely with your analytical environment and plans.
For example, reformat a date-time to match one of those recognized automatically or standardize the casing on a character variable.
This pass through the data likely does not change the amount of data, but may dramatically alter its form.

*FIXME: this may still need something about observations and rows and the notion of a key?*

**Choose your friends wisely.**
Marshal complementary data in files with the same high standard for openness and simplicity as above.
Frequently the raw data does not and indeed cannot fully explain itself.
For example, if each well of a microtitre plate is used to study a specific gene knockout,
the prepared raw data will have a `well` variable taking on values like "A1" and "G12",
but the plate reader cannot possibly know what's in each well.
That information will be absent from the primary data file.
You must create a supplementary file in order to look this up.
Head off future join headaches by taking care to use the same names and codes when variables in two datasets refer to the same thing
and will be used for merging or table lookup.

**The right data for the job.**
Now is the time to create a dataset purpose-built for specific analyses and figures.
This probably involves filtering rows, selecting relevant variables, and merging with external information.
Depending on how you well executed the previous stage, this can often be surprisingly straightforward.
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
While there is growing appreciation for reproducibility---i.e., being able to re-run an analysis start to finish---it is is also extremely useful
to be able to re-run *parts* of a pipeline.
The reasons are similar to those given for modularity in computer code:
by breaking data preparation into steps,
it becomes easier to revisit later and to only tinker with specific data cleaning operations.

We propose delimited plain text as an appealing "lowest common denominator" data form
that offers high usability across time, people, operating systems, and analytical environments.
We must admit that plain text is, however, no panacea.
In particular, when collaborating with others, be aware of and, when possible, standardize on
file encoding, line endings, and the elimination of prose-oriented features, such as "smart quotes".
Differences between collaborators in these pesky details can cause the changes between file versions to be large
and therefore substantially less comprehensible.

[Elizabeth Wickes][wickes-comment-metadata] provides a useful classification for metadata,
with implications for it how it should be represented.
She notes it is easy to conflate metadata about the dataset as a whole with metadata about the content,
e.g., individual columns.
Most metadata schemas are aimed at the former,
i.e., they detail the author, funder, related publications, etc.
When considering how to store metadata, consider the intended audience.
Is it humans?
Write a README.
Is it machines, such as metadata harvesters and formal repositories?
Create an impeccably formatted metadata file.

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

You may work on your project with others, your known collaborators.
But, even at an early stage, you may be interested to open your project so that you can attract new, as yet unknown collaborators.
This section lists approaches for making it straightforward for others to start collaborating on your project.
To enhance collaboration, aim for:

1.  *Simplicity:* the easier it is for people to collaborate, the more likely they are to do so (and to give you credit)
2.  *Low entry:* Remove the two most reported barriers to contributing from [Steinmacher et al][steinmacher-newcomers]:
    *   finding a task to start on
    *   setting up the local workspace to start work
3.  *Clarity:* remove uncertainty around what a potential collaborator is allowed to do

### Rules

1.  Have a short README file explaining the project's purpose.  
    This file should includes contact information that actually works.
    This file is often the first thing users of your project will look at,
    so make it explicit already here that you welcome contributors and point them to the ways to help out.
    Consider using a CONTRIBUTION file to describe any steps needed to start working:
    dependencies that need to be installed,
    running of (unit) tests,
    and guidelines or rules that your project adheres to (e.g. on commit messages or checklists you may use before accepting a suggested change).
2.  Have a shared public to-do list.
    This could be a plain text file containing the to-do list called `notes.txt` or `todo.txt` or something similar.
    Alternatively,
    on sites such as GitHub or Bitbucket,
    you could use the *issue* functionality, and create a new issue for each to-do item
    (you can even add labels such as 'low hanging fruit' to point people to where to get started).
    Whatever your system of choice, make the descriptions of the items clear enough so that they make sense for new collaborators.
3.  Have a LICENSE file.  
    Lack of an explicit license implies the author is keeping all rights and others are not allowed to re-use or modify the material.
    We recommend:
    *   Use Creative Common licenses for data and text,
        either [CC-0](https://creativecommons.org/about/cc0/), the "No Rights Reserved" license,
        or [CC-BY](https://creativecommons.org/licenses/by/4.0/), the "Attribution" license,
        allowing sharing and reuse but requiring giving appropriate credit to the creator(s).
    *   A permissive license (e.g., [MIT/BSD/Apache](https://www.safaribooksonline.com/library/view/understanding-open-source/0596005814/ch02.html))
        for software
4.  Have a CITATION file.
    This file describes:
    *   How to cite this project overall
    *   Where to find/how to cite data sets, code, figures, and other things that have their own DOIs

FIXME add example CITATION

### Discussion

The first and second are to help you as well as other people---remember, your most important collaborator is yourself six months from now.
The third, fourth, and fifth items are there to make it easy for other people to help you and give you credit for your work.

## Project Organization

### Goals

The previous sections have described practices for creating, naming, and
storing the files that make up a research project. Organizing these files
in a logical and consistent directory structure will help you to keep track
of these files and help others to easily review your work.

1.  *Ease of Use*:
    Following simple, standard conventions for project organization makes it simple and efficient for you to find different subparts of your work,
    and makes your project easier for others to understand
2.  *Reduce error*:
    Separating types of files and avoiding duplication reduces the risk of accidentally mixing up files, such as raw and processed data
3.  *Growth*: A project should be able to expand or be revised without the entire project needing major reorganization 

### Rules

Files should be placed into a main directory named for the project
and organized into a standard set of subdirectories following [William Noble's][noble-rules] recommendations:

1.  `doc` contains text documents associated with the project.
    This may include files for manuscripts, documentation for source code, and/or an electronic lab notebook recording your experiments.
    Subdirectories may be created for these different classes of files.
2.  `data` contains raw data and metadata, organized into subdirectories if needed.
    Note that this directory contains only unprocessed data, cleaned or otherwise modified data files are considered a result.
3.  `src` contains the source code for scripts and programs,
    which may be written in interpreted languages such as R or Python or compiled languages like Fortran, C++, or Java.
4.  `bin` contains executable scripts and programs that are brought in from other sources or compiled from code in the `src` directory.
    Projects that use only modern interpreted languages, such as R or Python, will not require this directory.
5.  `results` for all files that are generated as part of the project.
    This includes both intermediate results, such as cleaned data sets or simulated data,
    as well as final results such as figures and tables.
6.  Files should be named clearly and transparently according to their contents (e.g., `bird_count_table.csv`, `manuscript.md`)
    or their functionality (e.g., `sightings_analysis.py`),
    not using sequential numbers (e.g., `result1.csv`, `result2.csv`)
    or a location in a final manuscript which is subject to change (e.g., `fig_3_a.png`)

### Discussion

The `src` directory often contains two conceptually distinct types of files
that should be distinguished either by clear file names or by additional subdirectories.
The first type are individual files, or related groups of files,
that contain functions to perform the core analysis of the research.
There may be one file, for example, that contains functions used for data cleaning,
and another file containing functions that contain statistical analysis.
As a project grows, these can be organized into additional subdirectories.
These files can be thought of as the "scientific guts" of the project.
If a project were to include formal unit tests (see _What's Not in This List_),
these would be the functions that should be tested.

A second type of file in this directory are controller or driver scripts
that combine the core analytical functions with particular parameters and data input and output commands
in order to execute the entire project analysis, from start to finish.
A controller script for a simple project, for example, may read in a raw data table,
import and apply several analysis functions from the other files in this directory,
and create and save a numeric result.
For a small project with one main output, a single controller script should be placed in the main `src` directory
and distinguished clearly from the other scientific code by a name such as "runall".

The controller script should be thought of simply as the "glue" that holds the analysis together and allows a single command,
such as `python runall.py`,
to re-run the entire analysis, from start to finish.
These scripts should be short, no more than 100-200 lines at most, and be very easy to understand.
If this script becomes longer than this,
or begins to include code that would require a new collaborator more than a minute or two to understand,
these portions of the code should be moved out of the controller script and into other core analysis files in this directory.

The `results` directory will also generally require additional structure for all but the simplest projects.
At a minimum, intermediate files such as cleaned data, statistical tables, and final publication-ready figures or tables
should be separated clearly by file naming conventions or placed into different subdirectories.

As previously noted,
in an ideal project a controller script should be able to create all of the results found in the `results` directory automatically,
using the contents of `data`, `src`, and/or `bin`, with no manual human intervention.
This helps to ensure both provenance,
so that results can always be associated with the upstream files that generated them,
and reproducibility, so that you or others can recreate the outputs of any analysis.
If this goal is achieved,
then the contents of the `results` directory do not need to be placed under version control (see below),
as they do not contain any unique information.

The figure below provides a concrete example of how a simple project might be organized following these rules.
The `data` directory contains a single CSV file with tabular data on bird counts,
and an associated `README.txt` file provides documentation for this table (a formal metadata file could also be included here).
The `src` directory contains an analytic file `sightings_analysis.py`,
a Python file containing functions that summarize the tabular data,
and a controller script `runall.py` that loads the data table,
applies functions imported from `sightings_analysis.py`,
and saves a table of summarized results in the `results` directory.

When using interpreted languages such as Python or R, the `bin` directory is often empty as in this example.
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

Keeping track of changes that you or your collaborators make to data files, software, and project organization is a critical part of research.
Using a formal version control system allows you to easily see what changed, when it changed, and who changed it.
The most common version control systems are git, Subversion and Mercurial, although there are many others.   

### Goals

*   *Reproducibility:*
    Version control allows you to easily reference or retrieve a specific version of the entire project.
    This is invaluable for your future self (when you finally get the reviews back for your paper),
    for your lab-mates and collaborators (in case you leave the project),
    and reviewers / editors / other scientists who want to convince themselves of the conclusions in your published research.
*   *Efficiency:*
    If data and files are stored in a standard way,
    your future self can come back to a project after a long field season and not have to spend days remembering what you did last, or what your collaborators have changed while you have been gone.
    This is also true for someone else who wants to take what you've done and go in a new direction.
*   *Fixability:*
    Having access to every version of code, figures, and data helps you figure out why Figure 4 looks different now from last week.
*   *Sharing and Collaboration:*
    Version control tools make it easy to share projects and update them, sometimes simultaneously, with other collaborators.

### Rules

1.  Everything created by a human being goes under version control as soon as it is created.
    This includes scripts for data management, cleaning and analyses; software packages; and documentation.
    Some types of files may not be appropriate for version control:
    *   raw and / or synthesized data (see section on data, below)
    *   manuscripts, depending on the format, but see the Manuscript section for details  
    *   intermediate files that can be regenerated
2.  The repository is mirrored on at least one machine that *isn't* the researcher's computer.
    The other machine might be a lab or departmental server, or a public site such as GitHub or Bitbucket.
3.  You share your changes frequently, and incorporate changes from others frequently.
    Don't allow your local version of the project repository to drift apart from copies on other machines.  
3.  Decide (along with any collaborators) on your own checklist for committing and sharing changes to the project
    and document this checklist in the repository.
    ("Sharing" means moving changes from your computer onto another machine / site).
    The list might include things such as:
    *   writing commit messages that clearly explain any changes,
    *   size and content of single commits,
    *   style guidelines for code,
    *   updating to-do lists, and
    *   bans on committing half-done work or broken code.

### Discussion

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

The format of your data may not be amenable to version control.
Version control is designed to work with text files where the lines are in a specific order (such as a document, or source code).
Binary files (such as HDF5) can be put in a version control system,
but you won't be able to see specific changes.
Similarly, tabular data (such as csv files) can be put in version control,
but changing the order of the rows would create a big change for the version control system,
even though the data itself has not changed.

Finally,
researchers dealing with data subject to legal restrictions that prohibit sharing (such as medical data)
should be careful not to put data in public version control systems.
Some institutions may provide access to private version control systems,
so it is worth checking with your IT department.

## Manuscripts

A common, but unfortunate, practice is that the lead author at different points in the writing process
sends around versions to coauthors for collecting feedback, and receiving multiple documents back with comments.
This leads to a lot of files to keep track of and much manual labor
to merge all the comments into the updated 'master' document.
Instead, we recommend mirroring the practices we describe for managing software and data
as they are equally beneficial for the process of manuscript preparation:
making the writing version controlled, collaborative, and reproducible.
It is important, however, to have all authors agree on a particular collaborative writing workflow
*before* starting the actual writing.
Once you agree, as lead author, don't hesitate to lay out some ground rules
that you expect the others to adhere to --- even if they are many years your senior.

### Goals

This section describes workflows for manuscript preparation that aim to satisfy the following goals:

1.  Make text accessible to yourself and others now and in the future
    by using a single point of access for the master document that is accessible to all coauthors at all times.
2.  Reduce chances of work being lost or people overwriting each other's work.
3.  Make it easy to track and combine contributions from multiple collaborators.
4.  Avoid duplication and manual entry of information, particularly in constructing bibliographies, tables of contents, and lists
5.  Make it easy to regenerate the final shared form (e.g., the PDF), and to tell if the PDF in hand is up to date.
6.  Make it easy to share the final version with collaborators and to submit it to a journal.

### Rules

In contrast to our other proposals,
we recommend that groups choose one of two different approaches for managing manuscripts.

#### Plain-Text Manuscripts Compiled to Produce Papers

This approach treats papers exactly like software.
It is technically more complicated,
but has been used by researchers in mathematics, astronomy, physics, and related disciplines for decades.

1.  The manuscript is written in a plain text format such as LaTeX or Markdown
    that enables version control for the files involved,
    and programatically converted to other formats such as PDF as needed.
2.  Tools needed to compile manuscripts (e.g., Makefiles or LaTeX style files)
    are included in the project folder
    and kept under version control
    just like tools used to do simulation or analysis.

This works,
but as [Stephen Turner commented][turner-comment-docs] during the production of this paper:

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

#### Distributed Web-Based System

We therefore also recommend an alternative:

1.  A manuscript is written using Google Docs or some other online tool with rich formatting,
    change tracking,
    and reference management.
2.  In project folder,
    add a short text file called PUBLICATIONS to the `doc` directory with metadata about each online manuscript (e.g., the URL).
    This is analogous to the `data` directory,
    which might contain links to the location of the data file(s) rather than the actual files.

We realize that in many cases, even this solution is asking too much from the coauthor who will continue to say,
"Just give me a Word document with tracked changes," or something similar.
To satisfy this person,
convert the manuscript to an editable file format (e.g., `.docx` or `.odt`) after major changes,
download it,
and save it in the `doc` folder.

Unfortunately,
this means manually merging in the changes and suggestions of this person,
as there do not seem to be tools to do this automatically
when switching from a proprietary format to text and back (although the `pandoc` program goes a long way).

### Discussion

We recommend against traditional desktop tools like LibreOffice and Microsoft Word
because they make collaboration more difficult than either of our recommended alternatives:

*   If the document lives online (e.g. Google Docs), then everyone's changes are in one place,
    and hence don't need to be merged manually.
*   If the document lives in a version control system,
    it provides good support for finding and merging differences resulting from concurrent changes.
    It also adds the possibility of using the pull-request model for suggestions, additions and pre-merge review.

Importantly,
our recommendations clearly define the master document allowing everyone to collaborate on an equal footing.
For the same reason, even if you are writing the manuscript all by yourself, we recommend using one of these strategies.
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

#### A note on supplementary materials

Supplementary materials often contain much of the work that went into the project:
tables and figures with results,
and more elaborate descriptions of the algorithms, software, methods, and analyses.
In order to make these materials as accessible to others as possible,
don't solely rely on the PDF format.
PDFs are notoriously hard to mine for data:
e.g., extracting a table from a PDF is often not an easy task.
We recommend separating the results that you may expect others to reuse
(e.g., data in tables, data behind figures) into separate, text-based formats
such as comma- or tab-separated files.
The same holds for any commands or code you want to include as supplementary material:
use the format that most easily enables reuse (source code files, Unix shell scripts etc).

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
    we have found that they usually aren't compelling for solo exploratory work in the early stages of people's careers.
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

**Issue Tracking**
:   An issue tracking system is essentially a shared to-do list for a project.
    Again,
    such systems are invaluable in large, long-lived projects,
    but to begin with,
    a text file in the project's version control repository containing
    a few bullet points describing known problems and outstanding work
    is sufficient.

## Conclusion

FIXME

[best-practices]: http://journals.plos.org/plosbiology/article?id=10.1371/journal.pbio.1001745
[brown-sustainable]: http://ivory.idyll.org/blog/2015-growing-sustainable-software-development-process.html
[bryan-comment-text]: https://github.com/swcarpentry/good-enough-practices-in-scientific-computing/issues/10#issue-117003028
[dublin-core]: http://dublincore.org/
[fair-data]: http://datafairport.org/fair-principles-living-document-menu
[gentzkow-shapiro]: https://people.stanford.edu/gentzkow/sites/default/files/codeanddata.pdf
[hart-storage]: https://peerj.com/preprints/1448/
[kitzes-reproducible]: http://datasci.kitzes.com/lessons/python/reproducible_workflow.html
[konrad-comment-tracking]: https://github.com/swcarpentry/good-enough-practices-in-scientific-computing/issues/15#issuecomment-158361612
[make]: https://www.gnu.org/software/make/
[noble-rules]: http://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1000424
[repo-url]: https://github.com/swcarpentry/good-enough-practices-in-scientific-computing
[sandve-reproducible]: http://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1003285
[steinmacher-newcomers]: http://lapessc.ime.usp.br/work.jsf?p1=15673
[travis]: https://travis-ci.org/
[turner-comment-docs]: https://github.com/swcarpentry/good-enough-practices-in-scientific-computing/issues/2#issue-116784345
[uiuc-file-formats]: http://www.library.illinois.edu/sc/services/data_management/file_formats.html
[white-simple-reuse]: http://library.queensu.ca/ojs/index.php/IEE/article/view/4608
[wickes-comment-metadata]: https://github.com/swcarpentry/good-enough-practices-in-scientific-computing/issues/3#issuecomment-157410442
[wickham-tidy]: http://www.jstatsoft.org/article/view/v059i10
