% All functions are tested together with practical exemples by comparing 
% the diffusion and anisotropy final values with the expected results  
% within a margin of error.

% Coefficient of free diffusion in the body at 37º temperature
D = 0.003;
% Diffusion time interval of a typical MRI scan
t = 0.026;
% Random walk time-step
dt = 0.000025;
% Side length of the region where the cells are packed (mm)
l = 0.1;
% Number of walkers
nw = 1000;
% Initial positions of the walkers is random inside the region
p_1D = rand(1, nw) * l;
p_2D = rand(2, nw) * l;
p_3D = rand(3, nw) * l;
% Number of steps that each walker will give
ns = t / dt;
% The size of the step acording to the Einstein's PDF considering
% the number of dimensions
ssize_1D = sqrt(2 * D * dt);
ssize_2D = sqrt(4 * D * dt);
ssize_3D = sqrt(6 * D * dt);
% Cell radii. Normal dstribution w/ mean 0.005 mm & sdev 0.0025 mm of 3,
% 70 in 1, 2 respectively
cr_1D = normrnd(0.005, 0.0025, 1, 3);
cr_2D = normrnd(0.005, 0.0025, 1, 70);
% Region to pack the cells
R_1D = [0 l];
R_2D = [0 l 0 l];
R_3D = [0 l 0 l 0 l];
% assert tolerance
tol = 0.0005;

%% test 1: 1D Free diffusion

X = rwalk(p_1D, ns, ssize_1D);
diffusion = @(dx) var(dx) / (2 * t);
Diff = cmeasures(diffusion, X);
assert(abs(Diff - D) <= tol, ...
    'Output Dx = %s outside tolerance interval %s', Diff, tol)

%% test 2: 2D Free diffusion

X = rwalk(p_2D, ns, ssize_2D);
diffusion = @(dx) var(dx) / (2 * t);
Diff = cmeasures(diffusion, X);
assert(abs(Diff(1) - D) <= tol, ...
    'Output Dx = %s outside tolerance interval %s', Diff(1), tol)
assert(abs(Diff(2) - D) <= tol, ...
    'Output Dy = %s outside tolerance interval %s', Diff(2), tol)

%% test 3: 3D Free diffusion

X = rwalk(p_3D, ns, ssize_3D);
diffusion = @(dx) var(dx) / (2 * t);
Diff = cmeasures(diffusion, X);
assert(abs(Diff(1) - D) <= tol, ...
    'Output Dx = %s outside tolerance interval %s', Diff(1), tol)
assert(abs(Diff(2) - D) <= tol, ...
    'Output Dy = %s outside tolerance interval %s', Diff(2), tol)
assert(abs(Diff(3) - D) <= tol, ...
    'Output Dz = %s outside tolerance interval %s', Diff(3), tol)

%% test 4: 1D Restricted diffusion in isotropic media

C = cells(cr_1D, R_1D);
X = rwalk(p_1D, ns, ssize_1D, C);
diffusion = @(dx) var(dx) / (2 * t);
Diff = cmeasures(diffusion, X);
assert(Diff < D, 'Output Dx = %s is greater than %s', Diff, D)

%% test 5: 2D Restricted diffusion in isotropic media

C = cells(cr_2D, R_2D);
X = rwalk(p_2D, ns, ssize_2D, C);
diffusion = @(dx) var(dx) / (2 * t);
Diff = cmeasures(diffusion, X);
assert(Diff(1) < D, 'Output Dx = %s is greater than %s', Diff(1), D)
assert(Diff(2) < D, 'Output Dy = %s is greater than %s', Diff(2), D)

%% test 6: 3D Restricted diffusion in anisotropic media

C = cells(cr_2D, R_2D);
axons = @(x, y, z) C(x,y);
X = rwalk(p_3D, ns, ssize_3D, axons);
diffusion = @(dx) var(dx) / (2 * t);
Diff = cmeasures(diffusion, X);
% Array of displacements
dx = displacement(X);
% Diffusion tensor
DT = cov(dx) / (2 * t);
% Fractional anisotropy
FA = fanisotropy(DT);
assert(Diff(1) < D, 'Output Dx = %s is greater than %s', Diff(1), D)
assert(Diff(2) < D, 'Output Dy = %s is greater than %s', Diff(2), D)
assert(Diff(3) > Diff(1) && Diff(3) > Diff(2), ...
    'Output Dz = %s is less than Dx = %s and / or Dy = %s' ...
    , Diff(3), Diff(1), Diff(2))
assert(FA >= 0 && FA <= 1, 'Fractional anisotropy %s is outside [0 1]')
