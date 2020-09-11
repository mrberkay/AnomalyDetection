function [AD_coeffs, betas_ref, runtime] = ...
        AD(time_series, lag, ref_indices, lambda, I_n, I_p)
    % process reference data
    disp('HGGM is running ...... ');
    ref_series = time_series(:, ref_indices);
    [AD_coeffs, betas_ref, runtime] = ts_lasso_regression(ref_series, lag, lambda, I_n, I_p);
    
    disp('HGGM is done ...... ');
end

function [AD_coeffs,betas_ref, runtime] = ts_lasso_regression(series, lag, lambda, I_n, I_p)
    
    tic;
        
    [Row, Column] = size(series);
    AD_coeffs = cell(Row, 1);
    

    % Row = number of time series or covariates
    % Column = number of observations
    D = Row * lag;
    N = Column - lag;
    
    %prepare design matrix which is useful for the linear combination part
    %of the lasso optimization problem
    % PHI is the preparing sum(X_lagged * B_i) , B_i is the lasso coefficients
    
    PHI = zeros(N,D);
    betas_ref = zeros(Row,D);

    t = zeros(N,1);
    for i = 1:N
        for j = 1:Row
            cur_row_start = (j-1)*lag+1;
            cur_row_end = cur_row_start + lag - 1;
            PHI(i, cur_row_start:cur_row_end) = series(j,i:(i+lag-1));           
        end
    end
       
    
    %do regression with each time series as target
    for target_row = 1:Row

        
        t(1:N, 1) = series(target_row, (lag+1):(lag+N))';
        
        %       We transform each x_i to W_i and do lasso on this transformation
        %       		t(1:N, 1) = W(target_row, (lag+1):(lag+N))';
        
        %t
        % if x_j is a gaussian time series
        if ismember(target_row, I_n) == 1

            model= glm_gaussian(t,PHI,'nointercept');
            options = statset(statset('glmfit'));
            options.MaxIter=100000;
            %b = glmfit(PHI,t,'normal','Options',options,'link','identity','constant','off');
            fit_CV_glmfit= cv_penalized(model, @p_lasso, 'lambdamax', lambda,'lambdaminratio', 0.01,'gamma',0.8);          
        end
        
        % if x_j is a poisson time series
        if ismember(target_row,I_p)==1

            model= glm_poisson(t,PHI,'nointercept');
            options = statset(statset('glmfit'));
            options.MaxIter=100000;
            b = glmfit(PHI,t,'poisson','Options',options,'link','log','constant','off');
            fit_CV_glmfit= cv_penalized(model, @p_adaptive, 'lambdamax', lambda,'lambdaminratio', 0.01,'gamma',0.8, 'adaptivewt',{b});
            
        end
  
        
       
        %b_opt is the optimal coefficients regarding AdLasso with glmfit
        %intial weights
        
        b_opt = fit_CV_glmfit.bestbeta;
        
        % ADDED --> reference betas for Constrained optimization
        betas_ref(target_row, :) = fit_CV_glmfit.bestbeta;
        
        if isempty(b_opt)
            disp('Isempty');
            b_opt = zeros(Row, lag);
        end
        
        AD_coeffs{target_row} = vec2mat(b_opt, lag);
            
    end
     runtime = toc;
     fprintf('AD runtime is: %.2f seconds. \n', runtime')
end
