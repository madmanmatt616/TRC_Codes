%%% Image Generation.m
%%% Creates a random image based on the question

function recursion  = runme(numberOfUnknowns)
	initialSeedValue = 10;
	unknownVals = solveEquations(initialSeedValue,numberOfUnknowns);
	newSeed = [unknownVals(1)];
	for i=1:4
		unknownVals = [];
		unknownVals = solveEquations(newSeed(i)*10,numberOfUnknowns);
		newSeed = [newSeed unknownVals(1)];
	end
	createImage = zeros(500,500);
	for i=1:length(newSeed)
		createImage(:,(100*(i-1) + 1):(100*i)) = repmat(newSeed(i)*10,500,100);
	end
	figure();
	colormap(gray);imagesc(createImage)

function unknowns = solveEquations(seedValue, n)
	% n is the number of unknowns
    disp(uint8(seedValue)+1)
	rng(uint8(seedValue)+1);
	setOfCoefficients = randi(255, n, n+1);
	unknowns = setOfCoefficients(:,1:n)\setOfCoefficients(:,n+1);
    