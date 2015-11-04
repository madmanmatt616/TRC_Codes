% Image Generation.m
% Creates a random image based on the question
% runme is the function that you run and it calls 
% solveEquations 5 times, which solves the equation
% Note: This is how you define multiple functions in the same
% script. It is *sometimes* cleaner than having multiple scripts
% in a single folder

%% RUNME --- 
 % runme(numberOfUnknowns) is used to generate a random image from a random series of equations of a set number of unknowns
 % numberOfUnknowns is the number of unknowns in a series of equations
 % returns 1 when completed

function recursion  = runme(numberOfUnknowns) % numberOfUnknowns should not be too high (at max 5). ...
											  % Solving using \ is not fast and is super processor intensive
	initialSeedValue = 10; % Initialize a seed
	unknownVals = solveEquations(initialSeedValue,numberOfUnknowns); % Solve a series of equations based on the seed value
	newSeed = [unknownVals(1)]; % Select the first value of unknown as the next seed
	for i=1:4
		unknownVals = [];
		unknownVals = solveEquations(newSeed(i)*10,numberOfUnknowns); %The seed is multiplied by 10 because the unknown values ... 
																	  %are generally between 0 and 1 in this case
		newSeed = [newSeed unknownVals(1)];
	end

	createImage = zeros(500,500); % Create an all black image of 500 x 500

	for i=1:length(newSeed)
		createImage(:,(100*(i-1) + 1):(100*i)) = repmat(newSeed(i)*10,500,100); % Repmat repeats the first value to create a 500 x 100 block
	end
	figure();
	colormap(gray);imagesc(createImage)
	recursion = 1; 

%% SOLVE ---
 % solve(seedValue, n) returns the solution of n number of unknowns
 % seedValue is used to seed the random function
 % n is the number of unknowns
 % returns unknowns - a vector with the solution for all unknown variables.
 
function unknowns = solveEquations(seedValue, n)
	% n is the number of unknowns
    rng(uint8(seedValue)+1); % The rng function which seeds the random variable generator take nonegative integers. I just use an unsigned int and ...
    						 % add 1 to ensure values are always greater than 1
	setOfCoefficients = randi(255, n, n+1); % randi creates random integers
	unknowns = setOfCoefficients(:,1:n)\setOfCoefficients(:,n+1); %Easiest way to solve small serieses of equations
    