#
# GRPS1024: Utilities for iterating through the groups of order 1024 with p-class at least 3
#
# Implementations
#

InstallGlobalFunction("ReloadGRPS1024",function()
 Print(RereadPackage("GRPS1024/gap/GRPS1024.gd"),"\n");
 Print(RereadPackage("GRPS1024/gap/GRPS1024.gi"),"\n");
 Print(RereadPackage("GRPS1024/gap/GRPS1024.g"),"\n");
end);

BindGlobal("GRPS1024_AVAIL",683875133);

BindGlobal("GRPS1024_DESC",rec(2:=[],4:=[],8:=[],16:=[],32:=[],64:=[],128:=[],256:=[],512:=[]));
BindGlobal("GRPS1024_ENUM",rec(2:=[],4:=[],8:=[],16:=[],32:=[],64:=[],128:=[],256:=[],512:=[]));

InstallGlobalFunction("LoadDescendants",function(parentGroup_Order,parentGroup_ID)
local toRead;
toRead := StringFormatted("lib/Desc_{}/{}.g",parentGroup_Order,parentGroup_ID);
if not ReadPackage("GRPS1024",toRead) then
	Info(InfoDebug,1,StringFormatted("The presentations of the immediate descendants of {}#{} are not available",parentGroup_Order,parentGroup_ID));
	toRead := StringFormatted("lib/Enum_{}/{}.g",parentGroup_Order,parentGroup_ID);

	if not ReadPackage("GRPS1024",toRead) then
	Info(InfoDebug,1,StringFormatted("{}#{} doesn't have immediate descendants of order 1024",parentGroup_Order,parentGroup_ID));
	# Info(InfoDebug,1,StringFormatted("The enumeration of the immediate descendants of {}#{} are not available",parentGroup_Order,parentGroup_ID));
	#we assume that to get here neither the determination are available nor the enumeration, so it must be the case that this group has no immediate descendants
	GRPS1024_ENUM.(parentGroup_Order)[parentGroup_ID]:= 0;
	else
	GRPS1024_ENUM.(parentGroup_Order)[parentGroup_ID]:= ValueGlobal(StringFormatted("enum_{}_{}",parentGroup_Order,parentGroup_ID));
	fi;	
else
	#Print(StringFormatted("Loaded Descendants of SmallGroup({},{})\n",parentGroup_Order,parentGroup_ID));
	#desc_{}_{} refers to the variable name in the actual library file that was loaded
	GRPS1024_DESC.(parentGroup_Order)[parentGroup_ID]:= ValueGlobal(StringFormatted("desc_{}_{}",parentGroup_Order,parentGroup_ID));
fi;
end);

InstallGlobalFunction("CheckoutDescendants",function(parentGroup_Order,parentGroup_ID)
local toRead,toReturn;

toRead:=StringFormatted("lib/Desc_{}/{}.g",parentGroup_Order,parentGroup_ID);
if ReadPackage("GRPS1024",toRead) then
	toReturn:= ValueGlobal(StringFormatted("desc_{}_{}",parentGroup_Order,parentGroup_ID));
	return toReturn{[2..Length(toReturn)]};
else
	Info(InfoDebug,1,StringFormatted("The presentations of the immediate descendants of {}#{} are not available",parentGroup_Order,parentGroup_ID));
	return [];
fi;
end);


InstallGlobalFunction("FindNthAvailableGroup",function(n)
return SmallGroup(1024,AvailableMap(n)); 
# return FindGroupN(AvailableMap(n));
end);

