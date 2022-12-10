
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
###### NEW CODE #######################
if not IsBound(GRPS1024_class_matrix) then ReadPackage("GRPS1024","gap/class_matrix.g"); fi;


find_rank:=function(n)
	return Length(Positions(List(GRPS1024_row_partial_sums,x->n>x),true))+1;
end;

find_class:=function(n)
  local rank, offset;

	rank:=find_rank(n);

	if rank = 1 then
		# offset:=1;
		return 10;
	else
		offset:=n-GRPS1024_row_partial_sums[rank-1];
	fi;

	# PrintFormatted("The Offset is {}\n",offset);
	return Length(Positions(List(GRPS1024_p_class_sums_matrix[rank],x-> offset > x),true))+1;
	
	# for i in [1..find_rank] do
	# od;
end;

#<<<<<<< Updated upstream
#			#the first time that i is greater than our number we have found our parent id
#			if i >= n then
#				#
#				#n-offset is the position in the ordered list of descendants
#				#we are looking for i.e. the age of the nth group among its
#				#siblings
#				#desc:=PqDescendants(SmallGroup(order,group[1]):StepSize:=step);
#				#the elementary abelian groups are always the last ones
#				# so this just quickly gives us the right small group id
#				heritage.ID:=group[1];
#				heritage.Order:=order;
#				heritage.Age:=n-offset;

#				if order > 16 and NumberSmallGroups(order)=group[1] then
#					toReturn:=ImmediateDescendantGroupShell(ElementaryAbelianGroup(order));

#				SetGRPS1024_Heritage(toReturn,[heritage.Order,heritage.ID,heritage.Age]);
#				SetPClassPGroup(toReturn,2);
#				SetRankPGroup(toReturn,RankPGroup(ElementaryAbelianGroup(order)));
#				SetOrder(toReturn,1024);
#				return toReturn;
#				fi;

#				if not IsBound(SMALL_GROUP_LIB[1024]) then
#					SMALL_GROUP_LIB[1024]:=[];
#				fi;

#				if not IsBound(SMALL_GROUP_LIB[1024][heritage.Order]) then
#					SMALL_GROUP_LIB[1024][heritage.Order]:=[];
#				fi;

#				if not IsBound(SMALL_GROUP_LIB[1024][heritage.Order][heritage.ID]) then
#					SMALL_GROUP_LIB[1024][heritage.Order][heritage.ID]:=CheckoutDescendants(heritage.Order,heritage.ID);
#				fi;

#				toReturn:=PcGroupCode(SMALL_GROUP_LIB[1024][heritage.Order][heritage.ID][heritage.Age],size);

#				SetGRPS1024_Heritage(toReturn,[heritage.Order,heritage.ID,heritage.Age]);
				
#				parent:=SmallGroup(heritage.Order,heritage.ID);
#				SetPClassPGroup(toReturn,PClassPGroup(parent)+1);
#				SetRankPGroup(toReturn,RankPGroup(parent));
				
#				return toReturn ;
#			else
#				continue;
#			fi;
#		od;
#	od;

#	## if we are here then the group is an immediate descendant of a group of order 512
#	order:=512;
#	step:=1;
#	toRead:=StringFormatted("gap/CapableList_512.g");

#	if ReadPackage("GRPS1024",toRead) then
#		capableMaster:=ValueGlobal(StringFormatted("Capable_{}",512));
#=======
find_parent:=function(n)
  local rank, pclass, offset, working_sum, age, entry;
	
	if n = 1 then
		return [GRPS1024_class_matrix[1][10][1],1];
# >>>>>>> Stashed changes
	fi;
	rank:=find_rank(n);
	pclass:=find_class(n);

	offset:=(GRPS1024_row_partial_sums[rank-1]+GRPS1024_p_class_sums_matrix[rank][pclass-1]);
	age := n-offset;
	

	if Length(GRPS1024_class_matrix[rank][pclass]) = 1 then
		return [GRPS1024_class_matrix[rank][pclass][1],age];
	else
		working_sum:=0;
		for entry in GRPS1024_class_matrix[rank][pclass] do
			if age <= entry[3] then
				return [entry,age];
			fi;
			age:=age-entry[3];
		od;
	fi;
end;


# row:=function(A,n)
# 	return A[n];
# end;

# col:=function(A,n)
# 	return MutableCopyMat(TransposedMat(A)[n]);
# end;

