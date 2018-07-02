function X = rwalkfree(p, ns, ss)
% RWALKFREE simulates the random walk of multiple particles.
%
%   X = RWALKFREE(P, NS, SS) simulates an NS steps random walk of step size 
%   SS for a number of particles equal to the number of columns in P. P is 
%   an array with the initial coordinates of every particle. Each line
%   corresponding to one dimension.
%
%   The return X is an M x N x K array with all the particle's positions 
%   along their trajectories. M x N x K = NS x number of walkers x number
%   of dimensions.
%
%   Examples:
%
%     X = rwalkfree([0 0],100,1);
%     X = rwalkfree(zeros(2, 4),100,1);
%     X = rwalkfree(randi(10, 3, 10),1000,1);
%
%   This function is part of the MCSD package. For more information visit:
%   https://github.com/davidnsousa/mcsd  
  
    % dim - # of dimensions/coordinates; nw - # of walkers
    [dim, nw] = size(p);
    X = zeros(ns, nw, dim);
    ns = ns - 1;
    % Compute 1-D random walk
    if dim == 1
        % ns x nw array of random direction decisions for every step
        t = randi([0 1], ns, nw) * 2 - 1;
        % Cumulative sum of decisions considering original position and step size
        X = cumsum(cat(1, p, t .*ss));
    end
    % Compute 2-D random walk
    if dim == 2
        % ns x nw array of random radial direction decisions for every step
        t = rand(ns, nw) * 2 * pi;
        % Radial coordinates are converted to cartesian coordinates
        X(:, :, 1) = cumsum(cat(1, p(1, :), cos(t) .* ss));
        X(:, :, 2) = cumsum(cat(1, p(2, :), sin(t) .* ss));
    end
    % Compute 3-D random walk
    if dim == 3
        % ns x nw arrays of random spherical direction decisions for every step
        t = rand(ns, nw) * 2 * pi;
        phi = rand(ns, nw) * 2 * pi;
        % Spherical coordinates are converted to cartesian coordinates
        X(:, :, 1) = cumsum(cat(1, p(1, :), cos(t) .* sin(phi) .* ss));
        X(:, :, 2) = cumsum(cat(1, p(2, :), sin(t) .* sin(phi) .* ss));
        X(:, :, 3) = cumsum(cat(1, p(3, :), cos(phi) .* ss));
    end
end