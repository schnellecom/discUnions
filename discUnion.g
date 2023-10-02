LoadPackage("GAPic");

blueHex:= "0x049EF4";
redHex := "0xb22222";
greenHex := "0x32cd32";

blueTex:= "049EF4";
redTex := "b22222";
greenTex := "32cd32";

# construct disc 1
d1:=SimplicialSurfaceByUmbrellaDescriptor([(1,2,3,4,5,6),[1,2],[2,3,7],(7,3,4,8),[8,4,5],[5,6],[6,1],[7,8]]);

# construct disc 2 from 1 with shift in vertices and edges
voe1:=VerticesOfEdges(d1);
voe2:=[];

for i in [1..NumberOfEdges(d1)] do
	voe2[i+NumberOfEdges(d1)] := voe1[i]+NumberOfVertices(d1);
od;

eof1:=EdgesOfFaces(d1);
#eof2:=[];
#for i in [1..NumberOfFaces(d1)] do
#	eof2[i+NumberOfFaces(d1)] := eof1[i]+NumberOfEdges(d1);
#od;

d2:=SimplicialSurfaceByDownwardIncidence(voe2, eof1+NumberOfEdges(d1));

# construct boundary of disc 2
boundary2:=[];
e := BoundaryEdges(d2)[1];
v := VerticesOfEdge(d2, e)[1];
Add(boundary2, e);

for i in [1..Size(BoundaryEdges(d2))-1] do
	if VerticesOfEdge(d2, e)[1] = v then
		v:=VerticesOfEdge(d2, e)[2];
	else
		v:=VerticesOfEdge(d2, e)[1];
	fi;
	b:=Intersection(EdgesOfVertex(d2, v), BoundaryEdges(d2));
	if b[1] in boundary2 then
		Add(boundary2, b[2]);
		e:=b[2];
	else
		Add(boundary2, b[1]);
		e:=b[1];
	fi;
od;

# construct all unions by shifting the boundary of disc 1 and joining along it with boundary of disc 2
discUnions:=[];

for start in [1..Size(BoundaryEdges(d1))] do
	boundary1:=[];
	e := BoundaryEdges(d1)[start];
	v := VerticesOfEdge(d1, e)[1];
	Add(boundary1, e);

	for i in [1..Size(BoundaryEdges(d1))-1] do
		if VerticesOfEdge(d1, e)[1] = v then
			v:=VerticesOfEdge(d1, e)[2];
		else
			v:=VerticesOfEdge(d1, e)[1];
		fi;
		b:=Intersection(EdgesOfVertex(d1, v), BoundaryEdges(d1));
		if b[1] in boundary1 then
			Add(boundary1, b[2]);
			e:=b[2];
		else
			Add(boundary1, b[1]);
			e:=b[1];
		fi;
	od;

	s:=JoinVertexEdgePaths(d1, VertexEdgePathByEdges(d1, boundary1), d2, VertexEdgePathByEdges(d2, boundary2))[1];
	Add(discUnions, s);

	# add boundary in the other direction
	boundary3:=[];
	e := BoundaryEdges(d1)[start];
	v := VerticesOfEdge(d1, e)[2];

	for i in [1..Size(BoundaryEdges(d1))-1] do
		if VerticesOfEdge(d1, e)[1] = v then
			v:=VerticesOfEdge(d1, e)[2];
		else
			v:=VerticesOfEdge(d1, e)[1];
		fi;
		b:=Intersection(EdgesOfVertex(d1, v), BoundaryEdges(d1));
		if b[1] in boundary3 then
			Add(boundary3, b[2]);
			e:=b[2];
		else
			Add(boundary3, b[1]);
			e:=b[1];
		fi;
	od;

	s:=JoinVertexEdgePaths(d1, VertexEdgePathByEdges(d1, boundary1), d2, VertexEdgePathByEdges(d2, boundary2))[1];
	Add(discUnions, s);
od;

# filter for isomorphic surfaces
uniqueDiscs:=[];
for a in [1..Size(discUnions)] do
	# check if considered disc should be added
	add:=true;
	for b in [1..Size(uniqueDiscs)] do
		if IsIsomorphic(discUnions[a], uniqueDiscs[b]) then
			add:=false;
		fi;
	od;
	if add then
		Add(uniqueDiscs, discUnions[a]);
	fi;
od;

