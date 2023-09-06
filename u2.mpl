

libname := libname, "/home/data/archiv/daniel/maple/lib10/";
with(LinearAlgebra);
with(SimplicialSurfaceEmbeddings);



s := NewSurface();
AddFace(s, [1, 32, 37]);
AttachFace(s, [1, 32], 33);
AttachFace(s, [1, 33], 4);
AttachFace(s, [1, 4], 35);
AttachFace(s, [1, 35], 36);
PasteFace(s, [36, 1], [1, 37]);


NULL;
NULL;

NULL;
NULL;
NULL;
NULL;
NULL;
NULL;
NULL;
NULL;

NULL;
NULL;

SurfaceInfo(s);

DrawSurface(s, 1);
CoordinateMatrix(s, 1, "listlist" = true);
evalf(CoordinateMatrix(s, 1, "listlist" = true));

