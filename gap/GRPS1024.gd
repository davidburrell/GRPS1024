
# GRPS1024: Library of the groups of order 1024 of p-class at least 3, those of p-class two and rank 4 and those of p-class 1 and rank 10.
#
#! @Chapter Groups of Order 1024
#! @Section Overview
#!
#! This library gives explicit access to the following groups of order 1024:
#! * The rank 1 group
#! * All rank 2 groups
#! * All rank 3 groups
#! * All rank 4 groups
#! * Rank 5 groups with p-class at least 3
#! * Rank 6 groups with p-class at least 3
#! * Rank 7 groups with p-class at least 3
#! * Rank 8 groups with p-class at least 3
#! * Rank 9 groups with p-class at least 3
#! * The rank 10 group
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
#! Once the package is loaded the user may call `SmallGroup(1024,i)` and receive either a group if available or a **partially constructed group** which has the following attributes set
#! * p-class
#! * Rank
#! * Heritage
#! * Order
#! 
#!
#! @BeginExampleSession
#! gap> G:=SmallGroup(1024,1);
#! <pc group of size 1024 with 10 generators>
#! gap> Rank(G);
#! 1
#! gap> PClassPGroup(G);
#! 10
#! gap> GRPS1024_Heritage(G);
#! [ 512, 1, 1 ]
#! gap> H:=SmallGroup(1024,3568); #this is a partially constructed group
#! <pc group with 0 generators>
#! gap> PClassPGroup(H);
#! 2
#! gap> RankPGroup(H);
#! 5
#! gap> GRPS1024_Heritage(H);
#! [ 32, 51, 1 ]
#! gap> K:=SmallGroup(1024,3569); #this is a partially constructed group
#! <pc group with 0 generators>
#! gap> PClassPGroup(K);
#! 2
#! gap> RankPGroup(K);
#! 5
#! gap> GRPS1024_Heritage(K);
#! [ 32, 51, 2 ]
#! #notice that H,K have the same parent group but their age differs
#! @EndExampleSession
## @Description returns the number of immediate descendants of order 1024 of SmallGroup(Order,ID)
## @Returns an `int`
## @Arguments Order ID
### @Group CharacterDegreesOfBlocks
## @Label
## @ChapterInfo Functionality, Methods
DeclareGlobalFunction("GRPS1024_NumDescendants");

## @Description Loads the immediate descendants of <C>SmallGroup(Order,ID)</C> into global variable <C>GRPS1024_DESC.(Order)[ID]</C> if the descendants are available else it loads into global variable <C>GRPS1024_ENUM.(Order)[ID]</C> the number of immediate descendants of order 1024 of <C>SmallGroup(Order,ID)</C>
## @Arguments Order,ID
DeclareGlobalFunction("GRPS1024_LoadDescendants");

## @Description
## Returns the immediate descendants of <C>SmallGroup(Order,ID)</C> as a list. If the list is empty this implies that the immediate descendants of <C>SmallGroup(Order,ID)</C> are not available, this might be because it doesn't have any or that <C>SmallGroup(Order,ID)</C> has $p$-class 1 and the presentations are not available. To see if the group has immediate descendants use <C>NumDescendants(Order,ID)</C>.
## @Arguments Order,ID
## @Returns `list`
DeclareGlobalFunction("GRPS1024_CheckoutDescendants");

## @Description
## Checks if `SmallGroup(1024,N)` is available,
## @Arguments N
## @Returns `true` or `false`
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

# @Description
# For $1 \leq i \leq 683,875,133$ this function will return the SmallGroup ID of the $i$th available group among all the groups of order 1024.
# @Arguments N
# @Returns `int`
DeclareGlobalFunction("AvailableMap");
# @BeginExampleSession
# #groups 1-3567 are available, SmallGroup(1024,3568) is not available
# gap> g:=SmallGroup(1024,3567);
# <pc group of size 1024 with 10 generators> #this is an available group
# gap> g:=SmallGroup(1024,3568);
# <pc group with 0 generators> #this is a partially constructed group
# #the next available group has index 378632399 
# gap> AvailableMap(3568)
# 378632399
# #access the ith available group of order 1024
# gap> SmallGroup(1024,AvailableMap(i)); #for i <= 683,875,1333
# @EndExampleSession

# @Description
# For $1 \leq i \leq 49,487,367,289$ if `SmallGroup(1024,i)` is available this will return its position in the available groups list or else it will print a message telling you that it is not available and return 0.
# @Arguments N
# @Returns `int`
DeclareGlobalFunction("InverseAvailableMap");

