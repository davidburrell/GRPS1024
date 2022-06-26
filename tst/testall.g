#
# GRPS1024: Utilities for iterating through the groups of order 1024 with p-class at least 3
#
# This file runs package tests. It is also referenced in the package
# metadata in PackageInfo.g.
#
LoadPackage( "GRPS1024" );

TestDirectory(DirectoriesPackageLibrary( "GRPS1024", "tst" ),
  rec(exitGAP := true));

FORCE_QUIT_GAP(1); # if we ever get here, there was an error
