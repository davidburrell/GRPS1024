getParentId:=function(G)
local pSeries,pClass,parent;

pSeries:=PCentralSeries(G);
pClass:=PClassPGroup(G);
parent:=IdSmallGroup(FactorGroup(G,pSeries[pClass]));

return parent;
end;

getParentIds:=function(L)
return List(L,x->getParentId(SmallGroup(512,x)));
end;

checkRankClassOrder:=function(order,rank,class)
local grps;
grps:=AllSmallGroups(order,RankPGroup,rank,PClassPGroup,class);
return List(grps,x->getParentId(x));
end;

checkRankClassOrderPairs:=function(order,pairs)
local pair;
for pair in pairs do
     if	IsSortedList(checkRankClassOrder(order,pair[1],pair[2])) then
	Print(StringFormatted("#Groups of order {} with rank {} and p-class {} are ordered correctly\n",order,pair[1],pair[2]));
     else
	Print(StringFormatted("####Groups of order {} with rank {} and p-class {} are not ordered correctly###\n",order,pair[1],pair[2]));
     fi;
od;

end;

CheckGroupsOfOrder:=function(order)
local pairs;

pairs:=PrintClassificationTable(order);
checkRankClassOrderPairs(order,pairs);

end;
#16
#Groups 1-1 have rank 1 and pclass 4
#Groups 2-4 have rank 2 and pclass 2

#Groups 5-9 have rank 2 and pclass 3

#Groups 10-13 have rank 3 and pclass 2

#Groups 14-14 have rank 4 and pclass 1

#these groups all follow the ordering

#32
#Groups 1-1 have rank 1 and pclass 5
#Groups 2-2 have rank 2 and pclass 2
#Groups 3-15 have rank 2 and pclass 3
#Groups 16-20 have rank 2 and pclass 4
#Groups 21-35 have rank 3 and pclass 2
#Groups 36-44 have rank 3 and pclass 3
#Groups 45-50 have rank 4 and pclass 2
#Groups 51-51 have rank 5 and pclass 1

#these groups all follow the ordering

#64
##Groups 1-1 have rank 1 and pclass 6
#Groups 2-25 have rank 2 and pclass 3
#Groups 26-49 have rank 2 and pclass 4
#Groups 50-54 have rank 2 and pclass 5
#Groups 55-82 have rank 3 and pclass 2
#Groups 83-182 have rank 3 and pclass 3
#Groups 183-191 have rank 3 and pclass 4
#Groups 192-245 have rank 4 and pclass 2
#Groups 246-259 have rank 4 and pclass 3
#Groups 260-266 have rank 5 and pclass 2
#Groups 267-267 have rank 6 and pclass 1

#128
# Groups 1-1 have rank 1 and pclass 7
# Groups 2-41 have rank 2 and pclass 3
# Groups 42-127 have rank 2 and pclass 4
# Groups 128-158 have rank 2 and pclass 5
# Groups 159-163 have rank 2 and pclass 6
# Groups 164-178 have rank 3 and pclass 2
# Groups 179-836 have rank 3 and pclass 3
# Groups 837-987 have rank 3 and pclass 4
# Groups 988-996 have rank 3 and pclass 5
# Groups 997-1600 have rank 4 and pclass 2
# Groups 1601-2135 have rank 4 and pclass 3
# Groups 2136-2149 have rank 4 and pclass 4
# Groups 2150-2300 have rank 5 and pclass 2
# Groups 2301-2318 have rank 5 and pclass 3
# Groups 2319-2327 have rank 6 and pclass 2
# Groups 2328-2328 have rank 7 and pclass 1

#256
# Groups 1-1 have rank 1 and pclass 8
# Groups 2-38 have rank 2 and pclass 3
# Groups 39-315 have rank 2 and pclass 4
# Groups 316-496 have rank 2 and pclass 5
# Groups 497-536 have rank 2 and pclass 6
# Groups 537-541 have rank 2 and pclass 7
# Groups 542-545 have rank 3 and pclass 2
# Groups 546-4383 have rank 3 and pclass 3
# Groups 4384-6533 have rank 3 and pclass 4
# Groups 6534-6722 have rank 3 and pclass 5
# Groups 6723-6731 have rank 3 and pclass 6
# Groups 6732-10297 have rank 4 and pclass 2
# Groups 10298-26307 have rank 4 and pclass 3
# Groups 26308-26958 have rank 4 and pclass 4
# Groups 26959-26972 have rank 4 and pclass 5
# Groups 26973-53037 have rank 5 and pclass 2
# Groups 53038-55607 have rank 5 and pclass 3
# Groups 55608-55625 have rank 5 and pclass 4
# Groups 55626-56058 have rank 6 and pclass 2
# Groups 56059-56081 have rank 6 and pclass 3
# Groups 56082-56091 have rank 7 and pclass 2
# Groups 56092-56092 have rank 8 and pclass 1

