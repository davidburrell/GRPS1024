
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
  local capableMaster, toRead, offset, order, step, parent_ID, parent_Order, heritage, toReturn, j, group_order, group, i,breakOuter;
    # local l, j, k, layer_id, layer_position, toRead, split_size_1, split_size_2,layer_change,offset;

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
	# parent_ID:=0;
	# parent_Order:=0;
	heritage:=rec();
	breakOuter:=false;
	#toSkip:=[[32,51],[64,267],[128
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
					# Error(StringFormatted("\n SmallGroup(1024,{}) is an immediate descendant of the Elementary Abelian group of order {} and is not currently available\n ",n,order));
					Print(StringFormatted("\n SmallGroup(1024,{}) is an immediate descendant of the Elementary Abelian group of order {} and is not currently available.\n Partially constructed group returned \n",n,order));
				#TODO: maybe we should return an empty group shell instead with just the information that is known
					toReturn:=ImmediateDescendantGroupShell(ElementaryAbelianGroup(order));
				# SetParentGroupID(toReturn,heritage.ID);
				# SetParentGroupOrder(toReturn,heritage.Order);
				# SetAge(toReturn,heritage.Age);
				SetHeritage(toReturn,[heritage.Order,heritage.ID,heritage.Age]);
				SetPClassPGroup(toReturn,2);
				SetOrder(toReturn,1024);
				return toReturn;
					# SetParentGroupID(toReturn,group[1])
					# SetParentGroupOrder(toReturn,order);

					# return ElementaryAbelianGroup(order);
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
				# SetParentGroupID(toReturn,heritage.ID);
				# SetParentGroupOrder(toReturn,heritage.Order);
				# SetAge(toReturn,heritage.Age);
				SetHeritage(toReturn,[heritage.Order,heritage.ID,heritage.Age]);
				# SetPClassPGroup(toReturn,2);
				# SetOrder(toReturn,1024);

				return toReturn ;
				# break;
				# desc:=CheckoutDescendants(order,group[1]);
				#desc:=List(desc,CodePcGroup);
				# Sort(desc);
				# these lists were sorted after generation and before preparation of this package
				# toReturn:=PcGroupCode(desc[n-offset],1024);
				# SetParentGroupID(toReturn,group[1]);
				# SetParentGroupOrder(toReturn,order);
				# SetAge(toReturn,n-offset);
				# SetKStepDescendant(toReturn,step);
				# return toReturn;
				# return [order,group[1],step,n-offset,desc[n-offset]];
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
				heritage.ID:=group[1];
				heritage.Order:=order;
				heritage.Age:=n-offset;

				if NumberSmallGroups(order)=group[1] then
					# Error(StringFormatted("\n\nSmallGroup(1024,{}) is an immediate descendant of the Elementary Abelian group of order {} and is not currently available\n\n",n,order));
					# Print(StringFormatted("Descendant {} of the Elementary Abelian group of order {} is not available returning parent group\n",n-offset,order));
					Print(StringFormatted("\n SmallGroup(1024,{}) is an immediate descendant of the Elementary Abelian group of order {} and is not currently available. Partially constructed group returned\n",n,order));
				#TODO: maybe we should return an empty group shell instead with just the information that is known
					toReturn:=ImmediateDescendantGroupShell(ElementaryAbelianGroup(order));
				# SetParentGroupID(toReturn,heritage.ID);
				# SetParentGroupOrder(toReturn,heritage.Order);
				# SetAge(toReturn,heritage.Age);
				SetHeritage(toReturn,[heritage.Order,heritage.ID,heritage.Age]);
				SetPClassPGroup(toReturn,2);
				SetOrder(toReturn,1024);

				return toReturn;
					# return ElementaryAbelianGroup(order);
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
				# SetParentGroupID(toReturn,heritage.ID);
				# SetParentGroupOrder(toReturn,heritage.Order);
				# SetAge(toReturn,heritage.Age);
				SetHeritage(toReturn,[heritage.Order,heritage.ID,heritage.Age]);

				return toReturn ;
				# break;
				#desc:=CheckoutDescendants(order,group[1]);
				##desc:=List(desc,CodePcGroup);
				##Sort(desc);
				#toReturn:=PcGroupCode(desc[n-offset],1024);
				#SetParentGroupID(toReturn,group[1]);
				#SetParentGroupOrder(toReturn,order);
				#SetAge(toReturn,n-offset);
				#SetKStepDescendant(toReturn,step);
				#return toReturn;
				# return [order,group[1],step,n-offset,desc[n-offset]];
			else
				continue;
			fi;
		od;


	elif n = 49487367289 then
		toReturn:=ElementaryAbelianGroup(1024);
		# SetParentGroupID(toReturn,1);
		# SetParentGroupOrder(toReturn,1);
		# SetAge(toReturn,1);
		SetHeritage(toReturn,[1,1,1]);
		# SetKStepDescendant(toReturn,10);
		return toReturn;
	fi;
