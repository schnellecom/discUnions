
import numpy as np

dim = 3
nVertices = 10

vertices = [ 1, 4, 24, 27, 32, 33, 34, 35, 36, 37 ]
edges = [ [ 1, 35 ], [ 1, 34 ], [ 1, 36 ], [ 1, 4 ], [ 4, 36 ], [ 1, 32 ], [ 4, 32 ], [ 1, 33 ], [ 4, 37 ], [ 24, 32 ], [ 24, 33 ], [ 24, 37 ], [ 24, 27 ], [ 27, 37 ], [ 24, 35 ], [ 27, 35 ], [ 24, 34 ],[ 27, 36 ], [ 32, 33 ], [ 33, 34 ], [ 34, 35 ], [ 35, 36 ], [ 36, 37 ], [ 32, 37 ] ]

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
    v = vertices[k]
    for e in edges:
        if v in e:
            # get the other vertex of the currently considered edge
            vj = [vertex for vertex in e if vertex!=v][0]

            coordsv = coords[ k ]
            coordsvj = coords[ vertices.index(vj) ]

            norm = np.linalg.norm( coordsv - coordsvj )

            # difference between deriving towards the first vertex in the edge or the second
            if e[0] == v:
                der += 2*(coordsv[t] - (coordsvj[t])) * ( 1-1/(norm) )
            else:
                der -= 2*(coordsv[t] - (coordsvj[t])) * ( 1-1/(norm) )
    return der



def makeStep(k):
    # pre-calculate derivative to not change coordinates during
    derivative = []
    for v in range(nVertices):
        derivative.append([])
        for t in range(dim):
            derivative[v].append(deriveToward(v, t))

    for v in range(nVertices):
        for t in range(dim):
            coords[v][t] -= lam*(1/(k))*derivative[v][t]

def printableCoords():
    printableCoords = []
    for i in range(1, max(vertices)+1):
        printableCoords.append([])
    for i in vertices:
        printableCoords[i-1] = []
        printableCoords[i-1].append(coords[ vertices.index(i) ][0])
        printableCoords[i-1].append(coords[ vertices.index(i) ][1])
        printableCoords[i-1].append(coords[ vertices.index(i) ][2])
    return repr(printableCoords)

rounds = 1000000
lam = 1/100000

# find good starting point
print("searching for good starting coordinates")
coords = np.random.rand(nVertices, dim)
# initialError = error()
# while initialError > 1:
#     print("\rcurrent found error ",initialError, end="")
#     coords = np.random.rand(nVertices, dim)
#     initialError = error()

# vertices = [ 1, 4, 24, 27, 32, 33, 34, 35, 36, 37 ]

# set good guess manually
coords = np.array([
    [0.5,0.5,1],
    [1,1,2],
    [0.5,-0.5,1],
    [0,-1,2],
    [1.5,0,1],
    [1,0,0],
    [0,0,0],
    [-0.5,0,1],
    [0,0.5,2],
    [1,-0.5,2]
])
coords = np.array(
    [[0.0843485828284032, -0.057533038704166546, 0.5861266008855506], [-0.5499746308912634, 0.8590889688460048, 0.45133506707998067], [-0.043863607372923934, -0.440249631974893, -0.39630907222443507], [0.44677633546616136, 0.40969730008202876, -0.934439668130813], [-0.8140621819631515, -0.08606435546506488, 0.22454024661555017], [-0.3785030005862417, -1.0, 0.45877235131469607], [0.5400196158645381, -0.9881121245683903, 0.2997162812752513], [0.8302505458721277, -0.10138883808016518, -0.15289537854878613], [0.3416930207036248, 0.8191559580408869, -0.042355218316880085], [-0.45668467992127487, 0.5854057618237591, -0.4944912099501139]]
)

initialError = error()

print("\rinitial error ",error())

# version with set rounds
# for k in range(rounds):
#     makeStep(k+1)
#     currError = error()
#     if k%1000 ==0:
#         print("\rround: ",k," error: ",currError, end="")
#     if currError < 0.1:
#         print("\ncoords:\n")
#         print(printableCoords())
#         break

# version with set error
currError = initialError
k = 1
# while currError > 0.1:
#     makeStep(k)
#     if k%1000 == 0:
#         currError = error()
#         print("\rround: ",k," error: ",currError, end="")
#     if currError < 0.5:
#         print("\ncoords:\n")
#         print(printableCoords(),"\n")
#         # break
#     k+=1

print("\ncoords:\n")
print(printableCoords())
