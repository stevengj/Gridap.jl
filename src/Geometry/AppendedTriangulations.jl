
function lazy_append(a::Triangulation,b::Triangulation)
  AppendedTriangulation(a,b)
end

struct AppendedTriangulation{Dc,Dp} <: Triangulation{Dc,Dp}
  a::Triangulation{Dc,Dp}
  b::Triangulation{Dc,Dp}
end

function get_cell_coordinates(trian::AppendedTriangulation)
  a = get_cell_coordinates(trian.a)
  b = get_cell_coordinates(trian.b)
  lazy_append(a,b)
end

function get_reffes(trian::AppendedTriangulation)
  vcat(get_reffes(trian.a),get_reffes(trian.b))
end

function get_cell_type(trian::AppendedTriangulation)
  a = get_cell_type(trian.a)
  b = get_cell_type(trian.b) .+ Int8(length(get_reffes(trian.a)))
  lazy_append(a,b)
end

function reindex(f::AbstractArray,trian::AppendedTriangulation)
  a = reindex(f,trian.a)
  b = reindex(f,trian.b)
  lazy_append(a,b)
end

function get_cell_id(trian::AppendedTriangulation)
  a = get_cell_id(trian.a)
  b = get_cell_id(trian.b)
  lazy_append(a,b)
end

function restrict(f::AbstractArray,trian::AppendedTriangulation)
  a = restrict(f,trian.a)
  b = restrict(f,trian.b)
  lazy_append(a,b)
end

function get_cell_reffes(trian::AppendedTriangulation)
  a = get_cell_reffes(trian.a)
  b = get_cell_reffes(trian.b)
  lazy_append(a,b)
end

function get_cell_shapefuns(trian::AppendedTriangulation)
  a = get_cell_shapefuns(trian.a)
  b = get_cell_shapefuns(trian.b)
  lazy_append(a,b)
end

function get_cell_map(trian::AppendedTriangulation)
  a = get_cell_map(trian.a)
  b = get_cell_map(trian.b)
  lazy_append(a,b)
end

function get_normal_vector(trian::AppendedTriangulation)
  cm = get_cell_map(trian)
  a = get_array(get_normal_vector(trian.a))
  b = get_array(get_normal_vector(trian.b))
  GenericCellField(lazy_append(a,b),cm)
end

function CellQuadrature(trian::AppendedTriangulation,degree1::Integer,degree2::Integer)
  quad1 = CellQuadrature(trian.a,degree1)
  quad2 = CellQuadrature(trian.b,degree2)
  lazy_append(quad1,quad2)
end

function CellQuadrature(trian::AppendedTriangulation,degree::Integer)
  CellQuadrature(trian,degree,degree)
end