InstallGlobalFunction("IsAvailable",function(n)

local capableMaster,toRead,j,group_order,group,i,offset,order,step,desc,toSkip;
#we handle generate the elementary abelian group
if n = 49487367289 then return true; fi;
if n < 49487367289 then


	capableMaster:=[];
	toRead:=StringFormatted("gap/CapableList16_256.g");
	if ReadPackage("GRPS1024",toRead) then
		for j in [16,32,64,128,256] do
			Add(capableMaster,ValueGlobal(StringFormatted("Capable_{}",j)));
	od;
	fi;
	#return capableMaster;
	i:=0;
	offset:=0;
	order:=8;
	step:=0;
	#toSkip:=[[32,51],[64,267],[128
	for group_order in capableMaster do
		order:=order*2;
		step:=Length(FactorsInt(1024)) - Length(FactorsInt(order));
		for group in group_order do
			offset:=i;
			i:=i+group[2];
			if i >= n then
				#
				#n-offset is the position in the ordered list of descendants
				#we are looking for i.e. the age of the nth group among its
				#siblings
				#desc:=PqDescendants(SmallGroup(order,group[1]):StepSize:=step);
				if order > 16 and NumberSmallGroups(order)=group[1] then
					Info(InfoDebug,2,StringFormatted("Descendant {} of the Elementary Abelian group of order {}",n-offset,order));
					return false;
				fi;
				# desc:=CheckoutDescendants(order,group[1]);
				#desc:=List(desc,CodePcGroup);
				# Sort(desc);
				# these lists were sorted after generation and before preparation of this package
				# return [order,group[1],step,n-offset,desc[n-offset]];
				return true;
			else
				continue;
			fi;
		od;
	od;
	## if we are here then the group is an immediate descendant of a group of order 512
	order:=512;
	step:=1;
	toRead:=StringFormatted("gap/CapableList_512.g");
	if ReadPackage("PGroupUTILS",toRead) then
		#Add(capableMaster,ValueGlobal(StringFormatted("Capable_{}",j)));
		capableMaster:=ValueGlobal(StringFormatted("Capable_{}",512));
	fi;

		for group in capableMaster do
			offset:=i;
			i:=i+group[2];
			if i >= n then
				#n-offset is the position in the ordered list of descendants
				#we are looking for i.e. the age of the nth group among its
				#siblings
				#desc:=PqDescendants(SmallGroup(order,group[1]):StepSize:=step);
				if order > 16 and NumberSmallGroups(order)=group[1] then
					# Print(StringFormatted("Descendant {} of the Elementary Abelian group of order {}",n-offset,order));
					return false;
				fi;
				# desc:=CheckoutDescendants(order,group[1]);
				#desc:=List(desc,CodePcGroup);
				# Sort(desc);
				# return [order,group[1],step,n-offset,desc[n-offset]];
				return true;
			else
				continue;
			fi;
		od;
else
	Error("There are only 49487367289 groups of order 1024");
fi;

end);
#InstallGlobalFunction("FindGroupN",function(n)

#local capableMaster,toRead,j,group_order,group,i,offset,order,step,desc,toSkip,toReturn;

#if n < 49487367289 then
#	capableMaster:=[];
#	toRead:=StringFormatted("gap/CapableList16_256.g");
#	if ReadPackage("GRPS1024",toRead) then
#		for j in [16,32,64,128,256] do
#			Add(capableMaster,ValueGlobal(StringFormatted("Capable_{}",j)));
#	od;
#	fi;
#	#return capableMaster;
#	i:=0;
#	offset:=0;
#	order:=8;
#	step:=0;
#	#toSkip:=[[32,51],[64,267],[128
#	for group_order in capableMaster do
#		order:=order*2;
#		step:=Length(FactorsInt(1024)) - Length(FactorsInt(order));
#		for group in group_order do
#			offset:=i;
#			i:=i+group[2];
#			if i >= n then
#				#
#				#n-offset is the position in the ordered list of descendants
#				#we are looking for i.e. the age of the nth group among its
#				#siblings
#				#desc:=PqDescendants(SmallGroup(order,group[1]):StepSize:=step);
#				if order > 16 and NumberSmallGroups(order)=group[1] then
#					Print(StringFormatted("Descendant {} of the Elementary Abelian group of order {}",n-offset,order));
#					return;
#				fi;
#				desc:=CheckoutDescendants(order,group[1]);
#				#desc:=List(desc,CodePcGroup);
#				# Sort(desc);
#				# these lists were sorted after generation and before preparation of this package
#				toReturn:=PcGroupCode(desc[n-offset],1024);
#				# SetParentGroupID(toReturn,group[1]);
#				# SetParentGroupOrder(toReturn,order);
#				# SetAge(toReturn,n-offset);
#				# SetKStepDescendant(toReturn,step);
#				return toReturn;
#				# return [order,group[1],step,n-offset,desc[n-offset]];
#			else
#				continue;
#			fi;
#		od;
#	od;
#	## if we are here then the group is an immediate descendant of a group of order 512
#	order:=512;
#	step:=1;
#	toRead:=StringFormatted("gap/CapableList_512.g");
#	if ReadPackage("PGroupUTILS",toRead) then
#		#Add(capableMaster,ValueGlobal(StringFormatted("Capable_{}",j)));
#		capableMaster:=ValueGlobal(StringFormatted("Capable_{}",512));
#	fi;

