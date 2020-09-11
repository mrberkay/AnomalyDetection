function [ai] = KLDivergence(sd_ref,sd_test,mean_ref,mean_test, lambda_ref, lambda_test, I_normal, I_poisson)


% 5 Time series
ai = zeros(1,5);
% Counters for arrays
j = 1;
k = 1;

for target_row = 1:5

    
    if ismember(target_row, I_normal) == 1
        
            sd_r = sd_ref(j);
            sd_t = sd_test(j);
            mean_t = mean_test(j);
            mean_r = mean_ref(j);

            kldiv_rt = log(sd_t/sd_r) + ((mean_r - mean_t) + sd_r^2 - sd_t^2) / 2*(sd_t^2);
            kldiv_tr = log(sd_r/sd_t) + ((mean_t - mean_r) + sd_t^2 - sd_r^2) / 2*(sd_r^2);

            if(kldiv_rt > kldiv_tr)
                ai(target_row) = kldiv_rt;
            else
                ai(target_row) = kldiv_tr;
            end
            j = j + 1;
    end
  
    if ismember(target_row, I_poisson) == 1
        
            mean_t = lambda_test(k);
            mean_r = lambda_ref(k);

            kldiv_rt = mean_r * log(mean_r / mean_t) + mean_t - mean_r;
            kldiv_tr = mean_t * log(mean_t / mean_r) + mean_r - mean_t;

            if(kldiv_rt > kldiv_tr)
                ai(target_row) = kldiv_rt;
            else
                ai(target_row) = kldiv_tr;
            end
            k = k + 1;
    end
    
    
end




end