# row_partial_sum_zeros:=function(A,n)
# 	local entry,sum,parent,toReturn;
# 		sum:=0;
# 		toReturn:=[];
# 	for entry in A[n] do
		
# 		for parent in entry do
# 			sum:=sum + parent[3];	
# 		od;
# 		if Length(entry) > 0 then
# 			Add(toReturn,sum);
# 		else
# 			Add(toReturn,0);
# 		fi;
# 	od;
# 	return toReturn;
# end;

# row_partial_sum:=function(A,n)
# 	local entry,sum,parent,toReturn;
# 		sum:=0;
# 		toReturn:=[];
# 	for entry in A[n] do
# 		for parent in entry do
# 			sum:=sum + parent[3];	
# 		od;
# 		Add(toReturn,sum);
# 	od;
# 	return toReturn;
# end;

# row_sums:=function(row)
#   local toReturn, sum, pclass, parent;
	
# 	toReturn:=[];
	
# 	for pclass in row do
# 		sum:=0;
# 		for parent in pclass do
# 			sum:=sum+parent[3];
# 		od;
# 		Add(toReturn,sum);	
# 	od;
# 	return toReturn;
# end;	

# row_sum:=function(A,n)
# 	local entry,sum,parent;
# 		sum:=0;
# 	for entry in A[n] do
# 		for parent in entry do
# 			sum:=sum + parent[3];	
# 		od;
# 	od;
# 	return sum;
# end;	

# column_sum:=function(A,n)
# 	return row_sum(TransposedMat(A),n);
# end;

#R_G is the total number of groups of order $|G|$ with rank strictly less than that of $G$
GRPS1024_R_G:=function(G)
	local rank,toReturn;
	rank:=RankPGroup(G);
	# toReturn:=0;
	
	if rank = 1 then
		return 0;
	else
		return Sum(GRPS1024_row_totals{[1..rank-1]});
		# for i in [1..rank-1] do
		# 	toReturn:=toReturn + row_sum(class_matrix,i);
		# od;
	fi;
end;
# C_G is the total number of groups of order $|G|$ with the same rank as $G$ by $p$-class strictly less than that of $G$
GRPS1024_C_G:=function(G)
  local sum, entry, parent;

	if PClassPGroup(G) = 1 then
		return 0;
	else
	# local entry,sum;
		sum:=0;
		for entry in GRPS1024_class_matrix[RankPGroup(G)]{[1..PClassPGroup(G)-1]} do
			for parent in entry do
				sum:=sum + parent[3];	
			od;
		od;
		return sum;
		# return row_sum(class_matrix[RankPGroup(G)]{[1..PClassPGroup(G)-1]});
		# return Sum(column_totals{[1..PClassPGroup(G)-1]});
	fi;
	
end;

GRPS1024_P_G:=function(G)
  local rank, pclass, parent_ID, parents, parent_prec;

	# if IsElementaryAbelian(G) then
	# 	return 0;
	# fi;

	rank:=RankPGroup(G);
	pclass:=PClassPGroup(G);

	if PClassPGroup(G) = 1 then
		return 0;
	fi;

	#TODO this might not be set for an arbitrarily constructed pgroup
	parent_ID:=GRPS1024_Heritage(G){[1..2]};
	#TODO we can transition away from this using the class_matrix
	Add(parent_ID,NumDescendants(parent_ID[1],parent_ID[2]));
	parents:=GRPS1024_class_matrix[rank][pclass];
	parent_prec:=parents{[1..Position(parents,parent_ID)-1]};

	return Sum(List(parent_prec,x->x[3]));
end;

GRPS1024_A_G:=function(G)
	if PClassPGroup(G)=1 then
		return 1;
	fi;
	return GRPS1024_Heritage(G)[3];
end;

GRPS1024_label_group:=function(G)
	return GRPS1024_A_G(G) + GRPS1024_P_G(G)+ GRPS1024_C_G(G) + GRPS1024_R_G(G);
end;

# check_groups:=function(i)
#   local G, parent, heritage;
	
# 	G:=SmallGroup(1024,i);
# 	parent:=Flat(find_parent(label_group(G)));
# 	Remove(parent,3);
# 	heritage:=GRPS1024_Heritage(G);
# 	if parent = heritage then
# 		# PrintFormatted("There is no issue with # {}\n parent:{} \n heritage:{}\n",i,parent,heritage);
# 		return true;
# 	else
# 		Error(StringFormatted("There is an issue with # {}\n parent:{} \n heritage:{}\n",i,parent,heritage));
# 	fi;
# end;


