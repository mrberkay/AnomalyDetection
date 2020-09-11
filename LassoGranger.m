function [beta, cause, MSE, aic, bic] = LassoGranger(series, lag, lambda)

% INPUTS:
% 'series': A NxT matrix 
% 'lag':		Length of the lag
% 'lambda': 	Value of the penalization parameter in Lasso


% OUTPUTS:
% 'cause':	Sum of the Granger causality coefficient from one timeseries to anohter one
% 'beta':	Unconverted cause
% 'aic':		To help select the value of Lambda

[N, T] = size(series);     % get the row and column number of matrix(series) --> N-by-T 
Am = zeros(T-lag, lag*N);  % return matrix of zeros by (T-lag) <-by-> (lag*N)
bm = zeros(T-lag, 1);      % return vector of zeros by (T-lag) <-by-> 1

for i = (lag+1):T
    bm(i-lag) = series(1, i); % assign first row of dataset(series) to bm
    Am(i-lag, :) = reshape(fliplr(series(:, (i-lag):(i-1))), 1, N*lag);
end


    
    [beta, Fitinfo] = lasso(Am, bm, 'Alpha', 1, 'Lambda', lambda);
    MSE = Fitinfo.MSE;
    DF = Fitinfo.DF;
    beta;


% Outputting AIC metric for variable tuning purpose
th = 0;
aic = norm(Am*beta - bm)^2/(T-lag) + (sum(abs(beta) > th))*2/(T-lag);
bic = log(det(norm(Am*beta - bm)^2 / (T-lag))) + 2.^2 * lag * log(T) * T.^-1; % ??

% Reformatting the results into NxP matrix
n1Coeff = zeros(N, lag);
for i = 1:N
    n1Coeff(i, :) = beta( ((i-1)*lag+1): (i*lag));
end

sumCause = sum(abs(n1Coeff), 2);

    cause = (sumCause > th).*sumCause;
    
    
    
    
    