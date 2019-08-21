function P = fittingfunction(dF, IG)

% developed by Ibrahim Issah
% IG is the initial guess of the function 
% dF is the value of the function gained from the experiment

x = dF(1, :)'; 
y = dF(2, :)'; 

    function [merit_function] = fit(IG)
        
        a = IG(1); 
        b = IG(2); 
        c = IG(3); 
        d = IG(4); 
        
        f = (a.*exp(x.*b + c)+ d); 
        
        merit_function = sum(abs(f-y)); 
    end 

P = fminsearch(@fit, IG); 



end