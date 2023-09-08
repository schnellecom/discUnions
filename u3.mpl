
libname := libname, "/home/data/archiv/daniel/maple/lib10/";
with(LinearAlgebra);
with(SimplicialSurfaceEmbeddings);
SimplicialSurfaceEmbeddingsOptions("vertexfaithful", true);


s := NewSurface();

AddFace(s, [1, 32, 33]);
AttachFace(s, [32, 33], 24);
AttachButterfly(s, [1, 33], [33, 24], 34);
AttachButterfly(s, [1, 34], [34, 24], 35);

AttachFace(s, [1, 32], 4);
AttachButterfly(s, [35, 1], [1, 4], 36);
AttachButterfly(s, [4, 32], [32, 24], 37);
PasteFace(s, [36, 4], [4, 37]);
AttachButterfly(s, [36, 35], [35, 24], 27);


PasteFace(s, [37, 24], [24, 27]);
PasteFace(s, [37, 36], [36, 37]);


NULL;
NULL;
NULL;

SurfaceInfo(s);

coords := CoordinateMatrix(s, 1, "listlist" = true);

EdgeLengths(s);

vertices := [35, 4, 34, 24, 1, 33, 36, 32, 37, 27];
maxVert := max(vertices);
coords := [(-1) $ maxVert];
for i to maxVert do
    if i in vertices then coords[i] := evalf(CoordinateMatrix(s, 1, "listlist" = true, "vertices" = [i]))[1]; else coords[i] := []; end if;
end do;
coords;

coords := CoordinateMatrix(s, 2, "listlist" = true);

coords := [(-1) $ maxVert];
for i to maxVert do
    if i in vertices then coords[i] := evalf(CoordinateMatrix(s, 2, "listlist" = true, "vertices" = [i]))[1]; else coords[i] := []; end if;
end do;
coords;

coords := CoordinateMatrix(s, 3, "listlist" = true);

coords := [(-1) $ maxVert];
for i to maxVert do
    if i in vertices then coords[i] := evalf(CoordinateMatrix(s, 3, "listlist" = true, "vertices" = [i]))[1]; else coords[i] := []; end if;
end do;
coords;

coords := CoordinateMatrix(s, 4, "listlist" = true);

coords := [(-1) $ maxVert];
for i to maxVert do
    if i in vertices then coords[i] := evalf(CoordinateMatrix(s, 4, "listlist" = true, "vertices" = [i]))[1]; else coords[i] := []; end if;
end do;
coords;