# coordinates from the cooresponding maple file
u1coords:=[[0.0000000000, 0.0000000000, 0.0000000000], , , [-0.4127756193, -0.8824799136, -0.2254894815], , , , , , , , , , , , , , , , , , , , [0.5335064560, 0.3080200970, -0.8291607010], , , [0.4258038840, -0.3983258119, -1.5287860240], , , , , [1.0000000000, 0.0000000000, 0.0000000000], [0.5000000000, 0.8660254040, 0.0000000000], [-0.3181013101, 0.7610061464, -0.5654035731], [-0.3385795027, -0.1718327869, -0.9251148060], [-0.1525365230, -1.1259251930, -1.1598395400], [0.5000000000, -0.6559868889, -0.5654035731]];

pr1t := rec(faceColours:=[], edgeColours:=[]);
pr1:=SetVertexCoordinates3DNC(uniqueDiscs[1], u1coords, rec());

# set colour for one disc different
for i in Faces(uniqueDiscs[1]) do
	if i in Faces(d1) then
		SetFaceColour(uniqueDiscs[1], i, redHex, pr1);
		pr1t.faceColours[i] := redTex;
	else
		pr1t.faceColours[i] := blueTex;
	fi;
od;



# set colour for boundary where discs are glued to red
for i in Edges(uniqueDiscs[1]) do
	if IsBound(FacesOfEdges(uniqueDiscs[1])[i]) then
		e := FacesOfEdges(uniqueDiscs[1])[i];
		if e[1] in Faces(d1) and not e[2] in Faces(d1) then
			SetEdgeColour(uniqueDiscs[1], Position(Edges(uniqueDiscs[1]), i), greenHex, pr1);
			pr1t.edgeColours[i] := greenTex;
		fi;
		if e[2] in Faces(d1) and not e[1] in Faces(d1) then
			SetEdgeColour(uniqueDiscs[1], Position(Edges(uniqueDiscs[1]), i), greenHex, pr1);
			pr1t.edgeColours[i] := greenTex;
		fi;
	fi;
od;

#DrawSurfaceToTikz(uniqueDiscs[1], "u1", pr1t);
DrawComplexToJavaScript(uniqueDiscs[1], "u1", pr1);


u2coords:=[[1.5000000000, 0.2886751347, 0.8164965809], , , [1.5000000000, 0.8660254040, 0.0000000000], , , , , , , , , , , , , , , , , , , , [0.5000000000, 0.2886751347, 0.8164965809], , , [0.5000000000, -0.6735753142, 0.5443310539], , , , , [1.0000000000, 0.5773502693, 1.6329931620], [1.0000000000, 1.1547005390, 0.8164965809], [0.5000000000, 0.8660254040, 0.0000000000], [1.0000000000, 0.0000000000, 0.0000000000], [1.5000000000, -0.6735753142, 0.5443310539], [1.0000000000, -0.3849001795, 1.3608276350]];

pr2t := rec(faceColours:=[], edgeColours:=[]);
pr2:=SetVertexCoordinates3DNC(uniqueDiscs[2], u2coords, rec());

# set colour for one disc different
for i in Faces(uniqueDiscs[2]) do
	if i in Faces(d1) then
		SetFaceColour(uniqueDiscs[2], i, redHex, pr2);
		pr2t.faceColours[i] := redTex;
	else
		pr2t.faceColours[i] := blueTex;
	fi;
od;



# set colour for boundary where discs are glued to red
for i in Edges(uniqueDiscs[2]) do
	if IsBound(FacesOfEdges(uniqueDiscs[2])[i]) then
		e := FacesOfEdges(uniqueDiscs[2])[i];
		if e[1] in Faces(d1) and not e[2] in Faces(d1) then
			SetEdgeColour(uniqueDiscs[2], Position(Edges(uniqueDiscs[2]), i), greenHex, pr2);
			pr2t.edgeColours[i] := greenTex;
		fi;
		if e[2] in Faces(d1) and not e[1] in Faces(d1) then
			SetEdgeColour(uniqueDiscs[2], Position(Edges(uniqueDiscs[2]), i), greenHex, pr2);
			pr2t.edgeColours[i] := greenTex;
		fi;
	fi;
od;

#DrawSurfaceToTikz(uniqueDiscs[2], "u2", pr2t);
DrawComplexToJavaScript(uniqueDiscs[2], "u2", pr2);