#		for group in capableMaster do
#			offset:=i;
#			i:=i+group[2];
#			if i >= n then
#				#n-offset is the position in the ordered list of descendants
#				#we are looking for i.e. the age of the nth group among its
#				#siblings
#				heritage.ID:=group[1];
#				heritage.Order:=order;
#				heritage.Age:=n-offset;
#				#desc:=PqDescendants(SmallGroup(order,group[1]):StepSize:=step);
#				if NumberSmallGroups(order)=group[1] then
#					Print(StringFormatted("Descendant {} of the Elementary Abelian group of order {}",n-offset,order));
#					return;
#				fi;
#				desc:=CheckoutDescendants(order,group[1]);
#				#desc:=List(desc,CodePcGroup);
#				#Sort(desc);
#				toReturn:=PcGroupCode(desc[n-offset],1024);
#				# SetParentGroupID(toReturn,group[1]);
#				# SetParentGroupOrder(toReturn,order);
#				# SetAge(toReturn,n-offset);
#				# SetKStepDescendant(toReturn,step);
#				return toReturn;
#				# return [order,group[1],step,n-offset,desc[n-offset]];
#			else
#				continue;
#			fi;
#		od;
#elif n = 49487367289 then
#	toReturn:=ElementaryAbelianGroup(1024);
#	# SetParentGroupID(toReturn,1);
#	# SetParentGroupOrder(toReturn,1);
#	# SetAge(toReturn,1);
#	# SetKStepDescendant(toReturn,10);
#	return toReturn;
#else
#	Error("There are only 49487367289 groups of order 1024");
#fi;
## return fail;
#end);

InstallGlobalFunction("NumDescendants",function(parentGroup_Order,parentGroup_ID)
  local capableMaster, toRead, entry;

capableMaster:=[];
if parentGroup_Order < 512 then
	toRead:=StringFormatted("gap/CapableList16_256.g");
else
	toRead:=StringFormatted("gap/CapableList_512.g");
fi;

	if ReadPackage("GRPS1024",toRead) then
	# for j in [16,32,64,128,256] do
		Add(capableMaster,ValueGlobal(StringFormatted("Capable_{}",parentGroup_Order)));
	fi;

for entry in capableMaster[1] do
	if entry[1] = parentGroup_ID then
		return entry[2];
	fi;
od;

return 0;

end);

# these are the numbers which bound the available groups and where offsets change
# 1-3567
# 17643
# 5284672
# 39138178
# 683875132


InstallGlobalFunction("AvailableMap",function(i)
  local length1, length2, length3, length4, length5, offset1, offset2, offset3, offset4, offset5,length6;
  # local offset1, offset2, offset3, offset4, offset5;
  # local toReturn, i;

# toReturn:=[];


# toReturn:=Concatenation([1..3567],[378632399..378646474],[48076662881..48081929909],[48808773883..48842627388],[48842630322..49487367275]);;
# length1:=Length([1..3567]);
length1:=3567;
# length2:=Length([378632399..378646474]);
length2:=14076;
# length3:=Length([48076662881..48081929909]);
length3:=5267029;
# length4:=Length([48808773883..48842627388]);
length4:=33853506;
# length5:=Length([48842630322..49487367275]);
length5:=644736954;
# length6:=Length([49487367276..49487367289]);
length6:=14;

offset1:=378628831;
offset2:=47698016406;
offset3:=726843973;
offset4:=2933;
offset5:=13;
if i <= length1 then
	return i;
elif i > length1 and i <= length1+length2 then
	return i+offset1;
elif i > length1+length2 and i <= length1+length2+length3 then
	return i+offset1+offset2;
elif i > length1+length2+length3 and i <= length1+length2+length3+length4 then
	return i+offset1+offset2+offset3;
elif i > length1+length2+length3+length4 and i <= length1+length2+length3+length4+length5 then
	return i+offset1+offset2+offset3+offset4;
elif i > length1+length2+length3+length4+length5 and i <= length1+length2+length3+length4+length5+1 then
	return i+offset1+offset2+offset3+offset4+offset5;
# elif i > length1+length2+length3+length4+length5 and i <= length1+length2+length3+length4+length5+length6 then
# 	return i+offset1+offset2+offset3+offset4+offset5;
elif i > length1+length2+length3+length4+length5+1 then
	Error(StringFormatted("There are only {} groups of order 1024 available",683875133));
fi;
# 1-3566 are available
# 3567 is available
#
###3568-378632398 are descendants of [32,51]
#
###378632399-378646475 are descendants of groups of order 64
#
###378646475-48076662880 are descendants of [64,267]
#
###48076662881-48081929909 are descendants of groups of order 128
#
###48081929910-48808773882 are descendants of [128,2328] #
#
###48808773883-48842627388 are descendants of groups of order 256
#
###48842627389-48842630321 are descendants of [256,56092] #
#
###48842630322-49487367275 are descendants of groups of order 128
#
#elif i in [49487367276-49487367289] then 
###49487367276-49487367289 are the descendants of [512,10494213]
# return toReturn;
end);


