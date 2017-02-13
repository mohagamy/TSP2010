clear;clc;
M = 500;
v = 0.2;
m = 0;
va = (exp(v)-1)*exp(2*m+v);
ma= exp(m+(v/2));
vw = (1/12);
mw = 0.5;


for i=1:1000
    
    a = exp(m + sqrt(v)*randn(1,M));
    w = rand(1,M);
    
    AF = sum(a.*w);
    Pi(i) = (abs(AF)).^2;
end

P = mean(Pi);


P_1 = M*(vw*va+vw*ma^2+mw^2*va) + M*(ma^2) + M*(mw^2);
[P P_1]








%
%
%
% clear;clc;
% M = 500;
% v = 0.2;
%
% for i=1:1000
%
%     va = (exp(v)-1)*exp(v);
%     a = exp(sqrt(v)*randn(1,M)) - exp(v/2);
%     ma = mean(a);
%
%
%     w = rand(1,M) - 0.5;
%     vw = (1/12);
%     mw = mean(w);
%
%     AF = sum(a.*w);
%
%     Pi(i) = (abs(AF)).^2;
% end
%
% P = mean(Pi);
%
%
% P_1 = M*(vw*va+vw*ma^2+mw^2*va)+M*(ma^2)+M*(mw^2);
% [P P_1]
%
%
%
%
%
%
%
%
%
%
%
