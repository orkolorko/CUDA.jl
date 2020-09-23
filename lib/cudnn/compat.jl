# Compatibility shims until users upgrade to new NNlib format
function conv!(y::DenseCuArray{T}, x::DenseCuArray{T}, w::DenseCuArray{T}; pad=0, stride=1, flipkernel=0, dilation=1, kwargs...) where {T<:CUDNNFloat}
    cdims = DenseConvDims(x, w; padding=pad, stride=stride, flipkernel=flipkernel, dilation=dilation)
    return conv!(y, x, w, cdims; kwargs...)
end

function ∇conv_filter!(dw::DenseCuArray{T}, dy::DenseCuArray{T}, x::DenseCuArray{T}; pad=0, stride=1, flipkernel=0, dilation=1, kwargs...) where {T<:CUDNNFloat}
    cdims = DenseConvDims(x, dw; padding=pad, stride=stride, flipkernel=flipkernel, dilation=dilation)
    # NOTE!!!  This compat shim re-arranges the argument order!
    return ∇conv_filter!(dw, x, dy, cdims; kwargs...)
end

function maxpool!(y::DenseCuArray{T}, x::DenseCuArray{T}, k; pad=map(_->0,k), stride=k) where {T<:CUDNNFloat}
    pdims = PoolDims(x, k; padding=pad, stride=stride)
    return maxpool!(y, x, pdims)
end

function meanpool!(y::DenseCuArray{T}, x::DenseCuArray{T}, k; pad=map(_->0,k), stride=k) where {T<:CUDNNFloat}
    pdims = PoolDims(x, k; padding=pad, stride=stride)
    return meanpool!(y, x, pdims)
end
