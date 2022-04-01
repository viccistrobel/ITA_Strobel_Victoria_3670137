%% File Name: runMyNewton
%
% Description: file that runs the myNewton function with different test data
%
% Assumptions: none
%
% Inputs: none
%
% Outputs: none
%
% $Revision: R2022a$
% $Author: Victoria Strobel$
% $Date: March 30, 2022$
%
%%------------- BEGIN CODE --------------

myNewton('function', @myFunc, 'startValue', 5, 'maxIter', 50, 'livePlot','on')
myNewton('function', @myFunc, 'derivative', @dmyFunc, 'startValue', 5, 'maxIter', 50, 'livePlot','on')

%------------- END OF CODE --------------
