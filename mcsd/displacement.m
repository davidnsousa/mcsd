function dx = displacement(X)
% DISPLACEMENT calculates the displacement of all particles in all
% cartesian directions.
%
%   DX = DISPLACEMENT(X) takes an M x N x P array X with all the 
%   particles' poitions along their trajectories and calculates the
%   displacement of the particles.
%
%   The return DX is an M-by-N of the particles' displacements in all
%   cartesian directions (columns).
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