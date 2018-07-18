function m = cmeasures(measure, X, varargin)
% CMEASURES calculates all compartmental components of a specific measure
% in all cartesian directions.
%
%   M = CMEASURES(measure, X) takes a function handle for a specific
%   measure, and an M x N x P array X with all the particles' positions
%   along their trajectories, and applies the specified measure to the
%   particles' displacement distribution in every cartesian direction.
%
%   M = CMEASURES(... , F) includes also a function handle for F, a
%   function specifying compartments, and calculates the same measure for
%   each compartment.
%
%   The return M is an array with each column referring to one cartesian
%   direction. If F is given, the second and third lines correspond to
%   inside and outside measures respectively.
%
%   Examples:
%       
%       F = @(x, y) sqrt(x ^ 2 + y ^ 2) < 3;
%       X = rwalk(randi([-10 10], 2, 100), 100, 1, F);
%       M = measures(@var, X, F)
%
%   See also RWALK
%
%   This function is part of the MCSD package. For more information visit:
%   https://github.com/davidnsousa/mcsd

    % dim - # of dimensions/coordinates
    [~, ~, dim] = size(X);
    m  = zeros(1,dim);
    % calculate displacements
    dx = displacement(X);
    % total measure
    m(1,:) = measure(dx);
    % Compartmental measures
    if nargin == 3
        f = varargin{1};
        % retrieve indexes of inside (i) and outside (o) particles
        [i, o] = where(X,f,1);
        if ~isempty(i) 
            m(2,:) = measure(dx(i,:));
        end
        if ~isempty(o) 
            m(3,:) = measure(dx(o,:));
        end
    end   
end
