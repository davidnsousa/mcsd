function FA = fanisotropy(DT)
%FANISOTROPY calculates the fractional anisotropy of diffusion.
%   
%   FANISOTROPY(DT) takes a matrix DT - the diffusion tensor, and computes
%   the fractional anisotropy FA (scalar).
%
%   Examples:
%
%     X = rwalk(zeros(2, 1000),1000,1);
%     DT = cov(dx)/(2*0.1)
%     FA = fanisotropy(DT)
%
%   See also RWALK and COV
%
%   This function is part of the MCSD package. For more information visit:
%   https://github.com/davidnsousa/mcsd  

    ev = eig(DT);
    mev = mean(ev);
    FA = sqrt(3 / 2) * (sqrt(sum((ev-mev) .^ 2)) / sqrt(dot(ev,ev))); 

end

