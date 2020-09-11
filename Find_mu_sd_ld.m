function [mu,sigma,lambda] = Find_mu_sd_ld(series, betas, lag, I_normal, I_poisson)

[Row, Column] = size(series);

% Row = number of time series or covariates
% Column = number of observations
D = Row * lag;
N = Column - lag;
% Counters for arrays
j = 1;
k = 1;
    
    X = Creatematrix(series, Row, Column, lag);
    
    % mu and sigma for 3 Normal Time series
    mu = zeros(1,3);
    sigma = zeros(1,3);
    % lambda for 2 Poisson Time series
    lambda = zeros(1,2);
    
  for target_row = 1:Row

        betas_i = betas(target_row,:)';
        
        % For Normal Distributions
         if ismember(target_row, I_normal) == 1
           
            distribution = X*betas_i;
            pd = fitdist(distribution,'Normal');
            sigma(:, j) = pd.sigma;
            mu(:, j) = pd.mu;
            j = j + 1;
        end
        
        % For Poisson Distributions
         if ismember(target_row, I_poisson) == 1
            
            % For Poisson compute the log of data
            distribution = log(X*betas_i);
            pd = fitdist(distribution,'Poisson');
            lambda(:, k) = pd.lambda;
            k = k + 1;
            
        end
                   
  end

end
