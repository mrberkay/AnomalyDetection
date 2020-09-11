function [PR_coeffs, betas_ref, runtime] = ...
        PenalizedRegression(time_series, lag, ref_indices, lambda, I_n, I_p)
    % process reference data
    disp('PenalizedRegression is running ...... ');
    ref_series = time_series(:, ref_indices);
    [PR_coeffs, betas_ref, runtime] = AdaptiveLasso(ref_series, lag, lambda, I_n, I_p);
    
    disp('PenalizedRegression is done ...... ');
end



function [PR_coeffs, betas_ref, runtime] = AdaptiveLasso(series, lag, lambda, I_n, I_p)

tic;
        
    [Row, Column] = size(series);
    PR_coeffs = cell(Row, 1);
    

    % Row = number of time series or covariates
    % Column = number of observations
    D = Row * lag;
    N = Column - lag;
    
    %prepare design matrix which is useful for the linear combination part
    %of the lasso optimization problem
    % PHI is the preparing sum(X_lagged * B_i) , B_i is the lasso coefficients
    
    PHI = zeros(N,D);

    t = zeros(N,1);
    for i = 1:N
        for j = 1:Row
            cur_row_start = (j-1)*lag+1;
            cur_row_end = cur_row_start + lag - 1;
            PHI(i, cur_row_start:cur_row_end) = series(j,i:(i+lag-1));           
        end
    end
       
    %series
    
    %PHI
    
    %do regression with each time series as target
    for target_row = 1:Row
%       
        t(1:N, 1) = series(target_row, (lag+1):(lag+N))';
         
        b_opt = lassoglm(PHI, t, 'poisson')
        
%         % ADDED --> reference betas for Constrained optimization
%         betas_ref(target_row, :) = b_opt;

        betas_ref = b_opt;

        if isempty(b_opt)
            disp('Isempty');
            b_opt = zeros(Row, lag);
        end
        
        PR_coeffs{target_row} = vec2mat(b_opt, lag);
            
    end
     runtime = toc;
     fprintf('Penalized Regression runtime is: %.2f seconds. \n', runtime')



end
