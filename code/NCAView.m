classdef NCAView < handle
    
    properties ( Access = private )
        NCApanel
        GridLayout
        Model
    end

    properties ( Hidden )
        % Leave these properties Hidden but public to enable access for any test generated
        % with Copilot during workshop
        NCAtable
    end

    properties ( Access = public ) 
        FontName                (1,1) string = "Helvetica"
        NCAoptions              % options for NCA calculations
    end

    properties (SetObservable)
        ConcentrationColumnName (1,1) string = "Complex"
        BackgroundColor (1,3) double {mustBeBetween(BackgroundColor,0,1)} = [1,1,1]
    end

    properties( Access = private )
        DataListener % listener
    end
    
    methods
        function obj = NCAView(parent, model, responseName)

            arguments
                parent 
                model (1,1) SimulationModel
                responseName (1,1) string = "Complex"
            end
            
            % Create Panel
            ncapanel = uipanel(parent);
            ncapanel.BackgroundColor = obj.BackgroundColor;
            ncapanel.FontName = obj.FontName;
            ncapanel.BorderType = 'none';

            % Create GridLayout
            gl = uigridlayout(ncapanel);
            gl.ColumnWidth = {'1x'};
            gl.RowHeight = {'1x'};
            gl.Padding = [0 0 0 0];
            gl.BackgroundColor = obj.BackgroundColor;

            % Create NCAtable
            ncat = uitable(gl);
        
            % Save NCA options 
            opt = sbioncaoptions;
            opt.concentrationColumnName = responseName;
            opt.timeColumnName          = 'Time';
            opt.IVDoseColumnName        = 'Dose';
            
            % Save objects
            obj.NCAoptions = opt;
            obj.NCApanel = ncapanel;
            obj.GridLayout = gl;
            obj.NCAtable = ncat;
            obj.Model = model;
            obj.ConcentrationColumnName = responseName;

            % Update Panel title
            updateTitle(obj);

            % Instantiate listener for model
            obj.DataListener = event.listener( model, 'DataChanged', ...
                @obj.update );

            % Instantiate listeners for properties
            addlistener(obj,'ConcentrationColumnName','PostSet',@obj.setColumnName);
            addlistener(obj,'BackgroundColor','PostSet',@obj.setColor);

        end % constructor
   
    end % public methods
    
    methods ( Access = private )
        
        function update(obj,srcModel,~)
            % compute NCA parameters and display them in table
            ncaParameters = sbionca(srcModel.SimDataTable, obj.NCAoptions);
            obj.NCAtable.ColumnName = ncaParameters.Properties.VariableNames(2:end);
            obj.NCAtable.Data = ncaParameters(:,2:end);        
        end % update

        function setColor(obj,~,~)
            obj.NCApanel.BackgroundColor = obj.BackgroundColor;
            obj.GridLayout.BackgroundColor = obj.BackgroundColor;
        end % setColor

        function setColumnName(obj,~,~)
            obj.NCAoptions.concentrationColumnName = obj.ConcentrationColumnName;
            update(obj,obj.Model,[]);
            updateTitle(obj)
        end % setColumnName

        function updateTitle(obj)
            obj.NCApanel.Title = "NCA parameters for species '" + ...
                obj.ConcentrationColumnName + "'";
        end % updateTitle

    end % private method

end % class

