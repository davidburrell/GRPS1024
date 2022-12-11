LoadPackage("GRPS1024");
#Capable_16
#Capable_32
#Capable_64
#Capable_128
#Capable_256
#Capable_512

class_matrix:=[];

for i in [1..10] do
	class_matrix[i]:=[[],[],[],[],[],[],[],[],[],[]];
od;
# orders:=[16,32,64,128,256,512];
orders:=[16,32,64,128,256,512];
capable_master:=[];
for order in orders do
	#entries in Capable_{} are [id,num desc]
	for capable_group in ValueGlobal(StringFormatted("Capable_{}",order)) do

		PrintFormatted("Working on group {}#{}\n",order,capable_group[1]);
		working:=SmallGroup(order,capable_group[1]);
		row:=PClassPGroup(working);
		col:=RankPGroup(working);
		triple:=[order];
		Append(triple,capable_group);

	        Add(class_matrix[row][col],triple);

		# ranks[row
		# Print(capable_group,"\n");
od;
od;
# Print(class_matrix);
PrintTo("class_matrix.g",StringFormatted("class_matrix:={};",class_matrix));
	
