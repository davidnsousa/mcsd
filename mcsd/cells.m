function [C, vf] = cells(r, d)
% CELLS creates a 1, 2 or 3-D environment of randomly distributed cells.
%
%   [C, V] = CELLS(R, D) takes a vector R containing the cell radii and a 
%   vector D specifying the dimensions of the region to pack the cells. 
%   D = [xmin xmax ymin ymax zmin zmax]
%
%   The return C is an anonymous function specifying intracellular regions
%   with the respective cell identification numbers. Outside cells C = 0.
%   V is the resulting intracellular fraction of the region specified by D.
%
%   Examples:
%
%       [C, vf] = cells([3 3], [0 10]);
%       [C, vf] = cells(ones(1,5)*2, [-5 5 -5 5]);
%
%   This function is part of the MCSD package. For more information visit:
%   https://github.com/davidnsousa/mcsd

    dim = length(d) / 2;
    vol = prod(d(2:2:end) - d(1:2:end-1));
    % C is the anonymous function of cells
    % initialized to 0, meaning that everywhere is extracellular space
    % C will be used in the while cycle to check whether new added cells, distant
    % from each other cell by r2, overlap any existing cells. Non-overlapping cells
    % will be added to C. x, y, z are cartesian coordinates
    C = @(x, y, z, r2) 0;
    % Loop over the radii vector in descent order to generate a space distribution
    % of non-overlapping randomly positioned cells
    r = sort(r, 'descend');
    for i = 1:length(r)
        % Generate random coordinates inside the region defined by d
        d(end + 1:6) = 0;
        o = (d(2:2:end) - d(1:2:end-1)) .* rand(1,3) + d(1:2:end-1);
        % While the new cell with coordinates o and radius r overlaps others,
        % generate new coordinates
        while C(o(1), o(2), o(3), r(i)) ~= 0
            o = (d(2:2:end) - d(1:2:end-1)) .* rand(1,3) + d(1:2:end-1);
        end
        % Create anonymous function for the present cell and combine it with C
        c = @(x, y, z, r2) ... 
            (sqrt((x - o(1)) ^ 2 + (y - o(2)) ^ 2 + (z - o(3)) ^ 2) < r(i) + r2 ).* i;
        C = @(x, y, z, r2) C(x, y, z, r2) + c(x, y, z, r2);
    end
    % r2 is not relevant anymore. Set it to 0.
    C = @(x, y, z) C(x, y, z, 0);
    % Depending on dim, select the relevant function parameters for the output C
    if dim == 1
        C = @(x) C(x, 0, 0);  
        % Calculate intracellular volume fraction
        vf = sum(2 * r) / vol;
    elseif dim == 2 
        C = @(x, y) C(x, y, 0); 
        vf = sum(pi * r .^ 2) / vol; 
    elseif dim == 3
        C = @(x, y, z) C(x, y, z); 
        vf = sum((4 / 3) * pi * r .^ 3) / vol;
    end
end
