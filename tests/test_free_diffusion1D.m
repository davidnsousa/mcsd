function test_suite = test_free_diffusion1D()
	try % assignment of 'localfunctions' is necessary in Matlab >= 2016
		test_functions = localfunctions();
	catch % no problem; early Matlab versions can use initTestSuite fine
end
initTestSuite;

function test_assert_within_tolerance
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
	p = rand(1, nw) * l;
	% Number of steps that each walker will give
	ns = t / dt;
	% The size of the step acording to the Einstein's PDF considering
	% the number of dimensions
	ssize = sqrt(2 * D * dt);
	% assert tolerance
	tol = 0.0005;

	% Execute

	X = rwalk(p, ns, ssize);
	diffusion = @(dx) var(dx) / (2 * t);
	Diff = cmeasures(diffusion, X);
	assert(abs(Diff - D) <= tol, ...
	    'Output Dx = %s outside tolerance interval %s', Diff, tol)