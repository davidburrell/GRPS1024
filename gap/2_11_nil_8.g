# 2009 - 2039 have rank 2 and p-class 7.
# 2040 - 2044 have rank 2 and p-class 8.
# 60895 - 60903 have rank 3 and p-class 7.
LoadPackage("GRPS1024");
r2_7:=[39144345..39144783]; #      have rank 2 and pclass 7
total_1:=774;
# working:=[];
# working_group:=[];
		
			
#Print(StringFormatted("Total rank 2 and pclass 8 with nilpotency class 8: {}\n",total_1));

#r2_8:=[39144784..39144823];  #     have rank 2 and pclass 8

#total_2:=0;


#r2_9:=[39144824..39144828];   #    have rank 2 and pclass 9
##
#total_3:=0;

r3_7:=[39557924..39558112]; #      have rank 3 and pclass 7

#total_4:=249;


#Print(StringFormatted("Total rank 3 and pclass 8 with nilpotency class 8: {}\n",total_4));

#r3_8:=[39558113..39558121];  #     have rank 3 and pclass 8

#total_5:=0;


r4_7:=[41898680..41898693];   #    have rank 4 and pclass 7

#total_6:=8;
#working:=[];
#working_group:=0;
#toTest:=[];

toReturn:=[];
for g in r4_7 do;
	Print(StringFormatted("Working on {}\n",g));
	working_group:=SmallGroup(1024,AvailableMap(g));
		if IsCapable(working_group) then
			working:=Filtered(PqDescendants(working_group:StepSize:=1),x->NilpotencyClassOfGroup(x)>7);
				# diff:=Length(DuplicateFreeList(List(working,DerivedLength)));
				# if  diff >= 2 then
				# 	Print(StringFormatted("Group # {} needs to be checked it has diff = {} \n",g,diff));
				# fi;
			if Length(working)>0 then
				Add(toReturn,working);
			fi;
		fi;
od;
toReturn:=Flat(toReturn);
Print("\n##################All Done check working_group######################\n");

#for g in r4_7 do

#Print(StringFormatted("Working on group {}\n",g));
#	working_group:=SmallGroup(1024,AvailableMap(g));
#	if IsCapable(working_group) then
#		working:=PqDescendants(working_group:StepSize:=1);
#		for group in working do
#			if NilpotencyClassOfGroup(group) = 8 then
#				total_6 := total_6 + 1;
#			fi;
#		od;
#	fi;
#od;

#Print(StringFormatted("Total rank 4 and pclass 8 with nilpotency class 8: {}\n",total_6));

