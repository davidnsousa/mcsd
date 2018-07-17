function X = rwalkfree(p, ns, ss)
% RWALKFREE simulates the random walk of multiple particles.
%
%   X = RWALK(POS, NS, SS) simulates an NS steps random walk of step size 
%   SS for a number of particles equal to the number of columns in POS. POS 
%   is an array with the initial coordinates of every particle. Each line
%   referring to one dimension.
%
%   The return X is an M x N x P array with all the particles' positions 
%   along their trajectories. M x N x P = NS x number of walkers x number
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
    % generate vectors of magnitude ss in random directions for each step 
    % of each walker
    v = rand(ns,nw,dim) * 2 -1;
    v = (v./sqrt(dot(v,v,3))) * ss;
    % reshape initial positions' matrix to concatenate with all vector 
    % components of the random walk trajectories
    p = reshape(p,[1 nw dim]);
    % cumulative sum of positions and vector components
    X = cumsum(cat(1,p,v));
end