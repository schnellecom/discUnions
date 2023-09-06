
libname := libname, "/home/data/archiv/daniel/maple/lib10/";
with(LinearAlgebra);
with(SimplicialSurfaceEmbeddings);
s := NewSurface();
AddFace(s, [1, 34, 4]);
AttachFace(s, [1, 4], 32);
AttachButterfly(s, [34, 4], [4, 32], 33);

AttachFace(s, [32, 33], 24);
AttachButterfly(s, [1, 32], [32, 24], 37);

AttachFace(s, [1, 37], 36);
AttachButterfly(s, [34, 1], [1, 36], 35);
AttachButterfly(s, [24, 37], [37, 36], 27);
AttachButterfly(s, [24, 27], [27, 36], 35);

PasteFace(s, [24, 33], [33, 34]);
PasteFace(s, [24, 35], [35, 34]);

SurfaceInfo(s);

CoordinateMatrix(s, 1, "listlist" = true);
evalf(CoordinateMatrix(s, 1, "listlist" = true));


NULL;
NULL;
NULL;

