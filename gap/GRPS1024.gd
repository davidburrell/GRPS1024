
# GRPS1024: Library of the groups of order 1024 of p-class at least 3, those of p-class two and rank 4 and those of p-class 1 and rank 10.
#
#! @Chapter Groups of Order 1024
#! @Section Overview
#!
#! This library gives explicit access to the following groups of order 1024:
#! * The Rank 1 group
#! * All Rank 2 groups
#! * All Rank 3 groups
#! * All Rank 4 groups
#! * Rank 5 groups with p-class at least 3
#! * Rank 6 groups with p-class at least 3
#! * Rank 7 groups with p-class at least 3
#! * Rank 8 groups with p-class at least 3
#! * Rank 9 groups with p-class at least 3
#! * The Rank 10 group
#!
#!
#! This library gives partial information on the remaining groups of order 1024:
#! * Rank 5 groups with p-class 2
#! * Rank 6 groups with p-class 2
#! * Rank 7 groups with p-class 2
#! * Rank 8 groups with p-class 2
#! * Rank 9 groups with p-class 2
#!
#! For the groups that are not explicitly available the following information is available:
#! * Parent Group ID
#! * Parent Group Order
#! * p-class
#! * Rank
#! * Age
#!
#!
#! The groups are sorted first by their parent group ids and then by the pc codes of the standard presentations for the groups. The data contained in this library was used in the 2021 enumeration of the groups of order 1024 <Cite Key="Burrell2021a"/>. The available groups were generated using the p-group generation algorithm  <Cite Key="OBrien1990a"/> as implemented in the ANUPQ package <Cite Key="Gamble2019a"/>. The information on the remaining groups was calculated using the cohomological methods for enumerating p-groups of p-class 2 as introduced in <Cite Key="Eick1999a"/>.
#!
#!
#!
#### this will allow any call to Capable_n to automatically read in the file and return it
DeclareAutoreadableVariables("GRPS1024","gap/CapableList16_256.g",["Capable_16","Capable_32","Capable_64","Capable_128","Capable_256"]);
DeclareAutoreadableVariables("GRPS1024","gap/CapableList_512.g",["Capable_512"]);

DeclareGlobalFunction("ReloadGRPS1024");
#! @Chapter Functionality
#!
#!
#! @Section Methods
#!
#! Once the package is loaded the user may call `SmallGroup(1024,i)` and receive either a group if available or a partially constructed group which has the following attributes set
#! * p-class
#! * Rank
#! * Heritage
#! * Order

## @Description returns the number of immediate descendants of order 1024 of SmallGroup(Order,ID)
## @Returns an `int`
## @Arguments Order ID
### @Group CharacterDegreesOfBlocks
## @Label
## @ChapterInfo Functionality, Methods
DeclareGlobalFunction("NumDescendants");

# @Description Loads the immediate descendants of <C>SmallGroup(Order,ID)</C> into global variable <C>GRPS1024_DESC.(Order)[ID]</C> if the descendants are available else it loads into global variable <C>GRPS1024_ENUM.(Order)[ID]</C> the number of immediate descendants of order 1024 of <C>SmallGroup(Order,ID)</C>
# @Arguments Order,ID
DeclareGlobalFunction("LoadDescendants");

# @Description
# Returns the immediate descendants of <C>SmallGroup(Order,ID)</C> as a list. If the list is empty this implies that the immediate descendants of <C>SmallGroup(Order,ID)</C> are not available, this might be because it doesn't have any or that <C>SmallGroup(Order,ID)</C> has $p$-class 1 and the presentations are not available. To see if the group has immediate descendants use <C>NumDescendants(Order,ID)</C>.
# @Arguments Order,ID
# @Returns `list`
DeclareGlobalFunction("CheckoutDescendants");

# @Description
# Checks if `SmallGroup(1024,N)` is available,
# @Arguments N
# @Returns `true` or `false`
DeclareGlobalFunction("IsAvailable");

## @Description
## Finds the $N$th group of order 1024 in storage and returns the group. If the group is not available then a partially constructed group is returned
## @Arguments N
## @Returns list if available
DeclareGlobalFunction("FindGroupN");

## @Description 
## Of the available groups returns the $N$th one. This should be the main function used to iterate throught the $683,875,133$ available groups.
## @Arguments N
## @Returns `FindGroupN(AvailableMap(N))`
DeclareGlobalFunction("FindNthAvailableGroup");

#! @Description
#! Since some of the groups of order 1024 are not available, this function handles the translation between the ordering of the groups of order 1024 and the available groups of order 1024. For $1 \leq i \leq 683,875,133$ this will return the position of the $i$th available group among all the groups of order 1024.
#! @Arguments N
#! @Returns `int`
DeclareGlobalFunction("AvailableMap");
#! @BeginExampleSession
#! #groups 1-3567 are available SmallGroup(1024,3568) is not available
#! gap> g:=SmallGroup(1024,3567);
#! <pc group of size 1024 with 10 generators> #this is an available group
#! gap> g:=SmallGroup(1024,3568);
#! <pc group with 0 generators> #this is a partially constructed group and not available
#! #the next available group has index 378632399 
#! gap> AvailableMap(3568)
#! 378632399
#! #To iterate through the available groups use
#! gap> SmallGroup(1024,Available(i)) #for i <= 683,875,1333
#! @EndExampleSession

#! @Description
#! This function handles the translation between the available ordering of the groups of order 1024 and the groups of order 1024. For $1 \leq i \leq 49,487,367,289$ if `SmallGroup(1024,i)` is available this will return its position in the available groups list or else it will print a message telling you that it is not available and return 0.
#! @Arguments N
#! @Returns `int`
DeclareGlobalFunction("InverseAvailableMap");

#! @BeginExampleSession
#! gap> InverseAvailableMap(AvailableMap(i)) = i;
#! gap> InverseAvailableMap(3568);
#! This is an immediate descendant of the elementary abelian group of order 32 and is not available
#! 0
#! @EndExampleSession


# DeclareAttribute("ParentGroupID",IsGroup);
# DeclareAttribute("ParentGroupOrder",IsGroup);
# DeclareAttribute("KStepDescendant",IsGroup);
# DeclareAttribute("Age",IsGroup);
#
#! @Description
#! Returns as a list the following information for a group of order 1024 loaded from the library `[ParentGroupID, ParentGroupOrder, Step, Age]`. The age of a group is the position of the group among its siblings in the ordered list of their standard PC codes.
#! @Arguments G
#! @Returns `list`
DeclareAttribute("Heritage",IsGroup);

DeclareGlobalFunction("ReturnCapableGroupsOfOrder");
DeclareGlobalFunction("ImmediateDescendantGroupShell");
DeclareGlobalFunction("CustomPrintPcPresentation");
DeclareGlobalFunction("PrintClassificationTable1024");
DeclareGlobalFunction("ReturnCapableGroups");

# DeclareGlobalFunction("PrintClassificationTable2");
