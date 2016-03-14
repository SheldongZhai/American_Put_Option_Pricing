%{

RA, Math Dept.

A Binomial American Options Pricing Test Demo

With function file(s):
    get_ame_opt_price.m

Xiaodong Zhai (xz125@duke.edu)

%}

%% INITIATE STATE
clc; clear;

%% CASE 1: AmerPut
% set inputs
spot_price = 345;   % current stock price
K = 350;           	% strike price
rf = 0.025;     	% risk-free return rate
q = 0.02;        	% equity(index) growth rate
sig = 0.15;         % volatility
T = 0.25;        	% time span
n = 4;              % number of steps
opt_typ = 'p';      % option type: 'c' for call, 'p' for put
exe_typ = 'e';      % execution type: 'a' for American, 'e' for European

% call function
[put_price, put_tree, stock_price_tree] = ...
    get_amer_opt_price(spot_price, K, rf, sig, q, T, n, opt_typ, exe_typ);

% diplay results
display(put_price);
display(put_tree);
display(stock_price_tree);


%% CASE 2: AmerCall
% set inputs
spot_price = 350;	% current stock price
K = 345;            % strike price
rf = 0.02;          % risk-free return rate
q = 0.025;          % equity(index) growth rate
sig = 0.15;         % volatility
T = 0.25;           % time span
n = 4;              % number of steps
opt_typ = 'c';      % option type: 'c' for call, 'p' for put
exe_typ = 'e';      % execution type: 'a' for American, 'e' for European

% call function
[call_price, call_tree, stock_price_tree] = ...
    get_amer_opt_price(spot_price, K, rf, sig, q, T, n, opt_typ, exe_typ);

% diplay results
display(call_price);
display(call_tree);
display(stock_price_tree);


