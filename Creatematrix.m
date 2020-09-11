function [X] = Creatematrix(series,p,n,d)

% INPUTS:
% 'series': a pxn matrix, p number of time series, n their length
% 'd':		Length of the lag

% OUTPUTS:
% Matrix X, the lagged matrix created  from series of dimension (n-d) x (p x d) 
% series have  dimension (p x d)x n 
% X = zeros(n-d, p*d);
% s=1;
% w=1;
%  while (s<=p*d)  
%      q=1;
%  while (q<=(n-d))     
%         X(q,w)= series(s,q+d);
%         q=q+1;
%     end
%     s= s+1;
%  end
% end

X = zeros(n-d, d*p);
r=1;
% r goes over the row indices locally  d, s over all row indices
s=1;
dd=d-1;
 while (r<=(n-d))
      j=1;
      dd=dd+1;
      s=1;
while (j<=p)
    ww=0;
     while (ww<=(d-1)) 
        X(r, s)= series(j,dd-ww);
        s=s+1; ww=ww+1;
    end
    j= j+1;
 end
 r= r+1;
 end
 X;
 end



