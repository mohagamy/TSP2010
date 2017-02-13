function [xCCDF,yCCDF] = myccdf(x)
% this is my modification of CDFplot function

% Get sample cdf, display error message if any
[yy,xx,n,emsg,eid] = cdfcalc(x);
if ~isempty(eid)
   error(sprintf('stats:cdfplot:%s',eid),emsg);
end

% Create vectors for plotting
k = length(xx);
n = reshape(repmat(1:k, 2, 1), 2*k, 1);
xCCDF    = [-Inf; xx(n); Inf];
yCCDF    = 1-[0; 0; yy(1+n)];
