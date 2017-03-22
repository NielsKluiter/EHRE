%Simple test run of the heuristic method with GMLVQ
uniqueL = zeros(100,2);
gamma = zeros(100,2);

corr = lbl(selectedbin,:);
tic; [uniqueL, gamma] = heuristic(data(~selectedbin,:), lbl(~selectedbin,:), data(selectedbin,:), @gmlvq, @ddb_gmlvq); toc
