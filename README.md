
# MCSD: MATLAB/Octave tool for Monte-Carlo simulations of diffusion in biological tissues


Author: David N. Sousa


MCSD is a simple MATLAB/Octave tool design to simulate diffusion processes in complex environments such as biological tissues.



## Contents

            
- Getting started        
- Details        
- Examples

## Getting started


The following folders need to be added to your Matlab Search path (via `addpath`, `pathtool`, etc.):



```matlab
mcsd/mcsd
```



## Details


The following functions are provided:



  - `cells` - designs 1,2 and 3-D cell environments according to a user defined cell radii distribution .
  - `rwalkfree` - computes the random walk of multiple particles in the absence of barriers.
  - `rwalk` - generates the random walk of multiple particles in the presence of barriers.
  - `displacement` - calculates the displacement of the particles in all orthogonal directions.
  - `measures` - calculates diffusion, kurtosis and skewness values in all orthogonal directions and their compartmental components.
  - `where` - indicates what particles are inside or outside compartments at a specific time frame/step.

For details about this functions input and output parameters use Matlab help function `help` followed by the name of the function (e.g. `help rwalk`)



## Examples


**Example 1**


2-dimensional random walk of 3 particles. 1000 steps of step-size 1. All particles start at the origin.



```matlab
% parameters
initial_position = zeros(2,3);
number_of_steps = 1000;
step_size = 1;

% generate random walks
X = rwalkfree(initial_position, number_of_steps, step_size);

% plot random walks
plot(X(:,:,1),X(:,:,2));
```


![](./readmeExtras/README_01.png)

**Example 2**


2-dimensional random walk of 1000 particles. 100 steps of step-size 1. All particles start at the origin and are confined to an elongated.



```matlab
% parameters; compartments are defined by anonymous functions
initial_position = zeros(2, 1000);
number_of_steps = 100;
step_size = 1;
cell = @(x, y) sqrt((x / 10) ^ 2 + y ^ 2) &lt; 3;

% generate random walks
X = rwalk(initial_position, number_of_steps, step_size, cell);

% plot random walks
plot(X(:,:,1),X(:,:,2));
axis([-20 20 -10 10]);
```


![](./readmeExtras/README_02.png)

Find the displacement distribution:



```matlab
% calculate the displacement of every particle
dx = displacement(X);

% plot displacement distribution
hist(dx, 20)
legend('dx_1', 'dx_2')
```


![](./readmeExtras/README_03.png)

**Example 3**


2-dimensional random walk of 1000 particles. 100 steps of step-size 1. All particles start in random positions inside or outside cells.



```matlab
% parameters; compartments are defined by anonymous functions
initial_position = randi([-5 5], 2, 1000);
number_of_steps = 100;
step_size = 1;
cell_radii = [4 3 2 2];
packing_region = [-5 5 -5 5];
C = cells(cell_radii, packing_region);

% generate random walks
X = rwalk(initial_position, number_of_steps, step_size, C);

% plot the random walk of only 100 particles
plot(X(:,1:100,1),X(:,1:100,2));
```


![](./readmeExtras/README_04.png)

Find the displacement distribution for inside and outside particles:



```matlab
% calculate the displacement of every particle
dx = displacement(X);

% find inside and outside particles
[in, out] = where(X, C, 1);

% plot displacement distributions
s1 = subplot(2,2,1);
hist(dx(in,1))
title('dx_{1} inside')
s2 = subplot(2,2,2);
hist(dx(in,2))
title('dx_{2} inside')
s3 = subplot(2,2,3);
hist(dx(out,1))
title('dx_{1} outside')
s4 = subplot(2,2,4);
hist(dx(out,2))
title('dx_{2} outside')
axis([s1 s2 s3 s4],[min(min(dx)) max(max(dx)) 0 200])
```


![](./readmeExtras/README_05.png)

**Example 4**


3-dimensional random walk of 100 particles inside a permeable tube. 1000 steps of step-size 1. All particles start at the origin.



```matlab
clf

% parameters; compartments are defined by anonymous functions
initial_position = zeros(3, 100);
number_of_steps = 1000;
step_size = 1;
tube = @(x, y, z) sqrt(x ^ 2 + y ^ 2) &lt; 3;
crossing_probability = 0.0005;

% generate random walks
X = rwalk(initial_position, number_of_steps, step_size, tube, crossing_probability);

% 3-D plot of random walks
plot3(X(:,:,1),X(:,:,2),X(:,:,3));
axis([-10 10 -10 10 min(min(X(:,:,3))) max(max(X(:,:,3)))]);
```


![](./readmeExtras/README_06.png)

For any of the examples above you can also calculate the values of diffusion, kurtosis and skewness using the function `measures`. For further details type `help measures` in the command line. Try for yourself!



<sub>[Published with MATLAB R2018a]("http://www.mathworks.com/products/matlab/")</sub>
