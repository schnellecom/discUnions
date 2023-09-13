import random
import sys

import numpy
import numpy as np
import pandas as pd
from matplotlib import pyplot as plt
from numpy import double
import sympy


dim = 3
nVertices = 10

rounds = 10000000
lam = 1

vertices = [ 1, 4, 24, 27, 32, 33, 34, 35, 36, 37 ]
edges = [ [ 1, 35 ], [ 1, 34 ], [ 1, 36 ], [ 1, 4 ], [ 4, 36 ], [ 1, 32 ], [ 4, 32 ], [ 1, 33 ], [ 4, 37 ], [ 24, 32 ], [ 24, 33 ], [ 24, 37 ], [ 24, 27 ], [ 27, 37 ], [ 24, 35 ], [ 27, 35 ], [ 24, 34 ],[ 27, 36 ], [ 32, 33 ], [ 33, 34 ], [ 34, 35 ], [ 35, 36 ], [ 36, 37 ], [ 32, 37 ] ]

initial = np.random.rand(nVertices, dim)
coords = initial

def oneError(i):
    # get the coords of the vertices of given edge
    coordsa = coords[ vertices.index(edges[i][0]) ]
    coordsb = coords[ vertices.index(edges[i][1]) ]

    # calculate the distance of the vertices
    dist = (coordsa[0]-coordsb[0])**2 + (coordsa[1]-coordsb[1])**2 + (coordsa[2]-coordsb[2])**2
    dist = np.sqrt(dist)
    
    return (dist-1)**2

def error():
    error = 0
    for i in range(len(edges)):
        error += oneError(i)
    return error

def deriveToward(k,t):
    der = 0
    for v in vertices:
        for t in range(dim):
            for e in edges:
                if v in e:
                    # get the other vertex of the currently considered edge
                    vj = [vertex for vertex in vertices if vertex!=v][0]

                    coordsv = coords[ vertices.index(v) ]
                    coordsvj = coords[ vertices.index(vj) ]

                    norm = np.linalg.norm( coordsv - coordsvj )

                    der += 2*(coordsv[t] - (coordsvj[t])) * ( 1-1/(norm) )





print(error())