function dx = displacement(X)
% DISPLACEMENT calculates the displacement of all particles in all
% orthogonal directions.
%
%   DX = DISPLACEMENT(X) takes an M x N x K array X with all the 
%   particle's positions along their trajectories and calculates the
%   displacement of the particles.
%
%   The return DX is an M-by-N of the particle's displacements in all
%   orthogonal directions (columns).
%
%   Examples:
%
%       X = rwalk(zeros(2, 100), 100, 1);
%       DX = displacement(X);
%
%   See also RWALK
%
%   This function is part of the MCSD package. For more information visit:
%   https://github.com/davidnsousa/mcsd

    % nw - # of walkers; dim - # of dimensions/coordinates
    [~, nw, dim] = size(X);
    dx = reshape(X(end,:,:)-X(1,:,:),[nw dim]); 
end