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

rounds = 100

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

def derivative(i):
    coordsa = coords[ vertices.index(edges[i][0]) ]
    coordsb = coords[ vertices.index(edges[i][1]) ]
    e = np.array([
        coordsa[0],
        coordsa[1],
        coordsa[2],

        coordsb[0],
        coordsb[1],
        coordsb[2],
    ])
    der = e*(1/np.linalg.norm(e))

    coords[ vertices.index(edges[i][0]) ] = coords[ vertices.index(edges[i][0]) ][0] - e[0]
    coords[ vertices.index(edges[i][0]) ] = coords[ vertices.index(edges[i][0]) ][1] - e[1]
    coords[ vertices.index(edges[i][0]) ] = coords[ vertices.index(edges[i][0]) ][2] - e[2]

    coords[ vertices.index(edges[i][1]) ] = coords[ vertices.index(edges[i][1]) ][0] - e[0]
    coords[ vertices.index(edges[i][1]) ] = coords[ vertices.index(edges[i][1]) ][1] - e[1]
    coords[ vertices.index(edges[i][1]) ] = coords[ vertices.index(edges[i][1]) ][2] - e[2]

for k in range(rounds):
    i = random.randint(0, len(edges)-1)
    derivative(i)
    print("updated with random int",i)
    print("error", error(),"\n")


print(error())