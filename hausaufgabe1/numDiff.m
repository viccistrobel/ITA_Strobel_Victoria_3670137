function dfunc = numDiff(func, x, Method)
%% Function Name: numDiff
%
% Description: Function that calculates the derivative of a function
%
% Assumptions: None
%
% Inputs:
%    func - Polynom
%    x - Location to calculate the analytical derivative of func
%    Method - Method that is used to calculate the derivative
%
% Outputs:
%    dfunc - Derivative of polynom
%
% $Revision: R2022a$
% $Author: Victoria Strobel$
% $Date: March 30, 2022$
%
%%------------- BEGIN CODE --------------
    switch (Method)
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
        % error handling
        otherwise
            error('Invalid Method');
    end 
end
%------------- END OF CODE --------------