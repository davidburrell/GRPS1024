gap> PrintClassificationTable(1,2,4);
-0 have rank 0 and pclass 0
Groups 1-1 have rank 1 and pclass 2
Groups 2-2 have rank 2 and pclass 1
gap> PrintClassificationTable(1,5,8);
-0 have rank 0 and pclass 0
Groups 1-1 have rank 1 and pclass 3
Groups 2-4 have rank 2 and pclass 2
Groups 5-5 have rank 3 and pclass 1
gap> PrintClassificationTable(1,NumberSmallGroups(16),16);
-0 have rank 0 and pclass 0
Groups 1-1 have rank 1 and pclass 4
Groups 2-4 have rank 2 and pclass 2
Groups 5-9 have rank 2 and pclass 3
Groups 10-13 have rank 3 and pclass 2
Groups 14-14 have rank 4 and pclass 1
gap> List(List([2..4],x->SmallGroup(8,x)),x->CodePcGroup(x));
[ 33, 36, 2343 ]
gap> ## shows that the groups of order 8 are ordered as we expect
gap> List(List([2..4],x->SmallGroup(16,x)),x->CodePcGroup(x));
[ 9219, 16905, 279051 ]
gap> List(List([5..9],x->SmallGroup(16,x)),x->CodePcGroup(x));
[ 9221, 140301, 2245212, 35922525, 574759519 ]
gap> List(List([10..13],x->SmallGroup(16,x)),x->CodePcGroup(x));
[ 513, 520, 139787, 8716 ]
gap> ## this is the first instance we find that the groups do not have their ids ordered by standard pc codes
gap> g:=SmallGroup(8,3);
<pc group of size 8 with 3 generators>
gap> PCentralSeries(g)[-1];
Error, no method found! For debugging hints type ?Recovery from NoMethodFound
Error, no 1st choice method found for `[]' on 2 arguments at /home/david/gap/lib/methsel2.g:249 called from
<function "HANDLE_METHOD_NOT_FOUND">( <arguments> )
 called from read-eval loop at *stdin*:12
type 'quit;' to quit to outer loop
brk> quit;
gap> pc:=PCentralSeries(g);
[ <pc group of size 8 with 3 generators>, Group([ f3 ]), Group([  ]) ]
gap> Length(pc);
3
gap> pc[2];
Group([ f3 ])
gap> PClassPGroup(g);
2
gap> FactorGroup(g,pc[2]);
Group([ f1, f2, <identity> of ... ])
gap> IdSmallGroup(last);
[ 4, 2 ]
gap> quit;