InstallGlobalFunction("InverseAvailableMap",function(n)
  local length1, length2, length3, length4, length5, offset1, offset2, offset3, offset4, offset5,length6;
  # local offset1, offset2, offset3, offset4, offset5;
  # local toReturn, i;

# toReturn:=[];


# toReturn:=Concatenation([1..3567],[378632399..378646474],[48076662881..48081929909],[48808773883..48842627388],[48842630322..49487367275]);;
# length1:=Length([1..3567]);
length1:=3567;
# length2:=Length([378632399..378646474]);
length2:=14076;
# length3:=Length([48076662881..48081929909]);
length3:=5267029;
# length4:=Length([48808773883..48842627388]);
length4:=33853506;
# length5:=Length([48842630322..49487367275]);
length5:=644736954;
# length6:=Length([49487367276..49487367289]);
length6:=14;

offset1:=378628831;
offset2:=47698016406;
offset3:=726843973;
offset4:=2933;
offset5:=13;

# 1-3567 are available
#
if n in [1..3567] then
	return n;
elif n in [3568..378632398] then
###3568-378632398 are descendants of [32,51]
#
        Print("This is an immediate descendant of the elementary abelian group of order 32 and is not available\n");
	return 0;

elif n in [378632399..378646474] then
###378632399-378646475 are available
	return n-offset1;
#
elif n in [378646475..48076662880] then
        Print("This is an immediate descendant of the elementary abelian group of order 64 and is not available\n");
	return 0;
###378646475-48076662880 are descendants of [64,267]
#
elif n in [48076662881..48081929909] then
	return n-offset1-offset2;
###48076662881-48081929909 are available 
#
elif n in [48081929910..48808773882] then
        Print("This is an immediate descendant of the elementary abelian group of order 128 and is not available\n");
	return 0;
###48081929910-48808773882 are descendants of [128,2328] #
#
elif n in [48808773883..48842627388] then
###48808773883-48842627388 are available
##
	return n-offset1-offset2-offset3;
elif n in [48842627389..48842630321] then
###48842627389-48842630321 are descendants of [256,56092] #
#
        Print("This is an immediate descendant of the elementary abelian group of order 256 and is not available\n");
	return 0;
elif n in [48842630322..49487367275] then
###48842630322-49487367275 are available
##
	return n-offset1-offset2-offset3-offset4;
elif n in [49487367276..49487367288] then 
###49487367276-49487367289 are the descendants of [512,10494213]
        Print("This is an immediate descendant of the elementary abelian group of order 512 and is not available\n");
	return 0;
elif n = 49487367289 then
	return n-offset1-offset2-offset3-offset4-offset5;
#49487367289 is the elementary abelian group
elif n > 49487367289 then
	Error("There are only 49487367289 groups of order 1024\n");
# return toReturn;
fi;
end);


