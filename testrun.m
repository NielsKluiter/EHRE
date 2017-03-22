%Simple nearest neighbour ICP test run
uniqueL = zeros(100,2);
gamma = zeros(100,2);
cf = zeros(100,1);
cr = zeros(100,1);
corr = zeros(100,1);

for i = 1:100
    i
    prm = randperm(768);
    fea = data(prm,:);
    gnd = lbl(prm,:);
    corr(i) = gnd(end,:);
    tic; [uniqueL(i,:), gamma(i,:), cf(i), cr(i)] = inductive_cp(fea(1:end-1,:), gnd(1:end-1,:), fea(end,:), @pass_on, @nc_1nn); toc
end