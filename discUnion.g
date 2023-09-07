LoadPackage("GAPic");

# construct disc 1
d1:=SimplicialSurfaceByUmbrellaDescriptor([(1,2,3,4,5,6),[1,2],[2,3,7],(7,3,4,8),[8,4,5],[5,6],[6,1],[7,8]]);

# construct disc 2 from 1 with shift in vertices and edges
voe1:=VerticesOfEdges(d1);
voe2:=[];

for i in [1..NumberOfEdges(d1)] do
	voe2[i+NumberOfEdges(d1)] := voe1[i]+NumberOfVertices(d1);
od;

d2:=SimplicialSurfaceByDownwardIncidence(voe2, EdgesOfFaces(d1)+NumberOfEdges(d1));

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
u1coords:=[[0.0000000000, 0.0000000000, 0.0000000000], [], [], [-0.4127756193, -0.8824799136, -0.2254894815], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [0.5335064560, 0.3080200970, -0.8291607010], [], [], [0.4258038840, -0.3983258119, -1.5287860240], [], [], [], [], [1.0000000000, 0.0000000000, 0.0000000000], [0.5000000000, 0.8660254040, 0.0000000000], [-0.3181013101, 0.7610061464, -0.5654035731], [-0.3385795027, -0.1718327869, -0.9251148060], [-0.1525365230, -1.1259251930, -1.1598395400], [0.5000000000, -0.6559868889, -0.5654035731]];

pr1:=SetVertexCoordinates3D(uniqueDiscs[1], u1coords);

# set colour for one disc different
for i in [1..NumberOfFaces(d1)] do
	SetFaceColour(uniqueDiscs[1], i, "0x32cd32", pr);
od;

DrawComplexToJavaScript(uniqueDiscs[1], "u1", pr1);


u2coords:=[[1.5000000000, 0.2886751347, 0.8164965809], [], [], [1.5000000000, 0.8660254040, 0.0000000000], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [0.5000000000, 0.2886751347, 0.8164965809], [], [], [0.5000000000, -0.6735753142, 0.5443310539], [], [], [], [], [1.0000000000, 0.5773502693, 1.6329931620], [1.0000000000, 1.1547005390, 0.8164965809], [0.5000000000, 0.8660254040, 0.0000000000], [1.0000000000, 0.0000000000, 0.0000000000], [1.5000000000, -0.6735753142, 0.5443310539], [1.0000000000, -0.3849001795, 1.3608276350]];

pr2:=SetVertexCoordinates3D(uniqueDiscs[2], u2coords);

# set colour for one disc different
for i in [1..NumberOfFaces(d1)] do
	SetFaceColour(uniqueDiscs[2], i, "0x32cd32", pr2);
od;

DrawComplexToJavaScript(uniqueDiscs[2], "u2", pr2);