InstallGlobalFunction("ReturnCapableGroupsOfOrder",function(order)
  local capableMaster, toRead;

	capableMaster:=[];
	if order in [2,4,8,16,32,64,128,256] then
		toRead:="gap/CapableList16_256.g";
	elif order = 512 then
		toRead:="gap/CapableList512.g";
	else
		Info(InfoDebug,2,"Groups of this order are not currently supported");
		return capableMaster;
	fi;

	if ReadPackage("GRPS1024",toRead) then
		Add(capableMaster,ValueGlobal(StringFormatted("Capable_{}",order)));
		# for j in [16,32,64,128,256] do
		# 	Add(capableMaster,ValueGlobal(StringFormatted("Capable_{}",j)));
	# od;
	fi;
	
	return capableMaster;
end);
# InstallMethod(ParentGroup,"for p-groups",[IsGroup and IsFinite],function(G)
# 	return 
#
#############################################################################
## GroupShell in a parent group and outputs a partially constructed immediate descendant
##
InstallGlobalFunction("ImmediateDescendantGroupShell", function(M)
# InstallGlobalFunction( SubmagmaWithInversesNC, function( M, gens )
    local K, S;

    # if IsEmpty( gens ) then
      K:= NewType( FamilyObj(M),
                       IsMagmaWithInverses
                   and IsTrivial
                   and IsAttributeStoringRep
                   and HasGeneratorsOfMagmaWithInverses);
      S:=rec();
      ObjectifyWithAttributes(S, K, GeneratorsOfMagmaWithInverses, [] );
    # else
    #   S:= MagmaWithInversesByGenerators(gens);
    # fi;
    # SetParent( S, M );
    return S;
end );

#this is different than the system defined one since it only takes one input
InstallGlobalFunction( CustomPrintPcPresentation, function(G)
    local pcgs, n, F, gens, i, pis, exp, t, h, rel, commPower, j, trivialCommutators,commBool;

    pcgs:=Pcgs(G);
    n:=Length(pcgs);
    F    := FreeGroup( n, "f" );
    gens := GeneratorsOfGroup( F );
    pis  := RelativeOrders( pcgs );

    # compute the orders of the pc-generators
    for i in [1..n] do
        exp := ExponentsOfRelativePower( pcgs, i ){[i+1..n]};
        t   := One( F );
        for h in [i+1..n] do
            t := t * gens[h]^exp[h-i];
        od;
        if IsOne( t ) then
            t := "id";
        fi;
        Print(gens[i], "^", pis[i], " = ", t, "\n");
    od;

    # compute the commutators / conjugation
    # of all pairs of pc-generators
    trivialCommutators := false;
    commBool:=true;
    for i in [1..n] do
        for j in [i+1..n] do
            if pcgs[j] * pcgs[i] = pcgs[i] * pcgs[j] then
                trivialCommutators := true;
                # continue;
            fi;
            if commBool then
                commPower := Comm( pcgs[j], pcgs[i] );
            else
                commPower := pcgs[j]^pcgs[i];
            fi;
            exp := ExponentsOfPcElement( pcgs, commPower ){[i+1..n]};
            t   := One( F );
            for h in [i+1..n] do
                t := t * gens[h]^exp[h-i];
            od;
            if commBool then
                Print("[", gens[j], ",", gens[i] , "]");
            else
                Print(gens[j], "^", gens[i]);
            fi;
	if IsOne( t ) then
	    t := "id";
	fi;
            Print(" = ", t, "\n");
        od;
    od;

    # return trivialCommutators;
end );

#InstallGlobalFunction("PrintClassificationTable1024",function()
#  local currentPClass, currentRank, doworking, thencurrentRank, i,working,currentParentGroupOrder,numDescendants;

#currentPClass:=0;
#currentRank:=0;
#currentParentGroupOrder:=0;
## for i in [1..49487367289] do
##683875133
## for i in [1..n] do
## for i in [1..683875133] do
#i:=1;
#while i <= 683875133 do
## for i in [1..20000] do
#working:=SmallGroup(1024,AvailableMap(i));
#if not currentParentGroupOrder=GRPS1024_Heritage(working)[1] then
#if currentRank > 0 then
#Print(StringFormatted("-{} have rank {} and pclass {}\n",i-1,currentRank,currentPClass));
#fi;
#Print(StringFormatted("######################Immediate Descendants of order {}#############\n",GRPS1024_Heritage(working)[1]));
#currentParentGroupOrder:=GRPS1024_Heritage(working)[1];
#currentRank:=RankPGroup(working);
#currentPClass:=PClassPGroup(working);

## Print(StringFormatted(" Group {} has rank {} and pclass {}\n",AvailableMap(i),currentRank,currentPClass));
## Print(StringFormatted("Available Group {} has rank {} and pclass {}\n",i,currentRank,currentPClass));
#Print(StringFormatted("Available Groups {}",i));
#numDescendants:=NumDescendants(GRPS1024_Heritage(working)[1],GRPS1024_Heritage(working)[2]);
#if numDescendants > 1 then
#i:=numDescendants+i-1;
#fi;
#fi;

