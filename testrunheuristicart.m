%Simple test run of the heuristic method with GMLVQ on the artificial data set
uniqueL = zeros(100,2);
gamma = zeros(100,2);

%corr = lbl(selectedbin,:);
tic; [uniqueL, gamma] = heuristic(randset', lbl', outliers', @gmlvq, @ddb_gmlvq); toc