u3coords:=
[[-0.340167989953885, -0.18875986096352596, -0.4135505049022585], , , [-0.98378394025672, 0.23026010190925314, 0.3331907999369216], , , , , , , , , , , , , , , , , , , , [0.5223075691127572, 0.21295777910129174, -0.06490214703270053], , , [0.521939749180131, -0.291618047680444, 0.8800034136456166], , , , , [-0.3382441116596833, 0.7102719506064715, -0.1961914321035465], [0.1772321281642495, 0.4494636529487852, -1.0], [0.546131672184148, -0.35336177043422035, -0.9001688710429676], [0.4068186676088921, -0.7011612558906501, 0.016058737953748136], [-0.3649338270066662, -0.46881577579001865, 0.609365285280877], [-0.14729991737322376, 0.40076322619305677, 0.7361947182643103]];


pr3t := rec(faceColours:=[], edgeColours:=[]);
pr3:=SetVertexCoordinates3DNC(uniqueDiscs[3], u3coords, rec());

# set colour for one disc different
for i in Faces(uniqueDiscs[3]) do
	if i in Faces(d1) then
		SetFaceColour(uniqueDiscs[3], i, redHex, pr3);
		pr3t.faceColours[i] := redTex;
	else
		pr3t.faceColours[i] := blueTex;
	fi;
od;



# set colour for boundary where discs are glued to red
for i in Edges(uniqueDiscs[3]) do
	if IsBound(FacesOfEdges(uniqueDiscs[3])[i]) then
		e := FacesOfEdges(uniqueDiscs[3])[i];
		if e[1] in Faces(d1) and not e[2] in Faces(d1) then
			SetEdgeColour(uniqueDiscs[3], Position(Edges(uniqueDiscs[3]), i), greenHex, pr3);
			pr3t.edgeColours[i] := greenTex;
		fi;
		if e[2] in Faces(d1) and not e[1] in Faces(d1) then
			SetEdgeColour(uniqueDiscs[3], Position(Edges(uniqueDiscs[3]), i), greenHex, pr3);
			pr3t.edgeColours[i] := greenTex;
		fi;
	fi;
od;

#DrawSurfaceToTikz(uniqueDiscs[3], "u3", pr3t);
DrawComplexToJavaScript(uniqueDiscs[3], "u3", pr3);



u4coords:=[[1.5000000000, 0.8660254040, 0.0000000000], , , [0.5000000000, 0.8660254040, 0.0000000000], , , , , , , , , , , , , , , , , , , , [1.5000000000, 0.2886751347, 0.8164965809], , , [2.5000000000, 0.2886751347, 0.8164965809], , , , , [1.0000000000, 1.1547005390, 0.8164965809], [0.5000000000, 0.2886751347, 0.8164965809], [1.0000000000, 0.0000000000, 0.0000000000], [2.0000000000, 0.0000000000, 0.0000000000], [2.5000000000, 0.8660254040, 0.0000000000], [2.0000000000, 1.1547005390, 0.8164965809]];

pr4t := rec(faceColours:=[], edgeColours:=[]);
pr4:=SetVertexCoordinates3DNC(uniqueDiscs[4], u4coords, rec());

# set colour for one disc different
for i in Faces(uniqueDiscs[4]) do
	if i in Faces(d1) then
		SetFaceColour(uniqueDiscs[4], i, redHex, pr4);
		pr4t.faceColours[i] := redTex;
	else
		pr4t.faceColours[i] := blueTex;
	fi;
od;



# set colour for boundary where discs are glued to red
for i in Edges(uniqueDiscs[4]) do
	if IsBound(FacesOfEdges(uniqueDiscs[4])[i]) then
		e := FacesOfEdges(uniqueDiscs[4])[i];
		if e[1] in Faces(d1) and not e[2] in Faces(d1) then
			SetEdgeColour(uniqueDiscs[4], Position(Edges(uniqueDiscs[4]), i), greenHex, pr4);
			pr4t.edgeColours[i] := greenTex;
		fi;
		if e[2] in Faces(d1) and not e[1] in Faces(d1) then
			SetEdgeColour(uniqueDiscs[4], Position(Edges(uniqueDiscs[4]), i), greenHex, pr4);
			pr4t.edgeColours[i] := greenTex;
		fi;
	fi;
od;

#DrawSurfaceToTikz(uniqueDiscs[4], "u4", pr4t);
DrawComplexToJavaScript(uniqueDiscs[4], "u4", pr4);