#if not currentRank = RankPGroup(working) or not currentPClass = PClassPGroup(working) or not currentParentGroupOrder= GRPS1024_Heritage(working)[1] then
## if i > 1 then
## Print(StringFormatted(" Group {} has rank {} and pclass {}\n",AvailableMap(i)-1,currentRank,currentPClass));
## fi;
## Print(StringFormatted("Available Group {} has rank {} and pclass {}\n",i-1,currentRank,currentPClass));
#Print(StringFormatted("-{} have rank {} and pclass {}\n",i-1,currentRank,currentPClass));

#currentRank:=RankPGroup(working);
#currentPClass:=PClassPGroup(working);

## Print(StringFormatted("Group {} has rank {} and pclass {}\n",AvailableMap(i),currentRank,currentPClass));
#Print(StringFormatted("Available Groups {}",i));
#numDescendants:=NumDescendants(GRPS1024_Heritage(working)[1],GRPS1024_Heritage(working)[2]);
#if numDescendants > 1 then
#i:=numDescendants+i-1;
#fi;
#fi;

#i:=i+1;	
#od;

## Print(StringFormatted("######################Immediate Descendants of order {}#############\n",GRPS1024_Heritage(working)[1]));
## Print(StringFormatted(" Group {} has rank {} and pclass {}\n",AvailableMap(i),currentRank,currentPClass));
#Print(StringFormatted("Available Group {} has rank {} and p-class {}\n",i,currentRank,currentPClass));
#end);

# ids:=[1,3567,3568,378632398,378632399,378646474,378646475,48076662880,48076662881,48081929909,48081929910,48808773882,48808773883,48842627388,48842627389,48842630321,48842630322,49487367275,49487367276,49487367288,49487367289];
#
 InstallGlobalFunction("ReturnCapableGroups",function()
return [Capable_16,Capable_32,Capable_64,Capable_128,Capable_256,Capable_512];
end);


InstallGlobalFunction("PrintClassificationTable1024",function(start_id,end_id)
  local i, currentPClass, currentRank, currentParentGroupOrder, num_siblings, working, numDescendants;

# i:=1;
i:=start_id;
currentPClass:=0;
currentRank:=0;
currentParentGroupOrder:=0;

# while i <= end_id and i <= 683875133 do
while i < Minimum(end_id,GRPS1024_AVAIL) do
# while i <= 875133 do
working:=SmallGroup(1024,AvailableMap(i));
num_siblings:=NumDescendants(GRPS1024_Heritage(working)[1],GRPS1024_Heritage(working)[2]);
# Print(StringFormatted("{} - {}\n",i,i+num_siblings-1));


working:=SmallGroup(1024,AvailableMap(i));
if not currentParentGroupOrder=GRPS1024_Heritage(working)[1] then
	if currentRank > 0 then
	Print(StringFormatted("-{} have rank {} and pclass {}\n",i-1,currentRank,currentPClass));
	fi;

	Print(StringFormatted("######################Immediate Descendants of order {}#############\n",GRPS1024_Heritage(working)[1]));
	currentParentGroupOrder:=GRPS1024_Heritage(working)[1];
	currentRank:=RankPGroup(working);
	currentPClass:=PClassPGroup(working);

	Print(StringFormatted("Available Groups {}",i));
	numDescendants:=NumDescendants(GRPS1024_Heritage(working)[1],GRPS1024_Heritage(working)[2]);
fi;

if not currentRank = RankPGroup(working) or not currentPClass = PClassPGroup(working) or not currentParentGroupOrder = GRPS1024_Heritage(working)[1] then
	Print(StringFormatted("-{} have rank {} and pclass {}\n",i-1,currentRank,currentPClass));

	currentRank:=RankPGroup(working);
	currentPClass:=PClassPGroup(working);

	# Print(StringFormatted("Group {} has rank {} and pclass {}\n",AvailableMap(i),currentRank,currentPClass));
	Print(StringFormatted("Available Groups {}",i));
	numDescendants:=NumDescendants(GRPS1024_Heritage(working)[1],GRPS1024_Heritage(working)[2]);
fi;

i:=i+num_siblings;
od;


	working:=SmallGroup(1024,AvailableMap(end_id));
	currentRank:=RankPGroup(working);
	currentPClass:=PClassPGroup(working);
	Print(StringFormatted("-{} have rank {} and pclass {}\n",end_id,currentRank,currentPClass));


end);

