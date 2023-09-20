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

pr1:=SetVertexCoordinates3DNC(uniqueDiscs[1], u1coords, rec());

# set colour for one disc different
for i in [1..NumberOfFaces(d1)] do
	SetFaceColour(uniqueDiscs[1], i, "0x32cd32", pr1);
od;

DrawComplexToJavaScript(uniqueDiscs[1], "u1", pr1);


u2coords:=[[1.5000000000, 0.2886751347, 0.8164965809], [], [], [1.5000000000, 0.8660254040, 0.0000000000], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [0.5000000000, 0.2886751347, 0.8164965809], [], [], [0.5000000000, -0.6735753142, 0.5443310539], [], [], [], [], [1.0000000000, 0.5773502693, 1.6329931620], [1.0000000000, 1.1547005390, 0.8164965809], [0.5000000000, 0.8660254040, 0.0000000000], [1.0000000000, 0.0000000000, 0.0000000000], [1.5000000000, -0.6735753142, 0.5443310539], [1.0000000000, -0.3849001795, 1.3608276350]];

pr2:=SetVertexCoordinates3DNC(uniqueDiscs[2], u2coords, rec());

# set colour for one disc different
for i in [1..NumberOfFaces(d1)] do
	SetFaceColour(uniqueDiscs[2], i, "0x32cd32", pr2);
od;

DrawComplexToJavaScript(uniqueDiscs[2], "u2", pr2);

#u3coords:=
[[0.24681190488715551, 1.0011617571557831, 0.008106974215300865], [], [], [0.07410355015111654, 0.5973883928097667, 0.7199415627472416], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [0.7150183763296116, 0.9593389837937879, 0.38854901400013364], [], [], [0.13438568615394872, 0.2061796678625375, 0.7967774765453387], [], [], [], [], [0.06659592316788845, 0.295059605925087, 0.6890529365554058], [0.9298544207627035, 0.40475504485944824, 0.6474928145163782], [0.09219953077102808, 0.6768223016502779, 0.7569724559808317], [0.6290858704719425, 0.09801826591098013, 0.07127625700620048], [0.7865642018072299, 0.9978825388211556, 0.7830927955770902], [0.6985406435135594, 0.19034161943011285, 0.11253034959939776]];

u3coords:=[[0.353185654615899, 0.6684719911408357, 0.754486375529539], [], [], [0.9183069246958373, 0.9660491512427527, 0.5690233350587418], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [0.9876007505618064, 0.8642705044735522, 0.8133582449452749], [], [], [0.051705866941179734, 0.2327148964273048, 0.8145107584248857], [], [], [], [], [0.6783366389659327, 0.3327909231737488, 0.21226834505069847], [0.02219175598321166, 0.8707650376011529, 0.021201926278482608], [0.7406811576354336, 0.4633628532591748, 0.07004314188513694], [0.10408502721647073, 0.9991621276232535, 0.17576064321441132], [0.7466555351676061, 0.20627731095265522, 0.4290392587242904], [0.05223642439181042, 0.9673580986891861, 0.19017195101038198]];

u3coords:=
[[0.5, 0.5, 1], [], [], [1, 1, 2], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [0.5, -0.5, 1], [], [], [0, -1, 2], [], [], [], [], [1.5, 0, 1], [1, 0, 0], [0, 0, 0], [-0.5, 0, 1], [0, 0.5, 2], [1, -0.5, 2]];

u3coords:=
[[0.28125985471533355, 0.16186144683276113, 0.40766348483341314], [], [], [0.8344047691346419, -0.5038864389422675, -0.057800408792139595], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [-0.33773189975912316, 0.28535037049842515, -0.27569308994512326], [], [], [-0.6910042493578217, -0.6317285578775903, -0.27731364477964543], [], [], [], [], [0.5765983056396059, 0.27793712454754205, -0.3796590978587418], [0.19738295042671694, 1.0, 0.020800044117813717], [-0.4220433133349214, 0.7791332955041842, 0.5042127280035184], [-0.5979135763606827, -0.1091394772463883, 0.42947217391119563], [0.017801573456522325, -0.753200550992823, 0.20604810600226614], [0.14124558543972765, -0.5063272123238429, -0.5777302954925567]];

pr3:=SetVertexCoordinates3DNC(uniqueDiscs[3], u3coords, rec());

# set colour for one disc different
for i in [1..NumberOfFaces(d1)] do
	SetFaceColour(uniqueDiscs[3], i, "0x32cd32", pr3);
od;

DrawComplexToJavaScript(uniqueDiscs[3], "u3", pr3);



u4coords:=[[1.5000000000, 0.8660254040, 0.0000000000], [], [], [0.5000000000, 0.8660254040, 0.0000000000], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [1.5000000000, 0.2886751347, 0.8164965809], [], [], [2.5000000000, 0.2886751347, 0.8164965809], [], [], [], [], [1.0000000000, 1.1547005390, 0.8164965809], [0.5000000000, 0.2886751347, 0.8164965809], [1.0000000000, 0.0000000000, 0.0000000000], [2.0000000000, 0.0000000000, 0.0000000000], [2.5000000000, 0.8660254040, 0.0000000000], [2.0000000000, 1.1547005390, 0.8164965809]];

pr4:=SetVertexCoordinates3DNC(uniqueDiscs[4], u4coords, rec());

# set colour for one disc different
for i in [1..NumberOfFaces(d1)] do
	SetFaceColour(uniqueDiscs[4], i, "0x32cd32", pr4);
od;

DrawComplexToJavaScript(uniqueDiscs[4], "u4", pr4);