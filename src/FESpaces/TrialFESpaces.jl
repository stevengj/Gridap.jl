
struct TrialFESpace <: SingleFieldFESpace
  space::SingleFieldFESpace
  dirichlet_values::AbstractVector
  cell_basis::CellBasis
end

"""
"""
function TrialFESpace(space::SingleFieldFESpace)
  dirichlet_values = get_dirichlet_values(space)
  cell_basis = _prepare_trial_cell_basis(space)
  TrialFESpace(space,dirichlet_values,cell_basis)
end

"""
"""
function TrialFESpace(space::SingleFieldFESpace,objects)
  dirichlet_values = compute_dirichlet_values_for_tags(space,objects)
  cell_basis = _prepare_trial_cell_basis(space)
  TrialFESpace(space,dirichlet_values,cell_basis)
end

function  _prepare_trial_cell_basis(space)
  cb = get_cell_basis(space)
  a = get_array(cb)
  cm = get_cell_map(cb)
  trial_style = Val{true}()
  cell_basis = GenericCellBasis(trial_style,a,cm)
end

# Genuine functions

get_dirichlet_values(f::TrialFESpace) = f.dirichlet_values

get_cell_basis(f::TrialFESpace) = f.cell_basis

# Delegated functions

get_cell_dof_basis(f::TrialFESpace) = get_cell_dof_basis(f.space)

num_free_dofs(f::TrialFESpace) = num_free_dofs(f.space)

zero_free_values(::Type{T},f::TrialFESpace) where T = zero_free_values(T,f.space)

apply_constraints_matrix_cols(f::TrialFESpace,cm,cids) = apply_constraints_matrix_cols(f.space,cm,cids)

apply_constraints_matrix_rows(f::TrialFESpace,cm,cids) = apply_constraints_matrix_rows(f.space,cm,cids)

apply_constraints_vector(f::TrialFESpace,cm,cids) = apply_constraints_vector(f.space,cm,cids)

get_cell_dofs(f::TrialFESpace) = get_cell_dofs(f.space)

num_dirichlet_dofs(f::TrialFESpace) = num_dirichlet_dofs(f.space)

zero_dirichlet_values(f::TrialFESpace) = zero_dirichlet_values(f.space)

num_dirichlet_tags(f::TrialFESpace) = num_dirichlet_tags(f.space)

get_dirichlet_dof_tag(f::TrialFESpace) = get_dirichlet_dof_tag(f.space)

scatter_free_and_dirichlet_values(f::TrialFESpace,fv,dv) = scatter_free_and_dirichlet_values(f.space,fv,dv)

gather_free_and_dirichlet_values(f::TrialFESpace,cv) = gather_free_and_dirichlet_values(f.space,cv)

gather_dirichlet_values(f::TrialFESpace,cv) = gather_dirichlet_values(f.space,cv)

gather_free_values(f::TrialFESpace,cv) = gather_free_values(f.space,cv)

