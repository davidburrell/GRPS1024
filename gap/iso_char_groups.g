LoadPackage("PGROUPUTILS");


CreateCharacterTableGraphFromGroup:=function(G)
return CreateCharacterTableGraph(CharacterTable(G));
end;

ReturnCanonicalCharacterTableRepFromGroup:=function(G)
local ctbl;
ctbl:=CreateCharacterTableGraphFromGroup(G);
return ReturnCanonicalRepWithColor(ctbl[1],ctbl[2],ctbl[3]);
end;

CharacterGraphRepConstructorFromGroup:=function(G)
local working;
working:=ReturnCanonicalCharacterTableRepFromGroup(G);
return CharacterGraphRepConstructor(working[1],working[2],working[3]);
end;

identify_isomorphic_character_tables_list_groups:=function(L)
local r_1,dict,group,working,val,keys,rep;

keys:=[];

r_1:=CharacterGraphRepConstructorFromGroup(L[1]);
dict:=NewDictionary(r_1,true);
for group in L do
	working:=CharacterGraphRepConstructorFromGroup(group);
	
	if KnowsDictionary(dict,working) then
		val:=LookupDictionary(dict,working);

		if IsList(val[2]) then
			Add(val[2],group);
		else
			val[2]:=[val[2],group];
		fi;
	else
		AddDictionary(dict,working,[working,[group]]);
		Add(keys,working);
	fi;
od;

return rec(groups:=L,keys:=keys,dict:=dict);

end;