# GRPS1024_class_totals:=[ [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 ], 
#   [ 0, 0, 1, 1910, 4657, 2069, 439, 40, 5, 0 ], 
#   [ 0, 0, 310313, 388622, 73184, 8390, 189, 9, 0, 0 ], 
#   [ 0, 3566, 6387230, 1611448, 51659, 1090, 14, 0, 0, 0 ], 
#   [ 0, 378628831, 365150189, 1439338, 2972, 18, 0, 0, 0, 0 ]
#     , [ 0, 47698016406, 308373247, 12094, 23, 0, 0, 0, 0, 0 
#      ], [ 0, 726843973, 52356, 27, 0, 0, 0, 0, 0, 0 ], 
#   [ 0, 2933, 32, 0, 0, 0, 0, 0, 0, 0 ], 
#   [ 0, 13, 0, 0, 0, 0, 0, 0, 0, 0 ], 
#   [ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]];


# GRPS1024_returnSmallGroups1024:=function(size,n)
SMALL_GROUP_FUNCS[ pos_2_10 ] := function( size, n, inforec )
  local ancestry, heritage, toReturn, parent;

   if n > inforec.number then 
       Error("there are just ",inforec.number," groups of order ",size );
   fi;

   if n < inforec.number then

	ancestry:=Flat(find_parent(n));
	Remove(ancestry,3);
	#[parent_order,parent_id,age]
	heritage:=rec();
	heritage.Order:=ancestry[1];
	heritage.ID:=ancestry[2];
	heritage.Age:=ancestry[3];
	if find_class(n) = 2 and heritage.Order > 16 then

		toReturn:=ImmediateDescendantGroupShell();
		SetIsPGroup(toReturn,true);

		SetGRPS1024_Heritage(toReturn,[heritage.Order,heritage.ID,heritage.Age]);
		SetPClassPGroup(toReturn,2);
		#TODO this next statement is an artifact of how group shell are programmed
		# SetIsElementaryAbelian(toReturn,false);
		SetRankPGroup(toReturn,find_rank(n));
		SetOrder(toReturn,1024);
		return toReturn;
	fi;
	
#we only ever checkout the descendants of a single group once
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

	SetGRPS1024_Heritage(toReturn,[heritage.Order,heritage.ID,heritage.Age]);
	
	parent:=SmallGroup(heritage.Order,heritage.ID);
	SetPClassPGroup(toReturn,PClassPGroup(parent)+1);
	SetRankPGroup(toReturn,RankPGroup(parent));
	
	return toReturn;

   elif n = 49487367289 then
	toReturn:=ElementaryAbelianGroup(1024);
	SetGRPS1024_Heritage(toReturn,[1,1,1]);

	return toReturn;
   fi;
# toReturn:=PcGroupCode(

end;

#######################################
#SMALL_GROUP_FUNCS[ pos_2_10 ] := function( size, n, inforec )
#  local capableMaster, toRead, offset, order, step, parent_ID, parent_Order, heritage, toReturn, j, group_order, group, i,breakOuter,parent;

#    if n > inforec.number then 
#        Error("there are just ",inforec.number," groups of order ",size );
#    fi;

#    if n < inforec.number then
#	capableMaster:=[];
#	toRead:=StringFormatted("gap/CapableList16_256.g");

#	if ReadPackage("GRPS1024",toRead) then
#		for j in [16,32,64,128,256] do
#			Add(capableMaster,ValueGlobal(StringFormatted("Capable_{}",j)));
#	od;
#	fi;

#	i:=0;
#	offset:=0;
#	order:=8;
#	step:=0;
#	heritage:=rec();
#	breakOuter:=false;
#	for group_order in capableMaster do
#		order:=order*2;
#		step:=Length(FactorsInt(1024)) - Length(FactorsInt(order));
#		for group in group_order do
#			offset:=i;
#			i:=i+group[2];

#			#the first time that i is greater than our number we have found our parent id
#			if i >= n then
#				#
#				#n-offset is the position in the ordered list of descendants
#				#we are looking for i.e. the age of the nth group among its
#				#siblings
#				#desc:=PqDescendants(SmallGroup(order,group[1]):StepSize:=step);
#				#the elementary abelian groups are always the last ones
#				# so this just quickly gives us the right small group id
#				heritage.ID:=group[1];
#				heritage.Order:=order;
#				heritage.Age:=n-offset;

