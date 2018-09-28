tic
% Coefficient of free diffusion in the body at 37º temperature
D = 0.003;
% Diffusion time interval of a typical MRI scan
t = 0.026;
% Random walk time-step
dt = 0.000025;
% Side length of the region where the cells are packed (mm)
l = 0.01;
% Number of walkers
nw = 100;
% Initial positions of the walkers is random inside the region
p = rand(1, nw) * l;
% Number of steps that each walker will give
ns = t / dt;
% The size of the step acording to the Einstein's PDF considering
% the number of dimensions
ssize = sqrt(2 * D * dt);
% Cell radii. Normal dstribution w/ mean 0.005 mm & sdev 0.0025 mm of 1
% cells
cr = normrnd(0.005, 0.0025, 1, 1);
% Region to pack the cells
R = [0 l];
% assert tolerance (bigger here than in the tests of free diffusion
% because less walkers are used here)
tol = 0.001;

% Execute

C = cells(cr, R);
X = rwalk(p, ns, ssize, C);
diffusion = @(dx) var(dx) / (2 * t);
Diff = cmeasures(diffusion, X);
assert(Diff < (D + tol), 'Output Dx = %s is greater than allowed by tol', Diff)
toc