InstallGlobalFunction("AvailableGroups1024Information",function()

Print( "\n###############Available Groups Information#################\n");
Print( "\n###############Immediate Descendants of order 16############\n");
Print( "Available Groups 1-3566 have rank 4 and pclass 2\n");
Print( "\n###############Immediate Descendants of order 32############\n");
Print( "Available Groups 3567-3567 have rank 2 and pclass 3\n");
Print( "\n###############Immediate Descendants of order 64############\n");
Print( "Available Groups 3568-17643 have rank 3 and pclass 3\n");
Print( "\n###############Immediate Descendants of order 128###########\n");
Print( "Available Groups 17644-17795 have rank 2 and pclass 4\n");
Print( "Available Groups 17796-209592 have rank 3 and pclass 3\n");
Print( "Available Groups 209593-2784542 have rank 4 and pclass 3\n");
Print( "Available Groups 2784543-5284672 have rank 5 and pclass 3\n");
Print( "\n###############Immediate Descendants of order 256###########\n");
Print( "Available Groups 5284673-5286130 have rank 2 and pclass 4\n");
Print( "Available Groups 5286131-5286991 have rank 2 and pclass 5\n");
Print( "Available Groups 5286992-5391292 have rank 3 and pclass 3\n");
Print( "Available Groups 5391293-5446972 have rank 3 and pclass 4\n");
Print( "Available Groups 5446973-5448532 have rank 3 and pclass 5\n");
Print( "Available Groups 5448533-8568423 have rank 4 and pclass 3\n");
Print( "Available Groups 8568424-8584451 have rank 4 and pclass 4\n");
Print( "Available Groups 8584452-38912416 have rank 5 and pclass 3\n");
Print( "Available Groups 38912417-39138178 have rank 6 and pclass 3\n");
Print( "\n###############Immediate Descendants of order 512###########\n");
Print( "Available Groups 39138179-39138179 have rank 1 and pclass 10\n");
Print( "Available Groups 39138180-39138479 have rank 2 and pclass 4\n");
Print( "Available Groups 39138480-39140738 have rank 2 and pclass 5\n");
Print( "Available Groups 39140739-39141070 have rank 2 and pclass 6\n");
Print( "Available Groups 39141071-39142607 have rank 2 and pclass 5\n");
Print( "Available Groups 39142608-39144344 have rank 2 and pclass 6\n");
Print( "Available Groups 39144345-39144783 have rank 2 and pclass 7\n");
Print( "Available Groups 39144784-39144823 have rank 2 and pclass 8\n");
Print( "Available Groups 39144824-39144828 have rank 2 and pclass 9\n");
Print( "Available Groups 39144829-39144967 have rank 3 and pclass 3\n");
Print( "Available Groups 39144968-39474000 have rank 3 and pclass 4\n");
Print( "Available Groups 39474001-39478685 have rank 3 and pclass 5\n");
Print( "Available Groups 39478686-39482594 have rank 3 and pclass 4\n");
Print( "Available Groups 39482595-39549533 have rank 3 and pclass 5\n");
Print( "Available Groups 39549534-39557923 have rank 3 and pclass 6\n");
Print( "Available Groups 39557924-39558112 have rank 3 and pclass 7\n");
Print( "Available Groups 39558113-39558121 have rank 3 and pclass 8\n");
Print( "Available Groups 39558122-40250510 have rank 4 and pclass 3\n");
Print( "Available Groups 40250511-41845930 have rank 4 and pclass 4\n");
Print( "Available Groups 41845931-41897589 have rank 4 and pclass 5\n");
Print( "Available Groups 41897590-41898679 have rank 4 and pclass 6\n");
Print( "Available Groups 41898680-41898693 have rank 4 and pclass 7\n");
Print( "Available Groups 41898694-374220787 have rank 5 and pclass 3\n");
Print( "Available Groups 374220788- have rank 5 and pclass 4\n");

#Print( "");


    Print( " \n");
    Print( "This database was created by David Burrell (2022).\n");

end);

# DeclareGlobalFunction("Groups1024Information",function()


#     Print( " \n");
#     Print( "This database was created by David Burrell (2022).\n");

# end);
