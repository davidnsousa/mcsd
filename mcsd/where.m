function [in, out] = where(p, f, step)
% WHERE indicates what particles are inside or outside compartments at a
% specific frame/step.
%
%   [IN, OUT] = WHERE(X, F, S) takes an M x N x K array X with all the 
%   particle's positions along their trajectories, an anonymous function F
%   specifying compartments and a step number S.
%
%   The return IN is a vector of the indexes of particles inside
%   compartments. OUT is a vector of the indexes of particles outside
%   compartments.
%
%   Examples:
%       
%       F = @(x) (x > - 5) .* (x < 5);
%       X = rwalk(randi([-5 5], 1, 100), 100, 1, F);
%       [in, out] = where(X, F, 1)
%
%   See also RWALK
%
%   This function is part of the MCSD package. For more information visit:
%   https://github.com/davidnsousa/mcsd

    % ns - # of steps; nw - # of walkers; dim - # of dimensions/coordinates
    [~, nw, ~] = size(p);
    i = zeros(1, nw);
    % Determine whether walkers are inside or outside compartments
    for j = 1:nw
        vars = num2cell(squeeze(p(step, j, :)));
        i(j) = f(vars{:}) ~= 0; 
    end
    % Select indexes of inside walkers and outside walkers
    in = find(i ~= 0);
    out = find(i == 0);
end
