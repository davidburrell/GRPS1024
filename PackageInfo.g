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
Subtitle := "Library of the groups of order 1024 of p-class at least 3, those of p-class two and rank 4 and those of p-class 1 and rank 10.",
Version := "0.0.3",
Date := "20/06/2022", # dd/mm/yyyy format
License := "GPL-2.0-or-later",

Persons := [
  rec(
    FirstNames := "David",
    LastName := "Burrell",
    WWWHome := "https://davidburrell.github.io/",
    Email := "davidburrell@ufl.edu",
    IsAuthor := true,
    IsMaintainer := true,
    #PostalAddress := TODO,
    #Place := TODO,
    Institution := "University of Florida",
  ),
],

#SourceRepository := rec( Type := "TODO", URL := "URL" ),
#IssueTrackerURL := "TODO",
# PackageWWWHome := "https://https://github.com/davidburrell/GRPS1024/",
# PackageInfoURL := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),
# README_URL     := Concatenation( ~.PackageWWWHome, "README" ),
# ArchiveURL     := Concatenation( ~.PackageWWWHome,
#                                  "/", ~.PackageName, "-", ~.Version ),
GithubUser := "davidburrell",
GithubRepository := ~.PackageName,
GithubWWW := Concatenation("https://github.com/", ~.GithubUser, "/", ~.GithubRepository),

PackageWWWHome := Concatenation("https://", ~.GithubUser, ".github.io/", ~.GithubRepository, "/"),
README_URL     := Concatenation( ~.PackageWWWHome, "README.md" ),
PackageInfoURL := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),
# The following assumes you are using the Github releases system. If not, adjust
# it accordingly.
ArchiveURL     := Concatenation(~.GithubWWW,
                    "/archive/refs/tags/v.", ~.Version),
#https://github.com/davidburrell/GRPS1024/archive/refs/tags/v.0.0.1.zip
ArchiveFormats := ".tar.gz .zip",

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
  LongTitle := "Utilities for accessing the groups of order 1024 with p-class at least 3",
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


