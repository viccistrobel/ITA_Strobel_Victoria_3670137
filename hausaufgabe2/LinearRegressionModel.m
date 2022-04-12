classdef LinearRegressionModel < matlab.mixin.SetGet
    %LINEARREGRESSIONMODEL Class representing an implementation of linear 
    % regression model
    %   
    % $Revision: R2022a$
    % $Author: Victoria Strobel$
    % $Date: April 12, 2022$
    %
    
    properties (Access = public)
        optimizer
        trainingData
        theta
        thetaOptimum
    end
    
    methods (Access = public)
        function obj = LinearRegressionModel(varargin)
            %LINEARREGRESSIONMODEL Construct an instance of this class
            %
            % Inputs:
            %   varargin - varargin contains the input data for the linear
            %   regression model
            %
            % Outputs:
            %   obj - LinearRegressionModel object
            %
            for i = 1:nargin
                if strcmp(varargin{i},'Optimizer')
                    obj.optimizer = varargin{i+1};
                elseif strcmp(varargin{i},'Data')
                    obj.trainingData = varargin{i+1};
                end
            end
            obj.initializeTheta();
        end
        
        function J = costFunction(obj)
            %COSTFUNCTION Calculate cost values for a training data
            %
            % Inputs:
            %   obj - LinearRegressionModel object
            %
            % Outputs:
            %   J - Cost value
            %
            m = obj.trainingData.numOfSamples; 
            J = (1 / (2 * m)) * sum(( obj.hypothesis - obj.trainingData.commandVar ).^2);
        end
        
        function hValue = hypothesis(obj)
            %HYPOTHESIS Calculate hypothesis for training data
            %
            % Inputs:
            %   obj - LinearRegressionModel object
            %
            % Outputs:
            %   J - Hypothesis values
            %
            X = [ones(obj.trainingData.numOfSamples,1) obj.trainingData.feature];
            hValue = X * [obj.theta(1); obj.theta(2)];
        end
        
        function h = showOptimumInContour(obj)
            %SHOWOPTIMUMINCONTOUR Show a figure that shows the optimization
            % and the optimum of a training
            %
            % Inputs:
            %   obj - LinearRegressionModel object
            %
            % Outputs:
            %   h - figure that shows optimization
            %
            h = figure('Name','Optimum');
            theta0_vals = linspace(50, 150, 100);
            theta1_vals = linspace(0, 2, 100);

            [X,Y] = meshgrid(theta0_vals, theta1_vals);

            Z = ones(length(theta0_vals), length(theta1_vals));

            for i=1:length(theta1_vals)
                for k=1:length(theta0_vals)
                    obj.setTheta(theta0_vals(i), theta1_vals(k))
                    
                    Z(i,k) = obj.costFunction;
                end
            end

            contour(X,Y,Z)
            hold on; 
            ylabel('\theta_{1}');
            xlabel('\theta_{0}');
            plot(obj.thetaOptimum(1), obj.thetaOptimum(2), 'MarkerSize', 10,'Color', 'red', 'LineWidth', 2, 'Marker', 'x');
        end
        
        function h = showCostFunctionArea(obj)
            %SHOWCOSTFUNCTIONAREA Calculate cost function for theta values
            % and show figure with results
            %
            % Inputs:
            %   obj - LinearRegressionModel object
            %
            % Outputs:
            %   h - figure that shows cost function
            %
            h = figure('Name','Cost Function Area');
            theta0_vals = linspace(50, 150, 100);
            theta1_vals = linspace(0, 2, 100);
            
            [X,Y] = meshgrid(theta0_vals, theta1_vals);
            Z = ones(length(theta0_vals), length(theta1_vals));
            
            for i=1:length(theta1_vals)
                for k=1:length(theta0_vals)
                    obj.setTheta(theta0_vals(k), theta1_vals(i))
                    
                    Z(i,k) = obj.costFunction;

                end
            end

            surf(X,Y,Z)
            ylabel('\theta_{1}');
            xlabel('\theta_{0}');  
        end
        
        function h = showTrainingData(obj)
           %SHOWTRANINGDATA Show figure with training data
           % 
           % Inputs:
           %   obj - LinearRegressionModel object
           %
           % Outputs:
           %   h = figure with traning data
           %
           h = figure('Name','Linear Regression Model');
           plot(obj.trainingData.feature,obj.trainingData.commandVar,'rx')
           grid on;
           xlabel(obj.trainingData.featureName + " in Kelvin");
           ylabel(obj.trainingData.commandVarName + " in Kelvin");
           legend('Training Data')
        end
        
        function h = showModel(obj)
           %SHOWMODEL Show figure with final trained linear regression 
           % model
           % 
           % Inputs:
           %   obj - LinearRegressionModel object
           %
           % Outputs:
           %   h = figure with final linear regression model
           %
           h = obj.showTrainingData();
           hold on;
           x = min(obj.trainingData.feature):max(obj.trainingData.feature);
           final = obj.thetaOptimum(2) * x  + obj.thetaOptimum(1);
           plot(x,final, 'b-');
           legend('Linear Regression Model')
        end
        
        function setTheta(obj,theta0,theta1)
            %SETTHETA Set theta tuple for a linear regression model
            %
            % Inputs:
            %   obj - LinearRegressionModel object
            %   theta0 - theta0 value for tuple
            %   theta1 - theta1 value for tuple
            %
            % Outputs: None
            %
            obj.theta = [theta0;theta1];
        end
        
        function setThetaOptimum(obj,theta0,theta1)
            %SETTHETAOPTIMUM Set optimum theta tuple for a linear 
            % regression model
            %
            % Inputs:
            %   obj - LinearRegressionModel object
            %   theta0 - optimum theta0 value for tuple
            %   theta1 - optimum theta1 value for tuple
            %
            % Outputs: None
            %
            obj.thetaOptimum = [theta0;theta1];
        end
    end
    
    methods (Access = private)
        
        function initializeTheta(obj)
            %INITIALIZETHETA Initialize theta tuple with start tuple (0,0)
            %
            % Inputs:
            %   obj - LinearRegressionModel object
            %
            % Outputs: None
            % 
            obj.setTheta(0,0);
        end
   
    end
end


