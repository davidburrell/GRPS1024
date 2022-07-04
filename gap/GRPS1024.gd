
# GRPS1024: Utilities for iterating through the groups of order 1024 with p-class at least 3
#
#! @Chapter Groups of Order 1024
#! @Section Overview
#!
#! This package gives access to all of the groups of order 1024 with p-class 3 and greater. The groups are sorted first by their parent group ids and then by the pc codes of the standard presentations for the groups. These groups were used in the 2021 enumeration of the groups of order 1024 <Cite Key="Burrell2021a"/> and represent a complete list of the isomorphism classes of the groups of order 1024 with p-class 3 and greater.
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
#! This section will describe the functions available in GRPS1024
#!
#! @Description returns the number of immediate descendants of order 1024 of SmallGroup(Order,ID)
#! @Returns an `int`
#! @Arguments Order ID
##! @Group CharacterDegreesOfBlocks
#! @Label
#! @ChapterInfo Functionality, Methods
DeclareGlobalFunction("NumDescendants");

#! @Description Loads the immediate descendants of <C>SmallGroup(Order,ID)</C> into global variable <C>GRPS1024_DESC.(Order)[ID]</C> if the descendants are available else it loads into global variable <C>GRPS1024_ENUM.(Order)[ID]</C> the number of immediate descendants of order 1024 of <C>SmallGroup(Order,ID)</C>
#! @Arguments Order,ID
DeclareGlobalFunction("LoadDescendants");
#! @Description
#! Returns the immediate descendants of <C>SmallGroup(Order,ID)</C> as a list. If the list is empty this implies that the immediate descendants of <C>SmallGroup(Order,ID)</C> are not available, this might be because it doesn't have any or that <C>SmallGroup(Order,ID)</C> has $p$-class 1 and the presentations are not available. To see if the group has immediate descendants use <C>NumDescendants(Order,ID)</C>.
#! @Arguments Order,ID
#! @Returns 'list'
DeclareGlobalFunction("CheckoutDescendants");

#! @Description
#! Checks if the Nth group of order 1024 is available, there are 49487367289 groups of order 1024 and those which have $p$-class three and greater are available through this package.
#! @Arguments N
#! @Returns `true` or `false`
DeclareGlobalFunction("IsAvailable");

#! @Description
#! Finds the $N$th group of order 1024 in storage and returns the group. If the group is not available then an informative message about the groups heritage is printed.
#! @Arguments N
#! @Returns list if available
DeclareGlobalFunction("FindGroupN");
#! @Description 
#! Of the available groups returns the $N$th one. This should be the main function used to iterate throught the $683,875,133$ available groups.
#! @Arguments N
#! @Returns 'FindGroupN(AvailableMap(N))'
DeclareGlobalFunction("FindNthAvailableGroup");
#! @Description
#! This takes handles the translation between the ordering of the groups of order 1024 and the available groups of order 1024. For $1 \leq i \leq 683,875,133$ this will return the position of the $i$th available group among all the groups of order 1024.
#! @Arguments N
#! @Returns 'int'
DeclareGlobalFunction("AvailableMap");

DeclareGlobalFunction("ReturnCapableGroupsOfOrder");

## @BeginExample
#S5 := SymmetricGroup(5);
## Sym( [ 1 .. 5 ] )
#Order(S5);
## 120
## @EndExample

DeclareAttribute("ParentGroupID",IsGroup);
DeclareAttribute("ParentGroupOrder",IsGroup);
DeclareAttribute("KStepDescendant",IsGroup);
DeclareAttribute("Age",IsGroup);

