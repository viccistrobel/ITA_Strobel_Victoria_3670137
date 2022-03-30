myNewton('function', @myFunc, 'startValue', 5, 'maxIter', 50, 'livePlot','on')
myNewton('function', @myFunc, 'derivative', @dmyFunc, 'startValue', 5, 'maxIter', 50, 'livePlot','on')