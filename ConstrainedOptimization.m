function [solution,fval,exitflag,output,lambda, CO_coeffs] = ConstrainedOptimization(series, betas_ref, lag,...
                                                                    Epsilon, p, delta, I_normal, I_poisson)

tic;

[Row, Column] = size(series);
CO_coeffs = cell(Row, 1);

% Row = number of time series or covariates
% Column = number of observations
D = Row * lag;
N = Column - lag;

    
    % use Creatematrix.m for creating design Matrix
    X = Creatematrix(series, Row, Column, lag);
    
    xi = zeros(N,1);
    

    solution = zeros(D,Row);
    
  for target_row = 1:Row

        % for each iteration change xi (assign next lagged time serie)
        xi(1:N, 1) = series(target_row, (lag+1):(lag+N))';
        
        % For Normal Distributions
        if ismember(target_row, I_normal) == 1
            
            fun = @(beta)ObjectiveNormal(beta, X, xi);
            % for each iteration change betas_ref
            betas_ref_vector = betas_ref(target_row,:);
            % Constraint g3 is emtpy for Normal distributions
            A = [];
            b = [];
            % Constraint g1 and g2
            lb = -(Epsilon / p) + betas_ref_vector;
            ub = (Epsilon / p)  + betas_ref_vector;           
            
        end
        
        % For Poisson Distributions
        if ismember(target_row, I_poisson) == 1           
            
            fun = @(beta)ObjectivePoisson(beta, X, xi);
            % for each iteration change betas_ref
            betas_ref_vector = betas_ref(target_row,:);
            % Constraint g3 for Poisson Distributions
            A = -X;
            b = repmat(-delta, size(A,1), 1)';
            % Constraint g1 and g2
            lb = -(Epsilon / p) + betas_ref_vector;
            ub = (Epsilon / p)  + betas_ref_vector;
            
        end     
        
        
        % initial value --> control variables
        %x0 = zeros(D,1);
        %x0 = ones(D,1);
        x0 = betas_ref_vector';
        %x0 = repmat(50,D,1);
        

        Aeq = [];
        beq = [];
        nonlcon = [];
        
        % modify options
        options = optimoptions(@fmincon, 'Display', 'off');
       
        [x,fval,exitflag,output,lambda] = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon,options);
        
        %output
        
        solution(:, target_row) = x;

        if isempty(x)
            disp('Isempty');
            x = zeros(Row, lag);
        end
        
        CO_coeffs{target_row} = vec2mat(x, lag);
            
  end


     runtime = toc;
     fprintf('Constrained Optimization runtime is: %.2f seconds. \n', runtime')
end
