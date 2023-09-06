
libname := libname, "/home/data/archiv/daniel/maple/lib10/";
with(LinearAlgebra);
with(SimplicialSurfaceEmbeddings);



s := NewSurface();
AddFace(s, [1, 32, 33]);
AttachFace(s, [1, 32], 37);
AttachButterfly(s, [33, 32], [32, 37], 24);
AttachButterfly(s, [1, 33], [33, 24], 34);

AttachFace(s, [24, 34], 35);
AttachButterfly(s, [35, 24], [24, 37], 27);

PasteFace(s, [1, 34], [34, 35]);
AttachButterfly(s, [35, 1], [1, 37], 4);

AttachButterfly(s, [35, 4], [4, 37], 36);
PasteFace(s, [27, 35], [35, 36]);
PasteFace(s, [27, 37], [37, 36]);

CoordinateMatrix(s, 1, "listlist" = true);
evalf(CoordinateMatrix(s, 1, "listlist" = true));


NULL;
NULL;
NULL;

