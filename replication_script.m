% 1-dimensional 100-steps random walk of 1 particles with step size 1 and 
% starting at the origin.

X = rwalkfree(0, 100, 1);

% 1-dimensional 100-steps random walk of 3 particles with step size 1 and 
% starting at positions -3, 1 and 2.

X = rwalkfree([-3 1 2], 100, 1);

% 2-dimensional 100-steps random walk of 1000 particles with step size 1 
% and starting at the origin.

X = rwalkfree(zeros(2, 1000), 100, 1);

% Caculate all components of the displacement of the particles

dx = displacement(X);

% Plot the random walk trajectories and the histrogram of the horizontal
% component of displacements

figure(1);
plot(X(:,:,1), X(:,:,2));
xlabel("distance (# steps)")
ylabel("distance (# steps)")
figure(2);
hist(dx(:,1), 20);
xlabel("distance (# steps)")
ylabel("# walkers")

% Create an elongated cell and generate the 2-dimensional 100-steps random
% walk of 1000 particles with step size 1 and starting at the origin inside 
% the cell; calculate and plot the histogram of displacements.

cell = @(x, y) sqrt((x / 10) ^ 2 + y ^ 2) < 3;
X = rwalk(zeros(2, 1000), 100, 1, cell);
figure(3);
plot(X(:,:,1), X(:,:,2));
xlabel("distance (# steps)")
ylabel("distance (# steps)")
axis([-20 20 -10 10])
dx = displacement(X);
figure(4);
hist(dx, 20);
xlabel("distance (# steps)")
ylabel("# walkers")
legend('dx_1', 'dx_2')

% Create spherical cell and generate the 3-dimensional 100-steps random
% walk of 1000 particles with step size 1 and starting at the origin inside
% the cell; plot the random walk trajectories.

cell = @(x, y, z) sqrt(x ^ 2 + y ^ 2 + z ^ 2) < 5;
X = rwalk(zeros(3, 1000), 100, 1, cell);
figure(5);
plot3(X(:,:,1),X(:,:,2),X(:,:,3));
xlabel("distance (# steps)")
ylabel("distance (# steps)")
zlabel("distance (# steps)")
axis image

% Create a permeable cell in shape of a tube and generate the 3-dimensional 
% 100-steps random walk of 1000 particles with step size 1 and starting at 
% the origin inside the cell; plot the random walk trajectories.

cell = @(x, y, z) sqrt(x ^ 2 + y ^ 2) < 3;
X = rwalk(zeros(3, 1000), 100, 1, cell, 0.0005);
figure(6);
plot3(X(:,:,1),X(:,:,2),X(:,:,3));
xlabel("distance (# steps)")
ylabel("distance (# steps)")
zlabel("distance (# steps)")
axis([-10 10 -10 10 min(min(X(:,:,3))) max(max(X(:,:,3)))]);

% Example of combined anonymous functions representing non overlaping 
% circles, each identified by a number to which the combined function 
% evaluates if (x,y) falls inside the region specified by the combination 
% of logical expressions. Outside, the function evaluates to 0.

c1 = @(x, y) sqrt(x ^ 2 + y ^ 2) < 3;
c2 = @(x, y) sqrt((x - 7) ^ 2 + (y - 9) ^ 2) < 2;
C = @(x, y) c1(x, y) .* 1 + c2(x, y) .* 2;

% Create 3 cells of radii 4, 3 and 2 inside the packing region defined by 
% [xmin xmax ymin ymax] = [-5 5 -5 5]

[C, vf] = cells([4 3 2], [-5 5 -5 5]);

% Show intracellular volume fraction

vf

% Generate a 2-dimensional 100-steps random walk of 1000 particles with 
% step size 1 and starting at random positions inside the packing region 
% specified. The random walk is limited by C.

X = rwalk(randi([-5 5], 2, 1000), 100, 1, C);

% Identify inside and outside walkers

[in, out] = where(X, C, 1);

% Plot the histograms of the displacement components inside and outside 
% cells

figure(7);
plot(X(:,1:100,1), X(:,1:100,2));
xlabel("distance (mm)")
ylabel("distance (mm)")
figure(8);
dx = displacement(X);
s1 = subplot(2,2,1);
hist(dx(in,1))
title('dx_{1} inside')
ylabel("# walkers")
s2 = subplot(2,2,2);
hist(dx(in,2))
title('dx_{2} inside')
s3 = subplot(2,2,3);
hist(dx(out,1))
title('dx_{1} outside')
xlabel("distance (# steps)")
ylabel("# walkers")
s4 = subplot(2,2,4);
hist(dx(out,2))
title('dx_{2} outside')
xlabel("distance (# steps)")
axis([s1 s2 s3 s4],[min(min(dx)) max(max(dx)) 0 200])

% A more realistic example of the aplicability of MCSD to simulate 
% diffusion processes in biological tissues. Here the coefficient, the time 
% interval and the time-step of diffusion is specified and the number of 
% steps and step size are derived from these values and the formula for 
% the mean square displacement derived from Einstein's 2-dimensional PDF; 
% Diffusion is calculated. The intracellular volume fraction is shown. 
% The cell environment is characterized by a normal dsitribution of the
% cell raddi.

D = 0.003; 
t = 0.026; 
dt = 0.000025;
l = 0.1;
[C, vf] = cells(normrnd(0.005, 0.0025, 1, 70), [0 l 0 l]);
vf
X = rwalk(rand(2, 100) * l, t / dt, sqrt(4 * D * dt), C);
diffusion = @(dx) var(dx) / (2 * t);
Diff = cmeasures(diffusion, X, C)

% plot outside walkers' trajectories

[in, out] = where(X, C, 1);
figure(9);
plot(X(:,out,1), X(:,out,2));
xlabel("distance (mm)")
ylabel("distance (mm)")

% repeat the code for ploting the histograms of the displacement components 
% inside and outside cells

figure(10);
dx = displacement(X);
s1 = subplot(2,2,1);
hist(dx(in,1))
title('dx_{1} inside')
ylabel("# walkers")
s2 = subplot(2,2,2);
hist(dx(in,2))
title('dx_{2} inside')
s3 = subplot(2,2,3);
hist(dx(out,1))
title('dx_{1} outside')
xlabel("distance (mm)")
ylabel("# walkers")
s4 = subplot(2,2,4);
hist(dx(out,2))
title('dx_{2} outside')
xlabel("distance (mm)")
axis([s1 s2 s3 s4],[min(min(dx)) max(max(dx)) 0 200])

% A repetition of the previous example with 3 degrees of freedom to
% simulate diffusion along axonal membranes. The step size is calculated
% from the square displacement formula derived from the Einstein's PDF in
% three dimensions. The diffusion tensor ir calculated from the covariance
% matrix of displacements normalized by the diffusion time.

A = @(x, y, z) C(x, y);
X = rwalk(rand(3, 100) * l, t / dt, sqrt(6 * D * dt), A);
Diff = cmeasures(diffusion, X, A)
dx = displacement(X);
DT = cov(dx) / (2 * t)
FA = fanisotropy(DT)