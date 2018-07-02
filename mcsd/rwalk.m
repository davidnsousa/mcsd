function X = rwalk(p, ns, ss, varargin)
% RWALK simulates the random walk of multiple particles in a complex
% environment.
%
%   X = RWALK(P, NS, SS) simulates an NS steps random walk of step size SS
%   for a number of particles equal to the number of columns in P. P is an
%   array with the initial coordinates of every particle. Each line
%   corresponding to one dimension.
%
%   X = RWALK(... , F) simulates a random walk in a complex
%   environment defined by an anonymous function C which specifies
%   compartments.
% 
%   X = RWALK(..., F, Prob) includes a parameter Prob to simulate the
%   permeability, the probability of crossing a barrier (0 to 1).
%
%   The return X is an M x N x K array with all the particle's positions 
%   along their trajectories. M x N x K = NS x number of walkers x number
%   of dimensions.
%
%   Examples:
%
%        F1 = @(x) (x > - 10) .* (x < 10);
%        F2 = @(x, y) sqrt(x ^ 2 + y ^ 2) < 10;
%        F3 = @(x, y, z) sqrt(x ^ 2 + y ^ 2 + z ^ 2) < 10;
%        X1 = rwalk(zeros(1, 100), 100, 1, F1);
%        X2 = rwalk(zeros(2, 100), 100, 1, F2, 0.1);
%        X3 = rwalk(zeros(3, 100), 1000, 1, F3);
%
%   This function is part of the MCSD package. For more information visit:
%   https://github.com/davidnsousa/mcsd

    % dim - # of dimensions/coordinates; nw - # of walkers
    [~, nw] = size(p);
    % Compute a random walk in a free environment
    X = rwalkfree(p, ns, ss);
    % If any extra parameters, correct random walks with the function provided
    if numel(varargin) >= 1
        % Define the function with the first optional parameter
        f = varargin{1};
        if numel(varargin) == 2
          % Define crossing probability with the second optional parameter
          prob = varargin{2};
        else
          prob = 0;
        end
        % Loop over walkers and steps and check whether they cross any barriers
        % and are allowd to do so. If not, correct the random walks from
        % the crossing step on
        for j = 1:nw
            for i = 2:ns
                % lp - last position as cell vector 
                lp = num2cell(squeeze(X(i-1, j, :)));
                % cp - current position as cell vector
                cp = num2cell(squeeze(X(i, j, :)));
                % Evaluate if crossing is allowed by generating a random number 
                % between 0 and 1 and comparing with the crossing probability
                % If it is bigger, crossing is not allowed
                % Pass ip and cp as arguments to f
                % If last and current positions are at different regions the 
                % particle is trying to cross. The condition evaluates to TRUE
                if rand >= prob && f(cp{:}) ~= f(lp{:})
                    % Correct random walk
                    X(i:end, j, :) = rwalkfree(squeeze(X(i-1, j, :)),ns + 1 - i, ss);
                end
            end
        end
    end  
end