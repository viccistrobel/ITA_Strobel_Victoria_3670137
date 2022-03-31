function dfunc = numDiff(func, x, method)
%% Function Name: numDiff
%
% Description: function that calculates the analytical derivative of a
% function for a value x
%
% Assumptions: none
%
% Inputs:
%    func - polynom
%    x - location to calculate the analytical derivative of func
%    method - method that is used to calculate the derivative: 
%               1: Forward
%               2: Backwards
%               3: Central
%
% Outputs:
%    dfunc - derivative of polynom for value x
%
% $Revision: R2022a$
% $Author: Victoria Strobel$
% $Date: March 30, 2022$
%
%%------------- BEGIN CODE --------------
switch (method)
    % forward
    case 1
        h = 10.^-8;
        dfunc = (func(x+h) - func(x)) / h;
    % backwards
    case 2
        h = 10.^-8;
        dfunc = (func(x) - func(x-h)) / h;
    % central
    case 3
        h = 10.^-6;
        dfunc = (func(x+h) - func(x-h)) / (2*h);
    % invalid method
    otherwise
        error('Invalid method');
end 
end
%------------- END OF CODE --------------