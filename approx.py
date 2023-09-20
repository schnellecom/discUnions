
import numpy as np
import networkx as nx
import matplotlib.pyplot as plt

dim = 3
nVertices = 10

vertices = [ 1, 4, 24, 27, 32, 33, 34, 35, 36, 37 ]
edges = [ [ 1, 35 ], [ 1, 34 ], [ 1, 36 ], [ 1, 4 ], [ 4, 36 ], [ 1, 32 ], [ 4, 32 ], [ 1, 33 ], [ 4, 37 ], [ 24, 32 ], [ 24, 33 ], [ 24, 37 ], [ 24, 27 ], [ 27, 37 ], [ 24, 35 ], [ 27, 35 ], [ 24, 34 ],[ 27, 36 ], [ 32, 33 ], [ 33, 34 ], [ 34, 35 ], [ 35, 36 ], [ 36, 37 ], [ 32, 37 ] ]

# def draw3d(G, pos):
#     fig = plt.figure()
#     ax = fig.add_subplot(111, projection='3d')

#     # draw nodes
#     nodes = np.array([pos[v] for v in G.nodes()])
#     ax.scatter(*nodes.T, s=75, ec='#ffffff', color='#4fcc33')

#     # draw edges
#     edges = np.array([(pos[u], pos[v]) for u, v in G.edges()])
#     for edge in edges:
#         ax.plot(*edge.T, color='#a2cc99')

#     plt.show()

def niceArray(dict):
    arr = []
    keys = dict.keys()
    for i in range(max(keys)+1):
        if i in keys:
            arr.append([])
            arr[i].append(dict.get(i)[0])
            arr[i].append(dict.get(i)[1])
            arr[i].append(dict.get(i)[2])
        else:
            arr.append([])
    arr.pop(0)
    return arr

def errorArray(dict):
    arr = niceArray(dict)
    while [] in arr:
        arr.remove([])
    return arr

def oneError(arr, i):
    # get the coords of the vertices of given edge
    coordsa = arr[ vertices.index(edges[i][0]) ]
    coordsb = arr[ vertices.index(edges[i][1]) ]

    # calculate the distance of the vertices
    dist = (coordsa[0]-coordsb[0])**2 + (coordsa[1]-coordsb[1])**2 + (coordsa[2]-coordsb[2])**2
    dist = np.sqrt(dist)
    
    return (dist-1)**2

def error(arr):
    error = 0
    for i in range(len(edges)):
        error += oneError(arr, i)
    return error

G = nx.Graph()
G.add_edges_from(map(tuple, edges))

currError = 1
minError = 1
while currError > 0.01:
    pos = nx.spring_layout(G, k=1, dim=3, threshold=1e-16, iterations=10000)
    currError = error(errorArray(pos))
    if minError > currError:
        minError = currError
    print("\rmin error: ",minError, "current error: ",currError,end="")
    # draw3d(G, pos)


print("\nniceArray\n",niceArray(pos))
print("\nerrorArray\n",errorArray(pos))