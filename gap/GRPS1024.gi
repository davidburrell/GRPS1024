#
# GRPS1024: Utilities for iterating through the groups of order 1024 with p-class at least 3
#
# Implementations
#

InstallGlobalFunction("ReloadGRPS1024",function()
 Print(RereadPackage("GRPS1024/gap/GRPS1024.gd"),"\n");
 Print(RereadPackage("GRPS1024/gap/GRPS1024.gi"),"\n");
end);

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
	#remember the first entry is that of the descendants parentgroup id
	return toReturn{[2..Length(toReturn)]};
else
	Info(InfoDebug,1,StringFormatted("The presentations of the immediate descendants of {}#{} are not available",parentGroup_Order,parentGroup_ID));
	#TODO maybe print or return a total?
	return [];
fi;
end);


InstallGlobalFunction("FindNthAvailableGroup",function(n)
return FindGroupN(AvailableMap(n));
end);

InstallGlobalFunction("IsAvailable",function(n)

local capableMaster,toRead,j,group_order,group,i,offset,order,step,desc,toSkip;
if n <= 49487367289 then


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
					Print(StringFormatted("Descendant {} of the Elementary Abelian group of order {}",n-offset,order));
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
InstallGlobalFunction("FindGroupN",function(n)

local capableMaster,toRead,j,group_order,group,i,offset,order,step,desc,toSkip;

if n <= 49487367289 then
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
					Print(StringFormatted("Descendant {} of the Elementary Abelian group of order {}",n-offset,order));
					return;
				fi;
				desc:=CheckoutDescendants(order,group[1]);
				#desc:=List(desc,CodePcGroup);
				# Sort(desc);
				# these lists were sorted after generation and before preparation of this package
				return [order,group[1],step,n-offset,desc[n-offset]];
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
					Print(StringFormatted("Descendant {} of the Elementary Abelian group of order {}",n-offset,order));
					return;
				fi;
				desc:=CheckoutDescendants(order,group[1]);
				#desc:=List(desc,CodePcGroup);
				Sort(desc);
				return [order,group[1],step,n-offset,desc[n-offset]];
			else
				continue;
			fi;
		od;
else
	Error("There are only 49487367289 groups of order 1024");
fi;
# return fail;
end);

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

InstallGlobalFunction("AvailableMap",function(i)
  local length1, length2, length3, length4, length5, offset1, offset2, offset3, offset4, offset5;
  # local offset1, offset2, offset3, offset4, offset5;
  # local toReturn, i;

# toReturn:=[];


# toReturn:=Concatenation([1..3567],[378632399..378646474],[48076662881..48081929909],[48808773883..48842627388],[48842630322..49487367275]);;
length1:=Length([1..3567]);
length2:=Length([378632399..378646474]);
length3:=Length([48076662881..48081929909]);
length4:=Length([48808773883..48842627388]);
length5:=Length([48842630322..49487367275]);
# length6:=Length([49487367276..49487367289]);

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
# elif i > length1+length2+length3+length4+length5 and i <= length1+length2+length3+length4+length5+length6 then
# 	return i+offset1+offset2+offset3+offset4+offset5;
elif i > length1+length2+length3+length4+length5 then
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
###48808773883-48842627388 are descendants of groups of order 128
#
###48842627389-48842630321 are descendants of [256,56092] #
#
###48842630322-49487367275 are descendants of groups of order 128
#
#elif i in [49487367276-49487367289] then 
###49487367276-49487367289 are the descendants of [512,10494213]
# return toReturn;
end);