#				if order > 16 and NumberSmallGroups(order)=group[1] then
#					# toReturn:=ImmediateDescendantGroupShell(ElementaryAbelianGroup(order));
#					toReturn:=ImmediateDescendantGroupShell();
#					SetIsPGroup(toReturn,true);

#					SetGRPS1024_Heritage(toReturn,[heritage.Order,heritage.ID,heritage.Age]);
#					SetPClassPGroup(toReturn,2);
#					#TODO this next statement is an artifact of how group shell are programmed
#					# SetIsElementaryAbelian(toReturn,false);
#					SetRankPGroup(toReturn,RankPGroup(ElementaryAbelianGroup(order)));
#					SetOrder(toReturn,1024);
#					return toReturn;
#				fi;

#				if not IsBound(SMALL_GROUP_LIB[1024]) then
#					SMALL_GROUP_LIB[1024]:=[];
#				fi;

#				if not IsBound(SMALL_GROUP_LIB[1024][heritage.Order]) then
#					SMALL_GROUP_LIB[1024][heritage.Order]:=[];
#				fi;

#				if not IsBound(SMALL_GROUP_LIB[1024][heritage.Order][heritage.ID]) then
#					SMALL_GROUP_LIB[1024][heritage.Order][heritage.ID]:=CheckoutDescendants(heritage.Order,heritage.ID);
#				fi;

#				toReturn:=PcGroupCode(SMALL_GROUP_LIB[1024][heritage.Order][heritage.ID][heritage.Age],size);

#				SetGRPS1024_Heritage(toReturn,[heritage.Order,heritage.ID,heritage.Age]);
				
#				parent:=SmallGroup(heritage.Order,heritage.ID);
#				SetPClassPGroup(toReturn,PClassPGroup(parent)+1);
#				SetRankPGroup(toReturn,RankPGroup(parent));
				
#				return toReturn ;
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

#				if NumberSmallGroups(order)=group[1] then
#					# toReturn:=ImmediateDescendantGroupShell(ElementaryAbelianGroup(order));
#				toReturn:=ImmediateDescendantGroupShell();
#				SetIsPGroup(toReturn,true);

#				SetGRPS1024_Heritage(toReturn,[heritage.Order,heritage.ID,heritage.Age]);
#				SetPClassPGroup(toReturn,2);
#				SetRankPGroup(toReturn,RankPGroup(ElementaryAbelianGroup(order)));
#				SetOrder(toReturn,1024);

#				return toReturn;
#				fi;

#				if not IsBound(SMALL_GROUP_LIB[1024]) then
#					SMALL_GROUP_LIB[1024]:=[];
#				fi;

#				if not IsBound(SMALL_GROUP_LIB[1024][heritage.Order]) then
#					SMALL_GROUP_LIB[1024][heritage.Order]:=[];
#				fi;

#				if not IsBound(SMALL_GROUP_LIB[1024][heritage.Order][heritage.ID]) then
#					SMALL_GROUP_LIB[1024][heritage.Order][heritage.ID]:=CheckoutDescendants(heritage.Order,heritage.ID);
#				fi;

#				toReturn:=PcGroupCode(SMALL_GROUP_LIB[1024][heritage.Order][heritage.ID][heritage.Age],size);
#				SetGRPS1024_Heritage(toReturn,[heritage.Order,heritage.ID,heritage.Age]);
#				parent:=SmallGroup(heritage.Order,heritage.ID);
#				SetPClassPGroup(toReturn,PClassPGroup(parent)+1);
#				SetRankPGroup(toReturn,RankPGroup(parent));

#				return toReturn ;
#			else
#				continue;
#			fi;
#		od;


#	elif n = 49487367289 then
#		toReturn:=ElementaryAbelianGroup(1024);
#		SetGRPS1024_Heritage(toReturn,[1,1,1]);

#		return toReturn;
#	fi;
#end;

# Method for selecting a subset of the groups which have a given list of properties, i.e. IsAbelian, IsNilpotent
SELECT_SMALL_GROUPS_FUNCS[ pos_2_10 ] := SELECT_SMALL_GROUPS_FUNCS[ 11 ];


# Method for SmallGroupsInformation(size):
# Inorder for this method to work lines 31-34 pkg/SmallGrp-1.5/gap/smlinfo.gi need to commented out
#
SMALL_GROUPS_INFORMATION[ pos_2_10 ] := function( size, inforec, num )

AvailableGroups1024Information();
# Groups1024Information();

end;