#512
#Groups 1-1 have rank 1 and pclass 9
#Groups 2-10 have rank 2 and pclass 3
#Groups 11-386 have rank 2 and pclass 4
#Groups 387-444 have rank 2 and pclass 5
#Groups 445-858 have rank 2 and pclass 4
#Groups 859-1698 have rank 2 and pclass 5
#Groups 1699-2008 have rank 2 and pclass 6
#Groups 2009-2039 have rank 2 and pclass 7
#Groups 2040-2044 have rank 2 and pclass 8
#Groups 2045-2045 have rank 3 and pclass 2
#Groups 2046-29398 have rank 3 and pclass 3
#Groups 29399-30617 have rank 3 and pclass 4
#Groups 30618-31239 have rank 3 and pclass 3
#Groups 31240-56685 have rank 3 and pclass 4
#Groups 56686-60615 have rank 3 and pclass 5
#Groups 60616-60894 have rank 3 and pclass 6
#Groups 60895-60903 have rank 3 and pclass 7
#Groups 60904-67612 have rank 4 and pclass 2
#Groups 67613-387088 have rank 4 and pclass 3
#Groups 387089-419734 have rank 4 and pclass 4
#Groups 419735-420500 have rank 4 and pclass 5
#Groups 420501-420514 have rank 4 and pclass 6
#Groups 420515-6249623 have rank 5 and pclass 2
#Groups 6249624-7529606 have rank 5 and pclass 3
#Groups 7529607-7532374 have rank 5 and pclass 4
#Groups 7532375-7532392 have rank 5 and pclass 5
#Groups 7532393-10481221 have rank 6 and pclass 2
#Groups 10481222-10493038 have rank 6 and pclass 3
#Groups 10493039-10493061 have rank 6 and pclass 4
#Groups 10493062-10494173 have rank 7 and pclass 2
#Groups 10494174-10494200 have rank 7 and pclass 3
#Groups 10494201-10494212 have rank 8 and pclass 2
#Groups 10494213-10494213 have rank 9 and pclass 1

gps_1_9:=[1];# have rank 1 and pclass 9
gps_2_3:=[2..10];# have rank 2 and pclass 3
gps_2_4_1:=[11..386];# have rank 2 and pclass 4
gps_2_5_1:=[387..444];# 2 and pclass 5
gps_2_4_2:=[445..858];# 2 and pclass 4
gps_2_5_2:=[859..1698];# 2 and pclass 5
gps_2_6:=[1699..2008];# 2 and pclass 6
gps_2_7:=[2009..2039];# 2 and pclass 7
gps_2_8:=[2040..2044];# 2 and pclass 8
gps_3_2:=[2045..2045];# 3 and pclass 2
gps_3_3_1:=[2046..29398];# 3 and pclass 3
gps_3_4_1:=[29399..30617];# 3 and pclass 4
gps_3_3_2:=[30618..31239];# 3 and pclass 3
gps_3_4_2:=[31240..56685];# 3 and pclass 4
gps_3_5:=[56686..60615];# 3 and pclass 5
gps_3_6:=[60616..60894];# 3 and pclass 6
gps_3_7:=[60895..60903];# 3 and pclass 7
gps_4_2:=[60904..67612];# 4 and pclass 2
gps_4_3:=[67613..387088];# 4 and pclass 3
gps_4_4:=[387089..419734];# 4 and pclass 4
gps_4_5:=[419735..420500];# 4 and pclass 5
gps_4_6:=[420501..420514];# 4 and pclass 6
gps_5_2:=[420515..6249623];# 5 and pclass 2
gps_5_3:=[6249624..7529606];# 5 and pclass 3
gps_5_4:=[7529607..7532374];# 5 and pclass 4
gps_5_5:=[7532375..7532392];# 5 and pclass 5
gps_6_2:=[7532393..10481221];# 6 and pclass 2
gps_6_3:=[10481222..10493038];# 6 and pclass 3
gps_6_4:=[10493039..10493061];# 6 and pclass 4
gps_7_2:=[10493062..10494173];# 7 and pclass 2
gps_7_3:=[10494174..10494200];# 7 and pclass 3
gps_8_2:=[10494201..10494212];# 8 and pclass 2
gps_9_1:=[10494213..10494213];# 9 and pclass 1
