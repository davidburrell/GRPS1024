#
# GRPS1024: Utilities for iterating through the groups of order 1024 with p-class at least 3
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#
SetPackageInfo( rec(

PackageName := "GRPS1024",
Subtitle := "Library of the groups of order 1024.",
Version := "0.0.6",
Date := "31/07/2026", # dd/mm/yyyy format
License := "Artistic-2.0",

Persons := [
  rec(
    FirstNames := "David",
    LastName := "Burrell",
    WWWHome := "https://davidburrell.github.io/",
    GitHubUsername := "davidburrell",
    Email := "davidburrell@me.com",
    IsAuthor := true,
    IsMaintainer := true,
    #PostalAddress := TODO,
    #Place := TODO,
    Institution := "University of Florida",
  ),
],

GithubUser := "davidburrell",
GithubRepository := ~.PackageName,

SourceRepository := rec(
    Type := "git",
    URL := Concatenation("https://github.com/", ~.GithubUser, "/", ~.GithubRepository),
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome := Concatenation("https://", ~.GithubUser, ".github.io/", ~.GithubRepository, "/"),
README_URL     := Concatenation( ~.PackageWWWHome, "README.md" ),
PackageInfoURL := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),
ArchiveURL     := Concatenation( ~.SourceRepository.URL,
                                 "/releases/download/v", ~.Version,
                                 "/", ~.PackageName, "-", ~.Version ),
ArchiveFormats := ".tar.gz",

##  Status information. Currently the following cases are recognized:
##    "accepted"      for successfully refereed packages
##    "submitted"     for packages submitted for the refereeing
##    "deposited"     for packages for which the GAP developers agreed
##                    to distribute them with the core GAP system
##    "dev"           for development versions of packages
##    "other"         for all other packages
##
Status := "dev",

AbstractHTML   :=  "",

PackageDoc := rec(
  BookName  := "GRPS1024",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Utilities for accessing the groups of order 1024",
),

Dependencies := rec(
  GAP := ">= 4.11",
  NeededOtherPackages := [ ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := [ ],
),

AvailabilityTest := ReturnTrue,

TestFile := "tst/testall.g",

#Keywords := [ "TODO" ],

));


