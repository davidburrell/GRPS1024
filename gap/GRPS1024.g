
layer_2_10 := Length(SMALL_AVAILABLE_FUNCS)+1;

pos_2_10:= Maximum(List([
        SMALL_GROUP_FUNCS,
        SMALL_GROUPS_INFORMATION,
        NUMBER_SMALL_GROUPS_FUNCS,
        ID_GROUP_FUNCS,
        SELECT_SMALL_GROUPS_FUNCS,
    ], Length)) + 1;


SMALL_AVAILABLE_FUNCS[layer_2_10] := function( size )
    if size = 1024 then
        return rec (
            lib := layer_2_10,
            func := pos_2_10,
            number := 49487367289);
    fi;
    return fail;
end;


ID_AVAILABLE_FUNCS[layer_2_10] := function( size )
    return fail;

end;


SMALL_GROUP_FUNCS[ pos_2_10 ] := function( size, n, inforec )
  local capableMaster, toRead, offset, order, step, parent_ID, parent_Order, heritage, toReturn, j, group_order, group, i,breakOuter,parent;

    if n > inforec.number then 
        Error("there are just ",inforec.number," groups of order ",size );
    fi;

    if n < inforec.number then
	capableMaster:=[];
	toRead:=StringFormatted("gap/CapableList16_256.g");

	if ReadPackage("GRPS1024",toRead) then
		for j in [16,32,64,128,256] do
			Add(capableMaster,ValueGlobal(StringFormatted("Capable_{}",j)));
	od;
	fi;

	i:=0;
	offset:=0;
	order:=8;
	step:=0;
	heritage:=rec();
	breakOuter:=false;
	for group_order in capableMaster do
		order:=order*2;
		step:=Length(FactorsInt(1024)) - Length(FactorsInt(order));
		for group in group_order do
			offset:=i;
			i:=i+group[2];

			#the first time that i is greater than our number we have found our parent id
			if i >= n then
				#
				#n-offset is the position in the ordered list of descendants
				#we are looking for i.e. the age of the nth group among its
				#siblings
				#desc:=PqDescendants(SmallGroup(order,group[1]):StepSize:=step);
				#the elementary abelian groups are always the last ones
				# so this just quickly gives us the right small group id
				heritage.ID:=group[1];
				heritage.Order:=order;
				heritage.Age:=n-offset;

				if order > 16 and NumberSmallGroups(order)=group[1] then
					toReturn:=ImmediateDescendantGroupShell(ElementaryAbelianGroup(order));

				SetHeritage(toReturn,[heritage.Order,heritage.ID,heritage.Age]);
				SetPClassPGroup(toReturn,2);
				SetRankPGroup(toReturn,RankPGroup(ElementaryAbelianGroup(order)));
				SetOrder(toReturn,1024);
				return toReturn;
				fi;

				if not IsBound(SMALL_GROUP_LIB[1024]) then
					SMALL_GROUP_LIB[1024]:=[];
				fi;

				if not IsBound(SMALL_GROUP_LIB[1024][heritage.Order]) then
					SMALL_GROUP_LIB[1024][heritage.Order]:=[];
				fi;

				if not IsBound(SMALL_GROUP_LIB[1024][heritage.Order][heritage.ID]) then
					SMALL_GROUP_LIB[1024][heritage.Order][heritage.ID]:=CheckoutDescendants(heritage.Order,heritage.ID);
				fi;

				toReturn:=PcGroupCode(SMALL_GROUP_LIB[1024][heritage.Order][heritage.ID][heritage.Age],size);

				SetHeritage(toReturn,[heritage.Order,heritage.ID,heritage.Age]);
				
				parent:=SmallGroup(heritage.Order,heritage.ID);
				SetPClassPGroup(toReturn,PClassPGroup(parent)+1);
				SetRankPGroup(toReturn,RankPGroup(parent));
				
				return toReturn ;
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
		capableMaster:=ValueGlobal(StringFormatted("Capable_{}",512));
	fi;

		for group in capableMaster do
			offset:=i;
			i:=i+group[2];
			if i >= n then
				#n-offset is the position in the ordered list of descendants
				#we are looking for i.e. the age of the nth group among its
				#siblings

				heritage.ID:=group[1];
				heritage.Order:=order;
				heritage.Age:=n-offset;

				if NumberSmallGroups(order)=group[1] then
					toReturn:=ImmediateDescendantGroupShell(ElementaryAbelianGroup(order));
				SetHeritage(toReturn,[heritage.Order,heritage.ID,heritage.Age]);
				SetPClassPGroup(toReturn,2);
				SetRankPGroup(toReturn,RankPGroup(ElementaryAbelianGroup(order)));
				SetOrder(toReturn,1024);

				return toReturn;
				fi;

				if not IsBound(SMALL_GROUP_LIB[1024]) then
					SMALL_GROUP_LIB[1024]:=[];
				fi;

				if not IsBound(SMALL_GROUP_LIB[1024][heritage.Order]) then
					SMALL_GROUP_LIB[1024][heritage.Order]:=[];
				fi;

				if not IsBound(SMALL_GROUP_LIB[1024][heritage.Order][heritage.ID]) then
					SMALL_GROUP_LIB[1024][heritage.Order][heritage.ID]:=CheckoutDescendants(heritage.Order,heritage.ID);
				fi;

				toReturn:=PcGroupCode(SMALL_GROUP_LIB[1024][heritage.Order][heritage.ID][heritage.Age],size);
				SetHeritage(toReturn,[heritage.Order,heritage.ID,heritage.Age]);
				parent:=SmallGroup(heritage.Order,heritage.ID);
				SetPClassPGroup(toReturn,PClassPGroup(parent)+1);
				SetRankPGroup(toReturn,RankPGroup(parent));

				return toReturn ;
			else
				continue;
			fi;
		od;


	elif n = 49487367289 then
		toReturn:=ElementaryAbelianGroup(1024);
		SetHeritage(toReturn,[1,1,1]);

		return toReturn;
	fi;
end;

# Method for selecting a subset of the groups which have a given list of properties, i.e. IsAbelian, IsNilpotent
SELECT_SMALL_GROUPS_FUNCS[ pos_2_10 ] := SELECT_SMALL_GROUPS_FUNCS[ 11 ];


# Method for SmallGroupsInformation(size):
# Inorder for this method to work lines 31-34 pkg/SmallGrp-1.5/gap/smlinfo.gi need to commented out
#
SMALL_GROUPS_INFORMATION[ pos_2_10 ] := function( size, inforec, num )

AvailableGroups1024Information();
Groups1024Information();

end;