# @BeginExampleSession
# gap> InverseAvailableMap(AvailableMap(i)) = i;
# gap> InverseAvailableMap(3568);
# This is an immediate descendant of the elementary abelian group of order 32 and is not available
# 0
# @EndExampleSession


# DeclareAttribute("ParentGroupID",IsGroup);
# DeclareAttribute("ParentGroupOrder",IsGroup);
# DeclareAttribute("KStepDescendant",IsGroup);
# DeclareAttribute("Age",IsGroup);
#
# @Description
# Returns as a list the following information for a group of order 1024 loaded from the library `[ParentGroupID, ParentGroupOrder, Age]`. The **Age** of a group is the position of the group among its siblings in the ordered list of their standard PC codes.
# @Arguments G
# @Returns `list`
DeclareAttribute("GRPS1024_Heritage",IsGroup);

DeclareGlobalFunction("ReturnCapableGroupsOfOrder");

# DeclareGlobalFunction("ImmediateDescendantGroupsShell_NEW");

DeclareGlobalFunction("GRPS1024_ImmediateDescendantGroupShell");
# DeclareGlobalFunction("CustomPrintPcPresentation");
# DeclareGlobalFunction("PrintClassificationTable");
# DeclareGlobalFunction("PrintClassificationTable1024");

DeclareGlobalFunction("ReturnCapableGroups");
# DeclareGlobalFunction("AvailableGroups1024Information");


#! @Description
#! prints information on the groups of the specified order.
#! @BeginExampleSession
#! gap> Groups1024Information();
#! ##################  Groups Information  #########################
#! There are 49487367289 groups of order 1024
#! They are sorted by rank, p-class, parent group and then age
#! 
#! Group  1				has rank 1 and pclass 10
#! Group  2				has rank 2 and pclass 3
#! Groups 3-1912				have rank 2 and pclass 4
#! Groups 1913-6569			have rank 2 and pclass 5
#! Groups 6570-8638			have rank 2 and pclass 6
#! Groups 8639-9077			have rank 2 and pclass 7
#! Groups 9078-9117			have rank 2 and pclass 8
#! Groups 9118-9122			have rank 2 and pclass 9
#! Groups 9123-319435			have rank 3 and pclass 3
#! Groups 319436-708057			have rank 3 and pclass 4
#! Groups 708058-781241			have rank 3 and pclass 5
#! Groups 781242-789631			have rank 3 and pclass 6
#! Groups 789632-789820			have rank 3 and pclass 7
#! Groups 789821-789829			have rank 3 and pclass 8
#! Groups 789830-793395			have rank 4 and pclass 2
#! Groups 793396-7180625			have rank 4 and pclass 3
#! Groups 7180626-8792073			have rank 4 and pclass 4
#! Groups 8792074-8843732			have rank 4 and pclass 5
#! Groups 8843733-8844822			have rank 4 and pclass 6
#! Groups 8844823-8844836			have rank 4 and pclass 7
#! Groups 8844837-387473667		have rank 5 and pclass 2 ## Not Available ##
#! Groups 387473668-752623856		have rank 5 and pclass 3
#! Groups 752623857-754063194		have rank 5 and pclass 4
#! Groups 754063195-754066166		have rank 5 and pclass 5
#! Groups 754066167-754066184		have rank 5 and pclass 6
#! Groups 754066185-48452082590		have rank 6 and pclass 2 ## Not Available ##
#! Groups 48452082591-48760455837	        have rank 6 and pclass 3
#! Groups 48760455838-48760467931	        have rank 6 and pclass 4
#! Groups 48760467932-48760467954	        have rank 6 and pclass 5
#! Groups 48760467955-49487311927	        have rank 7 and pclass 2 ## Not Available ##
#! Groups 49487311928-49487364283	        have rank 7 and pclass 3
#! Groups 49487364284-49487364310	        have rank 7 and pclass 4
#! Groups 49487364311-49487367243	        have rank 8 and pclass 2
#! Groups 49487367244-49487367275	        have rank 8 and pclass 3
#! Groups 49487367276-49487367288	        have rank 9 and pclass 2 ## Not Available ##
#! Group  49487367289                      has rank 10 and pclass 1
#! This library was created by David Burrell (2022).
#! @EndExampleSession
DeclareGlobalFunction("Groups1024Information");
