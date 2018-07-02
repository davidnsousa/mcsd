function [d, k, s] = measures(t, X, varargin)
% MEASURES calculates diffusion, kurtosis and skewness values in all
% orthogonal directions and their compartmental components.
%
%   [D, K, S] = MEASURES(T, X) takes  a scalar T specifying the diffusion 
%   time interval, and an M x N x K array X with all the particle's
%   positions along their trajectories, and calculates diffusion D,
%   kurtosis K and skewness S of the particles's displacement distribution
%   for each orthogonal direction.
%
%   [D, K, S] = MEASURES(... , F) includes an anonymous function F
%   specifying compartments, and calculates the same measures for each
%   compartment.
%
%   The return D, K and S are arrays with each column corresponding to each
%   orthogonal direction. If F is given, the second and third lines
%   correspond to inside and outside measures respectively.
%
%   Examples:
%       
%       F = @(x, y) sqrt(x ^ 2 + y ^ 2) < 3;
%       X = rwalk(randi([-10 10], 2, 100), 100, 0.5, F);
%       [d, k, s] = measures(0.1, X, F);
%
%   See also RWALK
%
%   This function is part of the MCSD package. For more information visit:
%   https://github.com/davidnsousa/mcsd

    % dim - # of dimensions/coordinates
    [~, ~, dim] = size(X);
    [d, k, s] = deal(zeros(1,dim));
    dx = displacement(X);
    % measures
    d(1,:) = var(dx) ./ (2 * t);
    k(1,:) = kurtosis(dx);
    s(1,:) = skewness(dx);
    % Compartmental measures
    if numel(varargin) == 1
        f = varargin{1};
        [i, o] = where(X,f,1);
        if ~isempty(i) 
            d(2,:) = var(dx(i,:)) ./ (2 * t);
            k(2,:) = kurtosis(dx(i,:));
            s(2,:) = skewness(dx(i,:));
        end
        if ~isempty(o) 
            d(3,:) = var(dx(o,:)) ./ (2 * t);
            k(3,:) = kurtosis(dx(o,:));
            s(3,:) = skewness(dx(o,:));
        end
    end   
end