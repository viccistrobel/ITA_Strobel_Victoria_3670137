classdef GradientDescentOptimizer < matlab.mixin.SetGet
    %GRADIENTDESCENTOPTIMIZER Class to perform the training for a lineare 
    % regression Model
    %
    % $Revision: R2022a$
    % $Author: Victoria Strobel$
    % $Date: April 12, 2022$
    %
      
    properties (Access = private)
        costHistory
        learningRate
        maxIterations
    end
    
    methods (Access = public)
        function obj = GradientDescentOptimizer(varargin)
            %GRADIENTDESCENTOPTIMIZER Construct an instance of this class
            %
            % Inputs: 
            %   varargin - varargin contains the input data for the
            %   gradient descent
            %
            % Outputs:
            %   obj - GradientDescentOptimizer Object
            %
            for i = 1:nargin
                if strcmp(varargin{i},'LearningRate')
                    obj.learningRate = varargin{i+1};
                elseif strcmp(varargin{i},'MaxIterations')
                    obj.maxIterations = varargin{i+1};
                end
            end
        end

        function h = runTraining(obj, linearRegressionModel)
            %RUNTRAINING Optimize a Linear Regression Model by training
            %
            % Inputs:
            %   obj - GradientDescentOptimizer object
            %   linearRegressionModel - Linear Regression Model that is
            %   trained
            %
            % Outputs:
            %   h - Figure that shows the training result
            %
            [alpha,maxIters,theta,X,y,m,costOverIters] = obj.getLocalsForTraining(linearRegressionModel);
                      
            % optimization loop
            for i=1:maxIters
                theta = theta - alpha * (1 / m) * (X' * (X * theta - y));
                linearRegressionModel.setTheta(theta(1), theta(2));
                costOverIters(i) =  linearRegressionModel.costFunction();
            end
            
            obj.costHistory = costOverIters;
            linearRegressionModel.setThetaOptimum(theta(1),theta(2));
            h = obj.showTrainingResult();
        end
        
        function h = showTrainingResult(obj)
            %SHOWTRAININGRESULT Show a figure with the costs over
            % iterations during the traning
            %
            % Inputs:
            %   obj - GradientDescentOptimizer object
            %
            % Outputs:
            %   h - Figure that shows the training result
            %
            h = figure('Name','Costs over Iterations during training');
            plot(obj.costHistory,'x-');
            xlabel('Iterations'); ylabel('costs');
            grid on;
            xlim([2500 obj.maxIterations]);
        end
        
        function setLearningRate(obj, alpha)
           %SETLEARNINGRATE Set the learning rate for the training
           %
           % Inputs:
           %   obj - GradientDescentOptimizer object
           %   alpha - Learning rate for training
           % 
           % Outputs: None
           % 
           obj.learningRate = alpha;
        end
        
        function setMaxNumOfIterations(obj, maxIters)
           %SETMAXNUMOFITERATIONS Set the maximum iterations for the 
           % training
           %
           % Inputs:
           %   obj - GradientDescentOptimizer object
           %   maxIters - Maximum Interations for training
           % 
           % Outputs: None
           % 
           obj.maxIterations = maxIters;
        end
    end
    
    methods (Access = private) 
       function [alpha,maxIters,theta,X,y,m,costOverIters] = getLocalsForTraining(obj,linearRegressionModel)
            %GETLOCALSFORTRANING Get local variables for the training
            %
            % Inputs:
            %   obj - GradientDescentOptimizer object
            %   linearRegressionModel - Linear Regression Model that is
            %   trainer
            % 
            % Outputs:
            %   [alpha,maxIters,theta,X,y,m,costOverIters] - local
            %   training variables for the training
            % 
            m = linearRegressionModel.trainingData.numOfSamples;
            theta = linearRegressionModel.theta;
            X = [ones(m,1) linearRegressionModel.trainingData.feature];
            alpha = obj.learningRate;
            y = linearRegressionModel.trainingData.commandVar;
            costOverIters = zeros(obj.maxIterations, 1);
            maxIters = obj.maxIterations;
        end 
    end
end

