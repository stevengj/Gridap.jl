module ConformingTriangulationsTests

using Test
using Gridap.Arrays
using Gridap.Geometry
using Gridap.Fields
using Gridap.ReferenceFEs

using Gridap.Geometry: ConformingTrianMock

trian = ConformingTrianMock()
test_conforming_triangulation(trian)

q1i = Point(0.25,0.25)
np1 = 3
q1 = fill(q1i,np1)
q2i = Point(0.5,0.5)
np2 = 4
q2 = fill(q2i,np2)
q = CompressedArray([q1,q2],get_cell_types(trian))

cell_map = get_cell_map(trian)
x = evaluate(cell_map,q)

x1i = Point(0.5, 0.75)
x2i = Point(1.5, 0.5)
x3i = Point(1.5, 1.25)
x4i = Point(1.0, 1.5)
x1 = fill(x1i,np2)
x2 = fill(x2i,np2)
x3 = fill(x3i,np1)
x4 = fill(x4i,np1)
x = [x1,x2,x3,x4]
test_array_of_fields(cell_map,q,x)

end # module
