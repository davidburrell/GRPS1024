
# GRPS1024: Utilities for iterating through the groups of order 1024 with p-class at least 3
#
#! @Chapter Groups of Order 1024
#! @Section Overview
#!
#! This package gives access to all of the groups of order 1024 with p-class 3 and greater. The groups are sorted first by their parent group ids and then by the pc codes of the standard presentations for the groups. These groups were used in the 2021 enumeration of the groups of order 1024 <Cite Key="Burrell2021a"/>
#!
#!
#!

DeclareGlobalFunction("ReloadGRPS1024");
#! @Chapter Functionality
#!
#!
#! @Section Methods
#!
#! This section will describe the functions available in GRPS1024
#!
#! @Description
#! Computes the list of lists of degrees of ordinary characters
#! associated to the $p$-blocks of the group $G$
#! with $p$-modular character table <A>modtbl</A>
#! and underlying ordinary character table `ordtbl`.
#! @Returns a list
#! @Arguments modtbl
##! @Group CharacterDegreesOfBlocks
#! @Label chardegblocks
#! @ChapterInfo Functionality, Methods
DeclareGlobalFunction("NumDescendants");
#! @Description
#! a description
DeclareGlobalFunction("LoadDescendants");
#! @Description
#! a description
DeclareGlobalFunction("CheckoutDescendants");
#! @Description
#! a description
DeclareGlobalFunction("IsAvailable");
#! @Description
#! a description
DeclareGlobalFunction("FindGroupN");
#! @Description
#! a description
DeclareGlobalFunction("FindNthAvailableGroup");
#! @Description
#! a description
DeclareGlobalFunction("AvailableMap");
