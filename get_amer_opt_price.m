function [opt_price, opt_tree, stock_price] = ...
    get_amer_opt_price(spot_price, K, rf, sigma, q, T, n, opt_typ, exe_typ)
%{
    FUNCTION MANUAL
    
    Version 1.0
    
    This function may be used to price an American Option.
    
    Outout:
        opt_price = option price
        opt_tree = estimated option price binomial tree
        stock_price = estimated stock price binomial tree
    
    Input:
        spot_price = current equity(index) price
        K = strike price of option
        rf = proper risk-free return rate
        sigma = volatility of equity(index)
        q = equity(index) growth rate
        T = time span
        n = number of binomial tree steps
        opt_typ = 'c' for call / 'p' for put
        exe_typ = 'a' for American / 'e' for European
    
    Xiaodong Zhai (xz125@duke.edu)
%}
    
%% COMPUTING FACTORS
h = T / n;                      % time interval for every step
u = exp(sigma * sqrt(h));       % up step size     
d = 1 / u;                      % down step size
a = exp( (rf - q) * h);      	% growth factor per step
p = (a - d) / (u - d);          % probability of up move

%% COMPUTATION
% prelocate stock & option trees
stock_price = zeros(n + 1);
opt_tree = zeros(n + 1);

% Stock Price Tree
for i = 1 : n+1
    for j = i : n+1
        stock_price(i, j) = spot_price * u^(j-i) * d^(i-1);
    end
end

% Option Terminal Price
for i = 1 : n+1
    if opt_typ == 'c'
        opt_tree(i, n+1) = max(stock_price(i, n+1) - K, 0);
    elseif opt_typ == 'p'
        opt_tree(i, n+1) = max(K - stock_price(i, n+1), 0);
    end
end

% Option Tree
for j = n : -1 : -1
    for i = 1 : j
        if exe_typ == 'a'
            if opt_typ == 'c'
                opt_tree(i, j) = max(stock_price(i, j) - K, ...
                    exp(-rf * h) * (p * opt_tree(i, j+1) + ...
                    (1 - p) * opt_tree(i+1, j+1)));
            else
                opt_tree(i, j) = max(K - stock_price(i, j), ...
                    exp(-rf * h) * (p * opt_tree(i, j+1) + ...
                    (1 - p) * opt_tree(i+1, j+1)));
            end
        elseif exe_typ == 'e'
            opt_tree(i, j) = exp(-rf * h) * (p * opt_tree(i, j+1) + ...
                (1 - p) * opt_tree(i+1, j+1));
        end
    end
end

opt_price = opt_tree(1,1);