end;

# Method for selecting a subset of the groups which have a given list of properties, i.e. IsAbelian, IsNilpotent
SELECT_SMALL_GROUPS_FUNCS[ pos_2_10 ] := SELECT_SMALL_GROUPS_FUNCS[ 11 ];


# Method for SmallGroupsInformation(size):
SMALL_GROUPS_INFORMATION[ pos_2_10 ] := function( size, inforec, num )
    # Print( "     1 is cyclic. \n");
    # Print( "     2 - 10 have rank 2 and p-class 3.\n" );
    # Print( "     11 - 386 have rank 2 and p-class 4.\n" );
    # Print( "     387 - 1698 have rank 2 and p-class 5.\n" );
    # Print( "     1699 - 2008 have rank 2 and p-class 6.\n" );
    # Print( "     2009 - 2039 have rank 2 and p-class 7.\n" );
    # Print( "     2040 - 2044 have rank 2 and p-class 8.\n" );
    # Print( "     2045 has rank 3 and p-class 2.\n" );
    # Print( "     2046 - 29398 have rank 3 and p-class 3.\n" );
    # Print( "     29399 - 30617 have rank 3 and p-class 4.\n" );
    # Print( "     30618 - 31239 have rank 3 and p-class 3.\n" );
    # Print( "     31240 - 56685 have rank 3 and p-class 4.\n" );
    # Print( "     56686 - 60615 have rank 3 and p-class 5.\n" );
    # Print( "     60616 - 60894 have rank 3 and p-class 6.\n" );
    # Print( "     60895 - 60903 have rank 3 and p-class 7.\n" );
    # Print( "     60904 - 67612 have rank 4 and ", "p-class 2.\n" );
    # Print( "     67613 - 387088 have rank 4 and ", "p-class 3.\n" );
    # Print( "     387089 - 419734 have rank 4 and ", "p-class 4.\n" );
    # Print( "     419735 - 420500 have rank 4 and ", "p-class 5.\n" );
    # Print( "     420501 - 420514 have rank 4 and ", "p-class 6.\n" );
    # Print( "     420515 - 6249623 have rank 5 and ", "p-class 2.\n" );
    # Print( "     6249624 - 7529606 have rank 5 and ", "p-class 3.\n" );
    # Print( "     7529607 - 7532374 have rank 5 and ", "p-class 4.\n" );
    # Print( "     7532375 - 7532392 have rank 5 and ", "p-class 5.\n" );
    # Print( "     7532393 - 10481221 have rank 6 and ", "p-class 2.\n" );
    # Print( "     10481222 - 10493038 have rank 6 and ", "p-class 3.\n" );
    # Print( "     10493039 - 10493061 have rank 6 and ", "p-class 4.\n" );
    # Print( "     10493062 - 10494173 have rank 7 ", "and p-class 2.\n" );
    # Print( "     10494174 - 10494200 have rank 7 ", "and p-class 3.\n" );
    # Print( "     10494201 - 10494212 have rank 8 ", "and p-class 2.\n" );
    # Print( "     10494213 is elementary abelian.\n");
    Print( " \n");
    Print( "This database was created by David Burrell (2022).\n");
end;
