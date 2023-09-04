# construct disc 1
d1:=SimplicialSurfaceByUmbrellaDescriptor([(1,2,3,4,5,6),[1,2],[2,3,7],[7,3,4,8],[8,4,5],[5,6],[6,1],[7],[8]]);

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

