classdef LinearRegressionDataFormatter < matlab.mixin.SetGet
    %LINEARREGRESSIONDATAFORMATTER Class to model the training data for 
    % linear regression model object
    %
    %
    % $Revision: R2022a$
    % $Author: Victoria Strobel$
    % $Date: April 12, 2022$
    %
   
    properties (Access = public)
        feature
        featureName
        commandVar
        commandVarName
        numOfSamples
    end
    
    properties (Access = private)
        data
    end
    
    methods (Access = public)
        function obj = LinearRegressionDataFormatter(varargin)
            %LINEARREGRESSIONDATAFORMATTER Construct an instance of this 
            % class
            %
            % Inputs:
            %   varagin - varargin contains the input data for the linear
            %   regression
            %
            % Outputs:
            %   obj - model object that contains all the necessary data for 
            %   the linear regression
            %
            for i = 1:nargin
                if strcmp(varargin{i},'Data')
                    obj.data = importdata(varargin{i+1});
                elseif strcmp(varargin{i},'Feature')
                    obj.featureName = varargin{i+1};
                elseif strcmp(varargin{i},'CommandVar')
                    obj.commandVarName = varargin{i+1};
                end
            end
            
            obj.mapFeature();
            obj.mapCommandVar();
            obj.mapNumOfSamples();
        end
    end
    
    methods (Access = private)
        function mapFeature(obj)
            %MAPFEATURE Map the feature traning data
            %
            % Inputs:
            %   obj - LinearRegressionDataFormatter object
            % 
            % Outputs: None
            %
            obj.feature = obj.data.(obj.featureName);
        end
        
        function mapCommandVar(obj)
            %MAPFEATURE Map the command traning data
            %
            % Inputs:
            %   obj - LinearRegressionDataFormatter object
            % 
            % Outputs: None
            %
            obj.commandVar = obj.data.(obj.commandVarName);
        end
        
        function mapNumOfSamples(obj)
            %MAPFEATURE Map the number of samples for traning
            %
            % Inputs:
            %   obj - LinearRegressionDataFormatter object
            % 
            % Outputs: None
            %
            obj.numOfSamples = length(obj.feature); 
        end
    end
end

