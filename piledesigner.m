function varargout = piledesigner(varargin)
% PILEDESIGNER MATLAB code for piledesigner.fig
%      PILEDESIGNER, by itself, creates a new PILEDESIGNER or raises the existing
%      singleton*.
%
%      H = PILEDESIGNER returns the handle to a new PILEDESIGNER or the handle to
%      the existing singleton*.
%
%      PILEDESIGNER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PILEDESIGNER.M with the given input arguments.
%
%      PILEDESIGNER('Property','Value',...) creates a new PILEDESIGNER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before piledesigner_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to piledesigner_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help piledesigner

% Last Modified by GUIDE v2.5 12-Jun-2020 19:28:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @piledesigner_OpeningFcn, ...
                   'gui_OutputFcn',  @piledesigner_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

% End initialization code - DO NOT EDIT


% --- Executes just before piledesigner is made visible.
function piledesigner_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to piledesigner (see VARARGIN)

%number of runs is set to zero, which will be updated in each design in GUI
handles.number_of_run=0;


handles.PB_create_soil_profile.Visible='off';
handles.TBL_data.Visible='off';
handles.axes_soil_profile_creator.Visible='off';
handles.PNL_invisible_soil_profile.Visible='off';
handles.PNL_soil_profile_creator.Visible='off';                            %making panels initially invisible
handles.PNL_pile_input.Visible='off';
handles.PNL_pile_designer.Visible='off';
handles.PNL_3D_viewer.Visible='off';
handles.PNL_reinforcement_drawing.Visible='off';
handles.PNL_cost_analysis.Visible='off';


% Setting zero values to radio buttons (PNL_pile_input)
handles.BG_driven_pile_material.Visible='off';         %All visibility of subpanels are 'off'.
handles.BG_bored_pile_material.Visible='off';
handles.BG_driven_steel_pile_shape.Visible='off';
handles.BG_driven_conrete_pile_shape.Visible='off';
handles.BG_bored_conrete_pile_shape.Visible='off';

handles.RB_bored_pile.Value=0;
handles.RB_driven_pile.Value=0;
handles.RB_steel.Value=0;
handles.RB_driven_concrete.Value=0;
handles.RB_bored_concrete.Value=0;
%Logo in login screen
axes(handles.axes_logo);
company_logo=imread('pile_designer_logo.png');
image(company_logo);
axis off
axis image

%Giving zero values to toggle buttons of panels
handles.TB_soil_profile_creator.Value=0;
handles.TB_pile_input.Value=0;
handles.TB_pile_designer.Value=0;
handles.TB_3D_viewer.Value=0;
handles.TB_reinforcement_drawing.Value=0;
handles.TB_cost_analysis.Value=0;
%For Error Box, all values are introduced to Matlab
handles.pile.type='';
handles.pile.material='';
handles.pile.shape='';
handles.building.short_length=[];    
handles.building.long_length=[];
handles.building.max_settlement=[];
handles.building.force=[];
handles.factor_of_safety=[];
handles.concrete_ck=[];
handles.steel_ck=[];
handles.spiral_steel_ck=[];
handles.cc_concrete_unit_cost=[];
handles.cc_spiral_unit_cost=[];
handles.cc_long_steel_unit_cost=[];
handles.sc_steel_unit_cost=[];
handles.gwt=[];
handles.h1 = rotate3d(handles.axes_3D_viewer);
handles.h2 = rotate3d(handles.axes_settle3d);
% Choose default command line output for piledesigner
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes piledesigner wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = piledesigner_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function EDT_force_Callback(hObject, eventdata, handles)
% hObject    handle to EDT_force (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EDT_force as text
%        str2double(get(hObject,'String')) returns contents of EDT_force as a double
handles.building.force=str2double(get(hObject,'String'));
guidata(hObject, handles);
% --- Executes during object creation, after setting all properties.
function EDT_force_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EDT_force (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EDT_short_length_Callback(hObject, eventdata, handles)
% hObject    handle to EDT_short_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EDT_short_length as text
%        str2double(get(hObject,'String')) returns contents of EDT_short_length as a double
handles.building.short_length=str2double(get(hObject,'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function EDT_short_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EDT_short_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function EDT_long_length_Callback(hObject, eventdata, handles)
% hObject    handle to EDT_long_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EDT_long_length as text
%        str2double(get(hObject,'String')) returns contents of EDT_long_length as a double
handles.building.long_length=str2double(get(hObject,'String'));
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function EDT_long_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EDT_long_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TXT_cohesion_Callback(hObject, eventdata, handles)
% hObject    handle to TXT_cohesion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TXT_cohesion as text
%        str2double(get(hObject,'String')) returns contents of TXT_cohesion as a double


% --- Executes during object creation, after setting all properties.
function TXT_cohesion_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TXT_cohesion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TXT_friction_angle_Callback(hObject, eventdata, handles)
% hObject    handle to TXT_friction_angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TXT_friction_angle as text
%        str2double(get(hObject,'String')) returns contents of TXT_friction_angle as a double


% --- Executes during object creation, after setting all properties.
function TXT_friction_angle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TXT_friction_angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when entered data in editable cell(s) in uitable2.
function uitable2_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable2 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)



function EDT_layer_Callback(hObject, eventdata, handles)
% hObject    handle to EDT_layer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


layer_number=str2double(get(hObject,'String'));
handles.TBL_data.Visible='on';
handles.PB_create_soil_profile.Visible='on';



Ncolumns=4;
Nrows=layer_number;
set(handles.TBL_data,'Data',cell(Nrows,Ncolumns));
handles.TBL_data.ColumnName={'Layer Thickness(m)','Soil Type','Average SPT-N','Plasticity Index'};
handles.TBL_data.Data={0,'Choose',0,0};
handles.TBL_data.ColumnEditable=true; 
handles.TBL_data.ColumnWidth='auto';
handles.TBL_data.ColumnFormat={[] {'Clay', 'Silt','Silty Sand','Clayey Sand','Clean Sand'}}; %Clayey sand and Silty sand inputs will be directed to same place

data=get(handles.TBL_data,'data');
for index_layer=1:layer_number
    data(index_layer,:)={0,'Choose',0,0};
    set(handles.TBL_data,'data',data);
end
handles.layer_number=layer_number;
guidata(hObject, handles);

% Hints: get(hObject,'String') returns contents of EDT_layer as text
%        str2double(get(hObject,'String')) returns contents of EDT_layer as a double


% --- Executes during object creation, after setting all properties.
function EDT_layer_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EDT_layer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected cell(s) is changed in uitable2.
function uitable2_CellSelectionCallback(hObject, eventdata, handles)
A=5;
% hObject    handle to uitable2 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object deletion, before destroying properties.
function TBL_data_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to TBL_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when entered data in editable cell(s) in TBL_data.
function TBL_data_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to TBL_data (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when selected cell(s) is changed in TBL_data.
function TBL_data_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to TBL_data (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function EDT_gwt_Callback(hObject, eventdata, handles)
% hObject    handle to EDT_gwt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EDT_gwt as text
gwt=str2double(get(hObject,'String'));
handles.gwt=abs(gwt);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function EDT_gwt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EDT_gwt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function PNL_soil_profile_creator_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PNL_soil_profile_creator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in PB_create_soil_profile.
function PB_create_soil_profile_Callback(hObject, eventdata, handles)
% hObject    handle to PB_create_soil_profile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty(handles.gwt)
    err = errordlg('Ground water depth is not specified ! ','Input Error Code:0');
    return
end


soil_input_cell=handles.TBL_data.Data;
layer_number=handles.layer_number;
total_depth=sum(cell2mat(soil_input_cell(:,1)));
handles.total_depth=total_depth;
total_depth_row=10*total_depth;
unit_weight_matrix=zeros(total_depth_row,3);

depth_start=0;
for i=1:1:layer_number                                                      %By using this loop, interval of layer is determined.
    depth_end=depth_start+soil_input_cell{i,1};                             
    depth_intervals(i,1)=depth_start;
    depth_intervals(i,2)=depth_end;
    depth_intervals(i,3)=(depth_intervals(i,1)+depth_intervals(i,2))/2;     %In this column, avergae layer depth is decided to be used in rod length correction.
    
    if depth_intervals(i,3) < 4                                             %Rod length correction factors are calculated.
        depth_intervals(i,4)=0.75;
    elseif depth_intervals(i,3) < 6
        depth_intervals(i,4)=0.85;
    elseif depth_intervals(i,3) < 10
        depth_intervals(i,4)=0.95;
    else
        depth_intervals(i,4)=1;
    end
    depth_start=depth_end;
end
i=1; 
for index_layer=1:layer_number
    if soil_input_cell{index_layer,2}=="Choose"
        err = errordlg(strcat('Soil type is not specified for Layer ',num2str(index_layer),' !'),'Input Error Code:0-2');
        return
    elseif soil_input_cell{index_layer,1}==0
        err = errordlg(strcat('Layer thickness is not specified for Layer ',num2str(index_layer),' !'),'Input Error Code:0-1');
        return
    elseif soil_input_cell{index_layer,3}==0
        err = errordlg(strcat('SPT number is not specified for Layer ',num2str(index_layer),' !'),'Input Error Code:0-3');
        return
    end
    soil_type=soil_input_cell{index_layer,2};
    if ((soil_type=="Clay") || (soil_type=="Silt"))&& (soil_input_cell{index_layer,4}==0)
        err = errordlg(strcat('PI cannot be zero for Layer ',num2str(index_layer),' !'),'Input Error Code:0-4');
        return
    end
    sptn=soil_input_cell{index_layer,3};
    PI=soil_input_cell{index_layer,4};
    sptn60=0.75*sptn*depth_intervals(index_layer,4);
    sptn55=sptn60*60/55;
    handles.soil_parameters(index_layer).type=soil_type;
    switch soil_type
        case 'Clay'  
            %Unit weight correlations (Cetin_2016)
            if sptn60<=4
                handles.soil_parameters(index_layer).dry_unit_weight=16;
                handles.soil_parameters(index_layer).sat_unit_weight=17.6;
            elseif sptn60<=8
                handles.soil_parameters(index_layer).dry_unit_weight=17.6;
                handles.soil_parameters(index_layer).sat_unit_weight=19.2;
            else 
                handles.soil_parameters(index_layer).dry_unit_weight=18.4;
                handles.soil_parameters(index_layer).sat_unit_weight=20;
            end
            handles.soil_parameters(index_layer).classification='0';       %avoiding NaN values in struct
            handles.soil_parameters(index_layer).relative_density=0;
            handles.soil_parameters(index_layer).friction_angle=0;
            handles.soil_parameters(index_layer).Es=0;
            
            %cohesion correlations (Straut_1974)
            if PI<=20
                handles.soil_parameters(index_layer).cohesion=6.5*sptn60;
            elseif PI<=30
                handles.soil_parameters(index_layer).cohesion=4.5*sptn60;
            else 
                handles.soil_parameters(index_layer).cohesion=4.2*sptn60;
            end
            %poisson ratio correlations (CE366_p59)
            if sptn60<=8
                handles.soil_parameters(index_layer).poisson=0.5;
            else
                handles.soil_parameters(index_layer).poisson=0.2;
            end
            %Eu correlations (Butler_1975)
             handles.soil_parameters(index_layer).E_undrained=1200*sptn60;
             
            %mv volume compressibility coefficient (Straud, 19)
            if PI<12
                 handles.soil_parameters(index_layer).mv=1/(800*sptn60);
            elseif PI<40
                F2=-3*10^-5*PI^3+0.003*PI^2-0.0991*PI+1.5764;
                handles.soil_parameters(index_layer).mv=1/(F2*1000*sptn60);
            else 
                 handles.soil_parameters(index_layer).mv=1/(450*sptn60);
            end
            %Classification (Clayton,1993)
            if sptn60<4
               handles.soil_parameters(index_layer).classification='very soft';
            elseif sptn60<8
               handles.soil_parameters(index_layer).classification='soft';
            elseif sptn60<15
               handles.soil_parameters(index_layer).classification='stiff';
            elseif sptn60<30
                handles.soil_parameters(index_layer).classification='very stiff';
            elseif sptn60<60
                handles.soil_parameters(index_layer).classification='hard';
            else
                handles.soil_parameters(index_layer).classification='very hard';
            end
        case 'Silt'
            %Unit weight correlations (Cetin_2016)
            sptn60=0.75*sptn;
            sptn55=sptn60*60/55;
            if sptn60<=4
                handles.soil_parameters(index_layer).dry_unit_weight=16;
                handles.soil_parameters(index_layer).sat_unit_weight=17.6;
            elseif sptn60<=8
                handles.soil_parameters(index_layer).dry_unit_weight=17.6;
                handles.soil_parameters(index_layer).sat_unit_weight=19.2;
            else 
                handles.soil_parameters(index_layer).dry_unit_weight=18.4;
                handles.soil_parameters(index_layer).sat_unit_weight=20;
            end
             depth_layer_row=10*soil_input_cell{index_layer,1};

            handles.soil_parameters(index_layer).classification='0';       %avoiding NaN values in struct
            handles.soil_parameters(index_layer).relative_density=0;
            handles.soil_parameters(index_layer).friction_angle=0;
            handles.soil_parameters(index_layer).Es=0;
        
           %cohesion correlations (Straut_1974)
            if PI<=20
                handles.soil_parameters(index_layer).cohesion=6.5*sptn60;
            elseif PI<=30
                handles.soil_parameters(index_layer).cohesion=4.5*sptn60;
            else 
                handles.soil_parameters(index_layer).cohesion=4.2*sptn60;
            end
            %poisson ratio correlations
            handles.soil_parameters(index_layer).poisson=0.3;
            %Eu correlations (Butler_1975)
             handles.soil_parameters(index_layer).E_undrained=1200*sptn60;
             
            %mv volume compressibility coefficient (Straud, 19)
            if PI<12
                handles.soil_parameters(index_layer).mv=1/(800*sptn60);
            elseif PI<40
                F2=-3*10^-5*PI^3+0.003*PI^2-0.0991*PI+1.5764;
                handles.soil_parameters(index_layer).mv=1/(F2*1000*sptn60);
            else 
                handles.soil_parameters(index_layer).mv=1/(450*sptn60);
            end
             %Classification (Clayton,1993)
            if sptn60<4
               handles.soil_parameters(index_layer).classification='very soft';
            elseif sptn60<8
               handles.soil_parameters(index_layer).classification='soft';
            elseif sptn60<15
               handles.soil_parameters(index_layer).classification='stiff';
            elseif sptn60<30
               handles.soil_parameters(index_layer).classification='very stiff';
            elseif sptn60<60
               handles.soil_parameters(index_layer).classification='hard';
            else
               handles.soil_parameters(index_layer).classification='very hard';
            end
             
        case {'Silty Sand','Clayey Sand'}
            %unit weight correlation (Cetin,2016)
            if sptn60<=4
                handles.soil_parameters(index_layer).dry_unit_weight=16;
                handles.soil_parameters(index_layer).sat_unit_weight=17.6;
            elseif sptn60<=10
                handles.soil_parameters(index_layer).dry_unit_weight=17.6;
                handles.soil_parameters(index_layer).sat_unit_weight=19.2;
            elseif sptn60<=30
                handles.soil_parameters(index_layer).dry_unit_weight=19.2;
                handles.soil_parameters(index_layer).sat_unit_weight=20;
            else
                handles.soil_parameters(index_layer).dry_unit_weight=20;
                handles.soil_parameters(index_layer).sat_unit_weight=21.6;
            end
            
            handles.soil_parameters(index_layer).cohesion=0;               %added because of NaN values in struct
            handles.soil_parameters(index_layer).E_undrained=0;
            
             %classification and relative density (Terzaghi Peck,1967) 
             if sptn<=4
                 handles.soil_parameters(index_layer).classification='very loose';
                 handles.soil_parameters(index_layer).relative_density=3.75*sptn;
             elseif sptn<=10
                 handles.soil_parameters(index_layer).classification='loose';
                 handles.soil_parameters(index_layer).relative_density=15+3.33*(sptn-4);
             elseif sptn<=30
                 handles.soil_parameters(index_layer).classification='medium dense';
                 handles.soil_parameters(index_layer).relative_density=35+1.5*(sptn-10);
             elseif sptn<=50
                 handles.soil_parameters(index_layer).classification='dense';
                 handles.soil_parameters(index_layer).relative_density=35+sptn;
             else
                 handles.soil_parameters(index_layer).classification='very dense';
                 handles.soil_parameters(index_layer).relative_density=85;
             end
             %poissons ratio correlations (CE366 notes, p59)
             handles.soil_parameters(index_layer).poisson=0.3;
             
             %friction angle correlations (Bowles,1996)
             friction_angle_bowles=28+0.15*handles.soil_parameters(index_layer).relative_density;
             %friction angle correlations (Hatakanda Uchida, 1996)
             friction_angle_hatakanda=3.5*sqrt(sptn)+22.3;
             %averaging the correlations
             handles.soil_parameters(index_layer).friction_angle=(friction_angle_bowles+friction_angle_hatakanda)/2;
             
             %Es correlation 1 (Mayne,1990)
             Es_mayne=500*sptn60;
             %Es correlation 2 (Bowles,1996)
             Es_bowles=300*(sptn55*+6);
             %average of Es correlations
             handles.soil_parameters(index_layer).Es=(Es_mayne+Es_bowles)/2;
             
             %volume compressibility coefficient 
             handles.soil_parameters(index_layer).mv=0;
             
         case {'Clean Sand'}
            %unit weight correlation (Cetin,2016)
            if sptn60<=4
                handles.soil_parameters(index_layer).dry_unit_weight=16;
                handles.soil_parameters(index_layer).sat_unit_weight=17.6;
            elseif sptn60<=10
                handles.soil_parameters(index_layer).dry_unit_weight=17.6;
                handles.soil_parameters(index_layer).sat_unit_weight=19.2;
            elseif sptn60<=30
                handles.soil_parameters(index_layer).dry_unit_weight=19.2;
                handles.soil_parameters(index_layer).sat_unit_weight=20;
            else
                handles.soil_parameters(index_layer).dry_unit_weight=20;
                handles.soil_parameters(index_layer).sat_unit_weight=21.6;
            end
            handles.soil_parameters(index_layer).cohesion=0;                %avoiding NaN values in struct
            handles.soil_parameters(index_layer).E_undrained=0;
             %classification and relative density (Terzaghi Peck,1967) 
             if sptn<=4
                 handles.soil_parameters(index_layer).classification='very loose';
                 handles.soil_parameters(index_layer).relative_density=3.75*sptn;
             elseif sptn<=10
                 handles.soil_parameters(index_layer).classification='loose';
                 handles.soil_parameters(index_layer).relative_density=15+3.33*(sptn-4);
             elseif sptn<=30
                 handles.soil_parameters(index_layer).classification='medium dense';
                 handles.soil_parameters(index_layer).relative_density=35+1.5*(sptn-10);
             elseif sptn<=50
                 handles.soil_parameters(index_layer).classification='dense';
                 handles.soil_parameters(index_layer).relative_density=35+sptn;
             else
                 handles.soil_parameters(index_layer).classification='very dense';
                 handles.soil_parameters(index_layer).relative_density=85;
             end
             %poissons ratio correlations (CE366 notes, p59)
             handles.soil_parameters(index_layer).poisson=0.2;
             
             %friction angle correlations (Bowles,1996)
             friction_angle_bowles=28+0.15*handles.soil_parameters(index_layer).relative_density;
             %friction angle correlations (Hatakanda Uchida, 1996)
             friction_angle_hatakanda=3.5*sqrt(sptn)+22.3;
             %averaging the correlations
             handles.soil_parameters(index_layer).friction_angle=(friction_angle_bowles+friction_angle_hatakanda)/2;
                         
             %Es correlation 1 (Mayne,1990)
             Es_mayne=2*500*sptn60;
             %Es correlation 2 (Bowles,1996)
             Es_bowles=2600*sptn55;
             %average of Es correlations
             handles.soil_parameters(index_layer).Es=(Es_mayne+Es_bowles)/2;
             
             %volume compressibility coefficient 
             handles.soil_parameters(index_layer).mv=0;
    end    
end

cla(handles.axes_soil_profile_creator);
                                                                            %this plot command is useful for obtaning mouse clicks
set(handles.axes_soil_profile_creator,'XLim',[0 40]);
set(handles.axes_soil_profile_creator,'YLim',[-1*total_depth 0]);
handles.axes_soil_profile_creator.Visible='on';
handles.PNL_invisible_soil_profile.Visible='on';
depth_rectangle=total_depth*-1;
handles.axes_soil_profile_creator.HitTest='on';
handles.axes_soil_profile_creator.PickableParts='all';

handles.axes_soil_profile_creator.XAxis.Visible = 'off';
for i=layer_number:-1:1
    matrix_color=0.3+0.7*rand(1,3);
    layer_thickness=cell2mat(soil_input_cell(i,1));
    handles.soil_parameters(i).layer_thickness=layer_thickness;
    rectangle('Position', [0 depth_rectangle 40 layer_thickness],...
        'FaceColor',matrix_color,...
        'Parent', handles.axes_soil_profile_creator,'userdata',i,'ButtonDownFcn',@see_soil_properties);
    text(20, (depth_rectangle+layer_thickness/2) ,handles.soil_parameters(i).type, 'horizontalAlignment', 'center',...
        'verticalAlignment', 'middle','Parent',handles.axes_soil_profile_creator);
    depth_rectangle=depth_rectangle+layer_thickness;
    handles.matrix_color(i).color=matrix_color;
    
end
line([0 40],[-1*handles.gwt -1*handles.gwt],'Color','blue','LineStyle','--','Parent',handles.axes_soil_profile_creator,'HitTest','off','PickableParts','none');
line([2.5 5],[-1*handles.gwt+total_depth/20 -1*handles.gwt+total_depth/20],'Color','blue','Parent',handles.axes_soil_profile_creator,'HitTest','off','PickableParts','none');  
line([3.75 5],[-1*handles.gwt -1*handles.gwt+total_depth/20],'Color','blue','Parent',handles.axes_soil_profile_creator,'HitTest','off','PickableParts','none');
line([2.5 3.75],[-1*handles.gwt+total_depth/20 -1*handles.gwt],'Color','blue','Parent',handles.axes_soil_profile_creator,'HitTest','off','PickableParts','none');


guidata(hObject, handles);

function see_soil_properties(gcbo, EventData, handles)
handles=guidata(gcbo);
index_layer=get(gcbo,'userdata');
figure_name=['Soil Layer ',num2str(index_layer)];
layer_color=handles.matrix_color(index_layer).color;
properties_figure=figure('Name',figure_name,'NumberTitle','off','MenuBar','none','ToolBar','none','DockControls','on','Color',layer_color,'Units','normalized','OuterPosition',[0.25 0.25 0.25 0.25],'Resize','off','WindowStyle','modal');          %heading of properties
a=axes();                           %dummy axis for text function
a.XAxis.Visible = 'off';            %clearing axes from view
a.YAxis.Visible = 'off';
a.Color =layer_color;
a=5;
if (handles.soil_parameters(index_layer).type=="Clay")||(handles.soil_parameters(index_layer).type=="Silt")
    txt_dry_unit_weight= ['Dry Unit Weight'];
    txt_dry_unit_weight_result=[num2str(handles.soil_parameters(index_layer).dry_unit_weight),' kN/m^3'];
    text(0.27,0.95,txt_dry_unit_weight,'Units','normalized','FontUnits','normalized','FontSize',0.105,'HorizontalAlignment','center');
    text(0.92,0.95,txt_dry_unit_weight_result,'Units','normalized','FontUnits','normalized','FontSize',0.105,'HorizontalAlignment','center');
    txt_sat_unit_weight=['Saturated Unit Weight'];
    txt_sat_unit_weight_result=[num2str(handles.soil_parameters(index_layer).sat_unit_weight),' kN/m^3'];
    text(0.27,0.80,txt_sat_unit_weight,'Units','normalized','FontUnits','normalized','FontSize',0.105,'HorizontalAlignment','center');
    text(0.92,0.80,txt_sat_unit_weight_result,'Units','normalized','FontUnits','normalized','FontSize',0.105,'HorizontalAlignment','center');
    txt_classification=['Classification'];
    txt_classification_result=[num2str(handles.soil_parameters(index_layer).classification)];
    text(0.27,0.65,txt_classification,'Units','normalized','FontUnits','normalized','FontSize',0.105,'HorizontalAlignment','center');
    text(0.92,0.65,txt_classification_result,'Units','normalized','FontUnits','normalized','FontSize',0.105,'HorizontalAlignment','center');
    txt_cohesion=['Cohesion'];
    txt_cohesion_result=[num2str(round(handles.soil_parameters(index_layer).cohesion,0)),' kPa'];
    text(0.27,0.50,txt_cohesion,'Units','normalized','FontUnits','normalized','FontSize',0.105,'HorizontalAlignment','center');
    text(0.92,0.50,txt_cohesion_result,'Units','normalized','FontUnits','normalized','FontSize',0.105,'HorizontalAlignment','center');
    txt_poisson=['Poisson Ratio'];
    txt_poisson_result=[num2str(handles.soil_parameters(index_layer).poisson),];
    text(0.27,0.35,txt_poisson,'Units','normalized','FontUnits','normalized','FontSize',0.105,'HorizontalAlignment','center');
    text(0.92,0.35,txt_poisson_result,'Units','normalized','FontUnits','normalized','FontSize',0.105,'HorizontalAlignment','center');
    txt_E_undrained=['Undrained Elastic Modulus'];
    txt_E_undrained_result=[num2str(round(handles.soil_parameters(index_layer).E_undrained,0)),' kPa'];
    text(0.27,0.20,txt_E_undrained,'Units','normalized','FontUnits','normalized','FontSize',0.105,'HorizontalAlignment','center');
    text(0.92,0.20,txt_E_undrained_result,'Units','normalized','FontUnits','normalized','FontSize',0.105,'HorizontalAlignment','center'); 
    txt_Mv=['Volume of Compressibility'];
    txt_Mv_result=[num2str(round(handles.soil_parameters(index_layer).cohesion,2)),' m^2/kN'];
    text(0.27,0.05,txt_Mv,'Units','normalized','FontUnits','normalized','FontSize',0.105,'HorizontalAlignment','center');
    text(0.92,0.05,txt_Mv_result,'Units','normalized','FontUnits','normalized','FontSize',0.105,'HorizontalAlignment','center');

else
    txt_dry_unit_weight= ['Dry Unit Weight'];
    txt_dry_unit_weight_result=[num2str(handles.soil_parameters(index_layer).dry_unit_weight),' kN/m^3'];
    text(.27,0.95,txt_dry_unit_weight,'Units','normalized','FontUnits','normalized','FontSize',0.105,'HorizontalAlignment','center');
    text(.92,0.95,txt_dry_unit_weight_result,'Units','normalized','FontUnits','normalized','FontSize',0.105,'HorizontalAlignment','center');
    
    txt_sat_unit_weight=['Saturated Unit Weight'];
    txt_sat_unit_weight_result=[num2str(handles.soil_parameters(index_layer).sat_unit_weight),' kN/m^3'];
    text(.27,0.80,txt_sat_unit_weight,'Units','normalized','FontUnits','normalized','FontSize',0.105,'HorizontalAlignment','center');
    text(.92,0.80,txt_sat_unit_weight_result,'Units','normalized','FontUnits','normalized','FontSize',0.105,'HorizontalAlignment','center');
    
    txt_classification=['Classification'];
    txt_classification_result=[num2str(handles.soil_parameters(index_layer).classification)];
    text(.27,0.65,txt_classification,'Units','normalized','FontUnits','normalized','FontSize',0.105,'HorizontalAlignment','center');
    text(.92,0.65,txt_classification_result,'Units','normalized','FontUnits','normalized','FontSize',0.105,'HorizontalAlignment','center');
    
    txt_relative_density= ['Relative Density'];
    txt_relative_density_result=[num2str(round(handles.soil_parameters(index_layer).relative_density,0)),'%'];
    text(.27,0.50,txt_relative_density,'Units','normalized','FontUnits','normalized','FontSize',0.105,'HorizontalAlignment','center');
    text(.92,0.50,txt_relative_density_result,'Units','normalized','FontUnits','normalized','FontSize',0.105,'HorizontalAlignment','center');
    
    txt_friction_angle=['Effective Internal Friction Angle'];
    txt_friction_angle_result=[num2str(round(handles.soil_parameters(index_layer).friction_angle,0)),'°'];
    text(.27,0.35,txt_friction_angle,'Units','normalized','FontUnits','normalized','FontSize',0.105,'HorizontalAlignment','center');
    text(.92,0.35,txt_friction_angle_result,'Units','normalized','FontUnits','normalized','FontSize',0.105,'HorizontalAlignment','center');
    
    txt_Es=['Elastic Modulus'];
    txt_Es_result=[num2str(round(handles.soil_parameters(index_layer).Es,0)),' kPa'];
    text(.27,0.20,txt_Es,'Units','normalized','FontUnits','normalized','FontSize',0.105,'HorizontalAlignment','center');
    text(.92,0.20,txt_Es_result,'Units','normalized','FontUnits','normalized','FontSize',0.105,'HorizontalAlignment','center');
    
    txt_poisson=['Poisson Ratio'];
    txt_poisson_result=[num2str(handles.soil_parameters(index_layer).poisson),];
    text(.27,0.05,txt_poisson,'Units','normalized','FontUnits','normalized','FontSize',0.105,'HorizontalAlignment','center');
    text(.92,0.05,txt_poisson_result,'Units','normalized','FontUnits','normalized','FontSize',0.105,'HorizontalAlignment','center');

end
        
for i = 0:6
    text(.72,0.95-0.15*i,'=','Units','normalized','FontUnits','normalized','FontSize',0.105,'HorizontalAlignment','center');
end


% --- Executes on slider movement.
function SLD_factor_of_safety_Callback(hObject, eventdata, handles)
% hObject    handle to SLD_factor_of_safety (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.factor_of_safety = round(1.0 + 4.0 * get(hObject,'Value'),2);

handles.ST_FS.String=['Factor of safety= ', num2str(handles.factor_of_safety)];
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function SLD_factor_of_safety_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLD_factor_of_safety (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function EDT_max_settlement_Callback(hObject, eventdata, handles)
% hObject    handle to EDT_max_settlement (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EDT_max_settlement as text
%        str2double(get(hObject,'String')) returns contents of EDT_max_settlement as a double
handles.building.max_settlement=str2double(get(hObject,'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function EDT_max_settlement_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EDT_max_settlement (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in togglebutton2.
function togglebutton2_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton2

% --- Executes on button press in TB_reinforcement_drawing.
function TB_reinforcement_drawing_Callback(hObject, eventdata, handles)
% hObject    handle to TB_reinforcement_drawing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TB_reinforcement_drawing


% --- Executes on button press in TB_3D_viewer.
function TB_3D_viewer_Callback(hObject, eventdata, handles)
% hObject    handle to TB_3D_viewer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TB_3D_viewer


% --- Executes when figure1 is resized.
function figure1_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse press over axes background.
function axes_soil_profile_creator_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes_soil_profile_creator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in TB_soil_profile_creator.
function TB_soil_profile_creator_Callback(hObject, eventdata, handles)
% hObject    handle to TB_soil_profile_creator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TB_soil_profile_creator


% --- Executes when selected object is changed in BG_tabs.
function BG_tabs_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in BG_tabs 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if handles.TB_soil_profile_creator.Value==1
    handles.PNL_soil_profile_creator.Visible='on';
    handles.PNL_pile_input.Visible='off';
    handles.PNL_pile_designer.Visible='off';
    handles.PNL_logo.Visible='off';
    handles.PNL_3D_viewer.Visible='off';
    handles.PNL_soil_profile_creator.HitTest='off';
    hold(handles.axes_soil_profile_creator,'on');
    hold(handles.axes_settle3d,'off');
    hold(handles.axes_3D_viewer,'off');
    handles.PNL_reinforcement_drawing.Visible='off';
    handles.PNL_cost_analysis.Visible='off';
    handles.PNL_settlement.Visible='off';
    set(handles.h1,'Enable','off');
    set(handles.h2,'Enable','off');
elseif handles.TB_pile_input.Value==1
    handles.PNL_pile_input.Visible='on';
    handles.PNL_soil_profile_creator.Visible='off';
    handles.PNL_pile_designer.Visible='off';
    handles.PNL_logo.Visible='off';
    handles.PNL_3D_viewer.Visible='off';
    handles.PNL_reinforcement_drawing.Visible='off';
    handles.PNL_cost_analysis.Visible='off';
    handles.PNL_settlement.Visible='off';
    set(handles.h1,'Enable','off');
    set(handles.h2,'Enable','off');
elseif handles.TB_pile_designer.Value==1
    handles.PNL_pile_designer.Visible='on';
    handles.PNL_soil_profile_creator.Visible='off';
    handles.PNL_pile_input.Visible='off';
    handles.PNL_logo.Visible='off';
    handles.PNL_3D_viewer.Visible='off';
    handles.PNL_reinforcement_drawing.Visible='off';
    handles.PNL_cost_analysis.Visible='off';
    set(handles.h1,'Enable','off');
    set(handles.h2,'Enable','off');
elseif handles.TB_3D_viewer.Value==1
    handles.PNL_3D_viewer.Visible='on';
    handles.PNL_pile_designer.Visible='off';
    handles.PNL_soil_profile_creator.Visible='off';
    handles.PNL_pile_input.Visible='off';
    handles.PNL_logo.Visible='off';
    set(handles.h1,'Enable','on');
    set(handles.h2,'Enable','on');
    setAllowAxesRotate(handles.h2,handles.axes_settle3d,false);
    setAllowAxesRotate(handles.h1,handles.axes_3D_viewer,true);
    handles.PNL_reinforcement_drawing.Visible='off';
    handles.PNL_cost_analysis.Visible='off';
    handles.PNL_settlement.Visible='off';
elseif handles.TB_reinforcement_drawing.Value==1
    handles.PNL_reinforcement_drawing.Visible='on';
    handles.PNL_3D_viewer.Visible='on';
    handles.PNL_pile_designer.Visible='off';
    handles.PNL_soil_profile_creator.Visible='off';
    handles.PNL_pile_input.Visible='off';
    handles.PNL_logo.Visible='off';
    handles.PNL_cost_analysis.Visible='off';
    handles.PNL_settlement.Visible='off';
    set(handles.h1,'Enable','off');
    set(handles.h2,'Enable','off');
elseif handles.TB_cost_analysis.Value==1
    handles.PNL_cost_analysis.Visible='on';
    handles.PNL_pile_input.Visible='off';
    handles.PNL_soil_profile_creator.Visible='off';
    handles.PNL_pile_designer.Visible='off';
    handles.PNL_logo.Visible='off';
    handles.PNL_3D_viewer.Visible='off';
    handles.PNL_reinforcement_drawing.Visible='off';
    handles.PNL_settlement.Visible='off';
    set(handles.h1,'Enable','off');
    set(handles.h2,'Enable','off');
elseif handles.TB_settlement.Value==1
    handles.PNL_cost_analysis.Visible='off';
    handles.PNL_pile_input.Visible='off';
    handles.PNL_soil_profile_creator.Visible='off';
    handles.PNL_pile_designer.Visible='off';
    set(handles.h1,'Enable','on');
    set(handles.h2,'Enable','on');
    setAllowAxesRotate(handles.h2,handles.axes_settle3d,true);
    setAllowAxesRotate(handles.h1,handles.axes_3D_viewer,false);
    handles.PNL_logo.Visible='off';
    handles.PNL_3D_viewer.Visible='off';
    handles.PNL_reinforcement_drawing.Visible='off';
    handles.PNL_settlement.Visible='on';
end

guidata(hObject, handles);

    


% --- Executes on button press in togglebutton13.
function togglebutton13_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton13


% --- Executes when selected object is changed in BG_pile_type.
function BG_pile_type_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in BG_pile_type 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.RB_driven_pile.Value==1
    handles.pile.type='Driven';
    handles.BG_driven_pile_material.Visible='on';
    handles.BG_bored_pile_material.Visible='off';
    handles.BG_bored_pile_shape.Visible='off';
    handles.RB_bored_concrete.Value=0;
    handles.RB_driven_concrete.Value=0;
    handles.RB_steel.Value=0;
    handles.RB_bored_concrete_circular.Value=0;
    handles.RB_bored_concrete_rectangle.Value=0;
    handles.RB_circular.Value=0;
    handles.RB_rectangle.Value=0;
    handles.RB_driven_steel_circular_hollow.Value=0;
    handles.RB_driven_steel_circular_filled.Value=0;
    
elseif handles.RB_bored_pile.Value==1
    handles.pile.type='Bored';
    handles.RB_bored_concrete_circular.Value=0;
    handles.RB_bored_concrete_rectangle.Value=0;
    handles.RB_circular.Value=0;
    handles.RB_rectangle.Value=0;
    handles.RB_driven_steel_circular_hollow.Value=0;
    handles.RB_driven_steel_circular_filled.Value=0;
    handles.BG_bored_pile_material.Visible='on';
    handles.BG_driven_pile_material.Visible='off';
    handles.BG_driven_concrete_pile_shape.Visible='off';
    handles.BG_driven_steel_pile_shape.Visible='off';
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function PNL_pile_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PNL_pile_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes when PNL_pile_input is resized.
function PNL_pile_input_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to PNL_pile_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in PB_pile_designer.
function PB_pile_designer_Callback(hObject, eventdata, handles)
% hObject    handle to PB_pile_designer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.number_of_run=handles.number_of_run+1;
if handles.number_of_run>1
    handles=rmfield(handles,'pile_combo');
else
end
wait_bar=waitbar(0,'Obtaining data from soil profile...');
pause(1.5)
soil_input_cell=handles.TBL_data.Data;
layer_number=handles.layer_number;
total_depth=handles.total_depth;
depth=0:-0.1:-1*total_depth;
stress_distribution=zeros(10*total_depth+1,3); %1st column=effective stress, 2nd column=water pressure and 3rd column=total stress
depth_start=0;
for i=1:1:layer_number              %By using this loop, interval of layer is determined.
    depth_end=depth_start+handles.soil_parameters(i).layer_thickness;
    depth_intervals(i,1)=depth_start;
    depth_intervals(i,2)=depth_end;
    depth_start=depth_end;
end

for i=1:1:layer_number
for j=depth_intervals(i,1)*10:1:depth_intervals(i,2)*10
    
    if j==depth_intervals(i,1)*10
        continue;
    end
    

    if j<=abs(handles.gwt)*10
        stress_distribution(j+1,1)=stress_distribution(j,1)+handles.soil_parameters(i).dry_unit_weight*0.1;
        stress_distribution(j+1,2)=stress_distribution(j,2);
        stress_distribution(j+1,3)=stress_distribution(j+1,1)+stress_distribution(j+1,2);
    elseif j>abs(handles.gwt)*10
        stress_distribution(j+1,1)=stress_distribution(j,1)+(handles.soil_parameters(i).sat_unit_weight-9.81)*0.1;
        stress_distribution(j+1,2)=stress_distribution(j,2)+0.1*9.81;
        stress_distribution(j+1,3)=stress_distribution(j+1,1)+stress_distribution(j+1,2);
        
    else
    end
    
    handles.soil_details(j).type=handles.soil_parameters(i).type;
    handles.soil_details(j).dry_unit_weight=handles.soil_parameters(i).dry_unit_weight;
    handles.soil_details(j).sat_unit_weight=handles.soil_parameters(i).sat_unit_weight;
    handles.soil_details(j).cohesion=handles.soil_parameters(i).cohesion;
    handles.soil_details(j).poisson=handles.soil_parameters(i).poisson;
    handles.soil_details(j).E_undrained=handles.soil_parameters(i).E_undrained;
    handles.soil_details(j).classification=handles.soil_parameters(i).classification;
    handles.soil_details(j).relative_density=handles.soil_parameters(i).relative_density;
    handles.soil_details(j).friction_angle=handles.soil_parameters(i).friction_angle;
    handles.soil_details(j).Es=handles.soil_parameters(i).Es;
    handles.soil_details(j).effective_stress=stress_distribution(j+1,1);
    handles.soil_details(j).water_pressure=stress_distribution(j+1,2);
    handles.soil_details(j).total_stress=stress_distribution(j+1,3);
    handles.soil_details(j).mv=handles.soil_parameters(i).mv;
  
end
end
%extrapolating the last soil layer for 30 m(to be used in tb_settlement calculations)
for index=1:300
handles.soil_details(total_depth*10+index)=handles.soil_details(total_depth*10);
end
if isempty(handles.building.force)
    err = errordlg('Applied force is not specified! ','Input Error Code:4');
    close(wait_bar)
    return
elseif isempty(handles.building.short_length)
    err = errordlg('Short length (B) is not specified! ','Input Error Code:5');
    close(wait_bar)
    return
elseif isempty(handles.building.long_length)
    err = errordlg('Long length (L) is not specified! ','Input Error Code:6');
    close(wait_bar)
    return
elseif isempty(handles.building.max_settlement)
    err = errordlg('Allowable settlement is not specified! ','Input Error Code:7');
    close(wait_bar)
    return
elseif isempty(handles.factor_of_safety)
    err = errordlg('Factor of safety is not specified! ','Input Error Code:8');
    close(wait_bar)
    return
elseif isempty(handles.concrete_ck)
    if handles.pile.material=="Concrete"
        err = errordlg('Concrete quality is not specified! ','Input Error Code:10');
        close(wait_bar)
        return
    end
elseif isempty(handles.steel_ck)
    err = errordlg('Steel quality is not specified! ','Input Error Code:11');
    close(wait_bar)
    return
elseif isempty(handles.spiral_steel_ck)
    if handles.pile.material=="Concrete"
        err = errordlg('Spiral steel quality is not specified! ','Input Error Code:12');
        close(wait_bar)
        return
    end
elseif isempty(handles.cc_concrete_unit_cost)
    if handles.pile.material=="Concrete"
        err = errordlg('Unit cost of concrete is not specified! ','Input Error Code:13');
        close(wait_bar)
        return
    end
elseif isempty(handles.cc_long_steel_unit_cost)
    if handles.pile.material=="Concrete"
        err = errordlg('Unit cost of longitudinal steel is not specified! ','Input Error Code:15');
        close(wait_bar)
        return
    end
elseif isempty(handles.cc_spiral_unit_cost)
    if handles.pile.material=="Concrete"
        err = errordlg('Unit cost of spiral steel is not specified! ','Input Error Code:14');
        close(wait_bar)
        return
    end
elseif isempty(handles.sc_steel_unit_cost)
    if handles.pile.material=="Steel"
        err = errordlg('Unit cost of structural steel is not specified! ','Input Error Code:16');
        close(wait_bar)
        return
    end
end 
if handles.building.short_length > handles.building.long_length
    err = errordlg('Short length cannot be greater than long length!','Input Error Code:9');
    close(wait_bar)
    return
end
waitbar(0.10,wait_bar,'Trying all the pile configurations... ');
pause(1)

%BIG PILE CAPACITY LOOP
if handles.pile.type=="Driven"
    if handles.pile.material=="Steel"
        if handles.pile.shape=="Circular_hollow"
            a=1;                                                                              %This variable is created to save different combinations in pile.combo struct.
            for diameter=0.5:0.05:1.2                                                           %Diameter of circle cross section is taken between 0.5 and 2.0. 
                lower_wall_thickness=ceil(diameter*1000/60);
                upper_wall_thickness=ceil(diameter*1000/40);
                for wall_thickness = lower_wall_thickness:10:upper_wall_thickness
                    inner_diameter=diameter-wall_thickness/1000;
                    row_min=ceil((handles.building.short_length+3.5*diameter)/(4.5*diameter));    %By considering spacing interval between 2.5*diameter and 4.5*diameter, maximum and minimum number of
                    row_max=fix((handles.building.short_length+1.5*diameter)/(2.5*diameter));     %pile in row and column are determined. With the help of this, running time is reduced.
                    column_min=ceil((handles.building.long_length+3.5*diameter)/(4.5*diameter));
                    column_max=fix((handles.building.long_length+1.5*diameter)/(2.5*diameter));
                    
                   for pile_number_row=row_min:row_max                                            %This 'for loop' is written for number of piles in row.
                       for pile_number_column=column_min:column_max                               %This 'for loop' is written for number of piles in column.
                           for pile_length=10:(total_depth)                                    %This 'for loop' is written for pile length. By using these three parameters, one combination is formed.
                               skin_friction=0;                                                   %Skin friction value is set to zero for each combination.
                               for j=1:pile_length*10                                             %Pile capacity increment is calculated at each 0.1m, so this loop is started from 1 to pile length*10 index of soil_details struct.

                                        if (handles.soil_details(j).type=="Silty Sand") ||(handles.soil_details(j).type=="Clayey Sand")||(handles.soil_details(j).type=="Clean Sand") %For 0.1m thick soil layer, soil type is determined. According to this, calculation is changed. This is 'sand' case.

                                              if j==1        %At the midpoint of beginning layer (i.e 5 cm), effective stress is calculated.
                                                   eff_str=handles.soil_details(j).effective_stress/2;
                                              else           %Effective stress calculation is done for other midpoint of 0.1m thick layers considering soil arching effect.      
                                                   if pile_length<(20*diameter)
                                                      eff_str=(handles.soil_details(j).effective_stress+handles.soil_details(j-1).effective_stress)/2;

                                                   elseif pile_length>=(20*diameter)
                                                       index_pile_length=round((20*diameter*10),0);
                                                       eff_str=handles.soil_details(index_pile_length).effective_stress;

                                                   end
                                              end

                                              %Unit skin friction is calculated for sand case.
                                              interface_friction_angle=20;
                                              unit_skin_friction=eff_str*tand(interface_friction_angle);
                                              skin_friction=skin_friction+0.5*pi*diameter*0.1*unit_skin_friction;

                                              %Unit end bearing is calculated for sand case.
                                              if (handles.soil_details(j).classification=="dense") || (handles.soil_details(j).classification=="very dense") %This if statement prevents end bearing calculations for weak sand layers.
                                                fi=handles.soil_details(j).friction_angle;
                                                Nq=2*(0.0097*fi^3-0.6758*fi^2+15.995*fi-123.81);
                                                handles.soil_details(j).unit_end_bearing=handles.soil_details(j).effective_stress*Nq;
                                              else %For weak sand layers, unit end bearing is directly taken as 0.
                                                handles.soil_details(j).unit_end_bearing=0;
                                              end

                                        elseif (handles.soil_details(j).type=="Clay") ||(handles.soil_details(j).type=="Silt") %Calculations are done for silt and clay case.

                                            %Unit skin friction is calculated.
                                            cohesion=handles.soil_details(j).cohesion;
                                            alpha=0.00002*cohesion^2-0.0073*cohesion+1.1499;
                                            unit_skin_friction=alpha*cohesion;
                                            skin_friction=skin_friction+pi*diameter*0.1*(unit_skin_friction);

                                            %unit end bearing is calculated.
                                            if (handles.soil_details(j).classification=="very stiff") || (handles.soil_details(j).classification=="hard") || (handles.soil_details(j).classification=="very hard") %This if statement prevents end bearing calculations for weak clay layers.
                                                handles.soil_details(j).unit_end_bearing=9*cohesion;
                                            else %For weak clay layers, unit end bearing is directly taken as 0.
                                                handles.soil_details(j).unit_end_bearing=0;
                                            end
                                        end     
   
                               end
                        single_pile_weight=pi*((diameter^2)-(inner_diameter^2))/4*pile_length*78.5;
                        
                        handles.pile_combo(a).end_bearing=(handles.soil_details(pile_length*10).unit_end_bearing)*pi*((diameter^2)-(inner_diameter^2))/4;         %For selected combo, end bearing is calculated and saved in end_bearing field.
                        handles.pile_combo(a).skin_friction=skin_friction;                                                                   %For selected combo, end bearing is calculated and saved in skin_friction field.
                        handles.pile_combo(a).single_pile_capacity=(handles.pile_combo(a).skin_friction)-single_pile_weight+(handles.pile_combo(a).end_bearing);%For selected combo, single pile capacity is calculated and saved in single_pile_capacity field.
                        handles.pile_combo(a).wall_thickness=wall_thickness;
                        handles.pile_combo(a).row_pile_number=pile_number_row;                                                               %For selected combo, row pile number is saved in row_pile_number field.
                        handles.pile_combo(a).column_pile_number=pile_number_column;                                                         %For selected combo, column pile number is saved in column_pile_number field.
                        handles.pile_combo(a).pile_length=pile_length;                                                                       %For selected combo, pile length is saved in pile_length field.
                        handles.pile_combo(a).diameter=diameter;                                                                             %For selected combo, diameter is saved in diameter field.
                        
                        %Group efficiency is calculated according to Converse Labarre.
                        spacing=min((handles.building.short_length-diameter)/(pile_number_row-1),(handles.building.long_length-diameter)/(pile_number_column-1)); 
                        theta=atand(diameter/spacing);
                        handles.pile_combo(a).group_efficiency=1-(theta*((pile_number_row-1)*pile_number_column+(pile_number_column-1)*pile_number_row))/(90*pile_number_row*pile_number_column);%For selected combo, group efficiency is saved in group_efficiency field.
                        
                        handles.pile_combo(a).group_pile_capacity=(handles.pile_combo(a).group_efficiency)*(pile_number_row)*(pile_number_column)*(handles.pile_combo(a).single_pile_capacity); %For selected combo, group capacity is calculated, and saved in group_pile_capacity field.
                        handles.pile_combo(a).factor_of_safety=(handles.pile_combo(a).group_pile_capacity)/(handles.building.force); %For selected combo, factor of safety is calculated and saved in factor_of_safety field.
                        
                        if (handles.pile_combo(a).factor_of_safety>=handles.factor_of_safety) && (handles.pile_combo(a).factor_of_safety<1.10*handles.factor_of_safety)%If factor of safety of pile combination is between factor of safety and 1.05 times factor of safety given by user,
                            handles.pile_combo(a).soil_check=1;                                                                                                        %this combination will be kept.   
                        else
                            handles.pile_combo(a).soil_check=0;
                        end
                        
                        a=a+1; %For the next combination, a number is increased by one.
                        
                        end

                   end
                   
               end
                 
            end
         end
                 
        elseif handles.pile.shape=="Circular_filled"
        
        else b=5;
              
        end
    elseif handles.pile.material=="Concrete"
        if handles.pile.shape=="Circle"
             a=1;
             for diameter=0.5:0.05:1.5                                                            %Diameter of circle cross section is taken between 0.5 and 2.0.    
                row_min=ceil((handles.building.short_length+3.5*diameter)/(4.5*diameter));    %By considering spacing interval between 2.5*diameter and 4.5*diameter, maximum and minimum number of
                row_max=fix((handles.building.short_length+1.5*diameter)/(2.5*diameter));     %pile in row and column are determined. With the help of this, running time is reduced.
                column_min=ceil((handles.building.long_length+3.5*diameter)/(4.5*diameter));
                column_max=fix((handles.building.long_length+1.5*diameter)/(2.5*diameter));
               for pile_number_row=row_min:row_max                                            %This 'for loop' is written for number of piles in row.
                   for pile_number_column=column_min:column_max                               %This 'for loop' is written for number of piles in column.
                       for pile_length=10:(total_depth)                                    %This 'for loop' is written for pile length. By using these three parameters, one combination is formed.
                           skin_friction=0;                                                   %Skin friction value is set to zero for each combination.
                           for j=1:pile_length*10                                             %Pile capacity increment is calculated at each 0.1m, so this loop is started from 1 to pile length*10 index of soil_details struct.
                                  
                                   
                                    if (handles.soil_details(j).type=="Silty Sand") ||(handles.soil_details(j).type=="Clayey Sand")||(handles.soil_details(j).type=="Clean Sand") %For 0.1m thick soil layer, soil type is determined. According to this, calculation is changed. This is 'sand' case.
                                        
                                          if j==1        %At the midpoint of beginning layer (i.e 5 cm), effective stress is calculated.
                                               eff_str=handles.soil_details(j).effective_stress/2;
                                          else           %Effective stress calculation is done for other midpoint of 0.1m thick layers considering soil arching effect.      
                                               if pile_length<(20*diameter)
                                                  eff_str=(handles.soil_details(j).effective_stress+handles.soil_details(j-1).effective_stress)/2;

                                               elseif pile_length>=(20*diameter)
                                                   index_pile_length=round((20*diameter*10),0);
                                                   eff_str=handles.soil_details(index_pile_length).effective_stress;
                                                   
                                               end
                                          end

                                          %Unit skin friction is calculated for sand case.
                                          interface_friction_angle=0.75*handles.soil_details(j).friction_angle;
                                          unit_skin_friction=eff_str*tand(interface_friction_angle);
                                          if (handles.soil_details(j).classification=="dense") || (handles.soil_details(j).classification=="very dense")
                                              Ks=2;
                                          else
                                              Ks=1;
                                          end
                                              
                                          skin_friction=skin_friction+Ks*pi*diameter*0.1*unit_skin_friction;

                                          %Unit end bearing is calculated for sand case.
                                          if (handles.soil_details(j).classification=="dense") || (handles.soil_details(j).classification=="very dense") %This if statement prevents end bearing calculations for weak sand layers.
                                            fi=handles.soil_details(j).friction_angle;
                                            Nq=2*(0.0097*fi^3-0.6758*fi^2+15.995*fi-123.81);
                                            handles.soil_details(j).unit_end_bearing=handles.soil_details(j).effective_stress*Nq;
                                          else %For weak sand layers, unit end bearing is directly taken as 0.
                                            handles.soil_details(j).unit_end_bearing=0;
                                          end

                                    elseif (handles.soil_details(j).type=="Clay") ||(handles.soil_details(j).type=="Silt") %Calculations are done for silt and clay case.

                                        %Unit skin friction is calculated.
                                        cohesion=handles.soil_details(j).cohesion;
                                        alpha=0.00002*cohesion^2-0.0073*cohesion+1.1499;
                                        unit_skin_friction=alpha*cohesion;
                                        skin_friction=skin_friction+pi*diameter*0.1*(unit_skin_friction);

                                        %unit end bearing is calculated.
                                        if (handles.soil_details(j).classification=="very stiff") || (handles.soil_details(j).classification=="hard") || (handles.soil_details(j).classification=="very hard") %This if statement prevents end bearing calculations for weak clay layers.
                                            handles.soil_details(j).unit_end_bearing=9*cohesion;
                                        else %For weak clay layers, unit end bearing is directly taken as 0.
                                            handles.soil_details(j).unit_end_bearing=0;
                                        end
                                    end     
   
                           end
                           single_pile_weight=pi*(diameter^2)/4*pile_length*25;
                           
                        handles.pile_combo(a).end_bearing=(handles.soil_details(pile_length*10).unit_end_bearing)*pi*(diameter^2)/4;         %For selected combo, end bearing is calculated and saved in end_bearing field.
                        handles.pile_combo(a).skin_friction=skin_friction;                                                                   %For selected combo, end bearing is calculated and saved in skin_friction field.
                        handles.pile_combo(a).single_pile_capacity=(handles.pile_combo(a).skin_friction)-single_pile_weight+(handles.pile_combo(a).end_bearing);%For selected combo, single pile capacity is calculated and saved in single_pile_capacity field.
                        handles.pile_combo(a).row_pile_number=pile_number_row;                                                               %For selected combo, row pile number is saved in row_pile_number field.
                        handles.pile_combo(a).column_pile_number=pile_number_column;                                                         %For selected combo, column pile number is saved in column_pile_number field.
                        handles.pile_combo(a).pile_length=pile_length;                                                                       %For selected combo, pile length is saved in pile_length field.
                        handles.pile_combo(a).diameter=diameter;                                                                             %For selected combo, diameter is saved in diameter field.
                        %Group efficiency is calculated according to Converse Labarre.
                        spacing=min((handles.building.short_length-diameter)/(pile_number_row-1),(handles.building.long_length-diameter)/(pile_number_column-1)); 
                        theta=atand(diameter/spacing);
                        handles.pile_combo(a).group_efficiency=1-(theta*((pile_number_row-1)*pile_number_column+(pile_number_column-1)*pile_number_row))/(90*pile_number_row*pile_number_column);%For selected combo, group efficiency is saved in group_efficiency field.
                        
                        handles.pile_combo(a).group_pile_capacity=(handles.pile_combo(a).group_efficiency)*(pile_number_row)*(pile_number_column)*(handles.pile_combo(a).single_pile_capacity); %For selected combo, group capacity is calculated, and saved in group_pile_capacity field.
                        handles.pile_combo(a).factor_of_safety=(handles.pile_combo(a).group_pile_capacity)/(handles.building.force); %For selected combo, factor of safety is calculated and saved in factor_of_safety field.
                        
                        if (handles.pile_combo(a).factor_of_safety>=handles.factor_of_safety) && (handles.pile_combo(a).factor_of_safety<1.15*handles.factor_of_safety)%If factor of safety of pile combination is between factor of safety and 1.05 times factor of safety given by user,
                            handles.pile_combo(a).soil_check=1;                                                                                                        %this combination will be kept.   
                        else
                            handles.pile_combo(a).soil_check=0;
                        end
                        
                        a=a+1; %For the next combination, a number is increased by one.
                        
                        end  
                   end
                    
               end
                     
            end
                          
        elseif handles.pile.shape=="Square"
             a=1;
             for edge=0.5:0.05:1                                                      %Edge of the square is taken between 0.3m and 1.5m                                                        
                row_min=ceil((handles.building.short_length+3.5*edge)/(4.5*edge));    %By considering spacing interval between 2.5*edge and 4.5*edge, maximum and minimum number of
                row_max=fix((handles.building.short_length+1.5*edge)/(2.5*edge));     %pile in row and column are determined. With the help of this, running time is reduced.
                column_min=ceil((handles.building.long_length+3.5*edge)/(4.5*edge));
                column_max=fix((handles.building.long_length+1.5*edge)/(2.5*edge));
               for pile_number_row=row_min:row_max                                    %This 'for loop' is written for number of piles in row.
                   for pile_number_column=column_min:column_max                       %This 'for loop' is written for number of piles in column.
                       for pile_length=1:(total_depth)                             %This 'for loop' is written for pile length. By using these three parameters, one combination is formed.
                           skin_friction=0;                                           %Skin friction value is set to zero for each combination.
                           for j=1:pile_length*10                                     %Pile capacity increment is calculated at each 0.1m, so this loop is started from 1 to pile length*10 index of soil_details struct.
                                    if (handles.soil_details(j).type=="Silty Sand") ||(handles.soil_details(j).type=="Clayey Sand")||(handles.soil_details(j).type=="Clean Sand") %For 0.1m thick soil layer, soil type is determined. According to this, calculation is changed. This is 'sand' case.
                                        
                                        if j==1        %At the midpoint of beginning layer (i.e 5 cm), effective stress is calculated.
                                               eff_str=handles.soil_details(j).effective_stress/2;
                                        else           %Effective stress calculation is done for other midpoint of 0.1m thick layers considering soil arching effect.      
                                              if pile_length<(20*edge)
                                                  eff_str=(handles.soil_details(j).effective_stress+handles.soil_details(j-1).effective_stress)/2;

                                              elseif pile_length>=(20*edge)
                                                   index_pile_length=round((20*edge*10),0);
                                                   eff_str=handles.soil_details(index_pile_length).effective_stress;
                                                   
                                              end
                                        end

                                        %unit skin friction
                                        interface_friction_angle=0.75*handles.soil_details(j).friction_angle;
                                        unit_skin_friction=eff_str*tand(interface_friction_angle);
                                        if (handles.soil_details(j).classification=="dense") || (handles.soil_details(j).classification=="very dense")
                                              Ks=2;
                                        else
                                              Ks=1;
                                        end
                                        skin_friction=skin_friction+Ks*4*edge*0.1*unit_skin_friction;


                                        %Unit end bearing is calculated for sand case.
                                        if (handles.soil_details(j).classification=="dense") || (handles.soil_details(j).classification=="very dense") %This if statement prevents end bearing calculations for weak sand layers.
                                            fi=handles.soil_details(j).friction_angle;
                                            Nq=2*(0.0097*fi^3-0.6758*fi^2+15.995*fi-123.81);
                                            handles.soil_details(j).unit_end_bearing=handles.soil_details(j).effective_stress*Nq;
                                        else %For weak sand layers, unit end bearing is directly taken as 0.
                                            handles.soil_details(j).unit_end_bearing=0;
                                        end

                                    elseif (handles.soil_details(j).type=="Clay") ||(handles.soil_details(j).type=="Silt") %Calculations are done for silt and clay case.

                                        %Unit skin friction is calculated.
                                        cohesion=handles.soil_details(j).cohesion;
                                        alpha=0.00002*cohesion^2-0.0073*cohesion+1.1499;
                                        unit_skin_friction=alpha*cohesion;
                                        skin_friction=skin_friction+4*edge*0.1*(unit_skin_friction);
                                        %unit end bearing is calculated.
                                        if (handles.soil_details(j).classification=="very stiff") || (handles.soil_details(j).classification=="hard") || (handles.soil_details(j).classification=="very hard") %This if statement prevents end bearing calculations for weak clay layers.
                                            handles.soil_details(j).unit_end_bearing=9*cohesion;
                                        else %For weak clay layers, unit end bearing is directly taken as 0.
                                            handles.soil_details(j).unit_end_bearing=0;
                                        end
                                    end     
   
                           end
                            
                            single_pile_weight=(edge^2)*pile_length*25;
                            handles.pile_combo(a).end_bearing=(handles.soil_details(pile_length*10).unit_end_bearing)*edge*edge;                 %For selected combo, end bearing is calculated and saved in end_bearing field.
                            handles.pile_combo(a).skin_friction=skin_friction;                                                                   %For selected combo, end bearing is calculated and saved in skin_friction field.
                            handles.pile_combo(a).single_pile_capacity=(handles.pile_combo(a).skin_friction)-single_pile_weight+(handles.pile_combo(a).end_bearing);%For selected combo, single pile capacity is calculated and saved in single_pile_capacity field.
                            handles.pile_combo(a).row_pile_number=pile_number_row;                                                               %For selected combo, row pile number is saved in row_pile_number field.
                            handles.pile_combo(a).column_pile_number=pile_number_column;                                                         %For selected combo, column pile number is saved in column_pile_number field.
                            handles.pile_combo(a).pile_length=pile_length;                                                                       %For selected combo, pile length is saved in pile_length field.
                            handles.pile_combo(a).edge=edge;                                                                                     %For selected combo, edge is saved in edge field.
                            %Group efficiency is calculated according to Converse Labarre.
                            spacing=min((handles.building.short_length-edge)/(pile_number_row-1),(handles.building.long_length-edge)/(pile_number_column-1)); 
                            theta=atand(edge/spacing);
                            handles.pile_combo(a).group_efficiency=1-(theta*((pile_number_row-1)*pile_number_column+(pile_number_column-1)*pile_number_row))/(90*pile_number_row*pile_number_column);%For selected combo, group efficiency is saved in group_efficiency field.
                            
                            handles.pile_combo(a).group_pile_capacity=(handles.pile_combo(a).group_efficiency)*(pile_number_row)*(pile_number_column)*(handles.pile_combo(a).single_pile_capacity); %For selected combo, group capacity is calculated, and saved in group_pile_capacity field.
                            handles.pile_combo(a).factor_of_safety=(handles.pile_combo(a).group_pile_capacity)/(handles.building.force); %For selected combo, factor of safety is calculated and saved in factor_of_safety field.
                        
                            if (handles.pile_combo(a).factor_of_safety>=handles.factor_of_safety) && (handles.pile_combo(a).factor_of_safety<1.05*handles.factor_of_safety)%If factor of safety of pile combination is between factor of safety and 1.05 times factor of safety given by user,
                                handles.pile_combo(a).soil_check=1;                                                                                                        %this combination will be kept.   
                            else
                                handles.pile_combo(a).soil_check=0;
                            end
                        
                            a=a+1; %For the next combination, a number is increased by one.
                        
                        end
                        
                   end
                       
               end
                
            end
        end   
            
    else %No material selected error
            
    end
    
elseif handles.pile.type=="Bored"                                                             %Bored option is selected.   
    if handles.pile.material=="Concrete"                                                      %Under bored option, there is only concrete as a material option.
        if handles.pile.shape=="Circle"                                                       %Cross section is decided as 'Circle'
            a=1;                                                                              %This variable is created to save different combinations in pile.combo struct.
            for diameter=0.5:0.05:1.5                                                           %Diameter of circle cross section is taken between 0.5 and 2.0.    
                row_min=ceil((handles.building.short_length+3.5*diameter)/(4.5*diameter));    %By considering spacing interval between 2.5*diameter and 4.5*diameter, maximum and minimum number of
                row_max=fix((handles.building.short_length+1.5*diameter)/(2.5*diameter));     %pile in row and column are determined. With the help of this, running time is reduced.
                column_min=ceil((handles.building.long_length+3.5*diameter)/(4.5*diameter));
                column_max=fix((handles.building.long_length+1.5*diameter)/(2.5*diameter));
               for pile_number_row=row_min:row_max                                            %This 'for loop' is written for number of piles in row.
                   for pile_number_column=column_min:column_max                               %This 'for loop' is written for number of piles in column.
                       for pile_length=10:(total_depth)                                    %This 'for loop' is written for pile length. By using these three parameters, one combination is formed.
                           skin_friction=0;                                                   %Skin friction value is set to zero for each combination.
                           for j=1:pile_length*10                                             %Pile capacity increment is calculated at each 0.1m, so this loop is started from 1 to pile length*10 index of soil_details struct.
                                                                     
                                    if (handles.soil_details(j).type=="Silty Sand") ||(handles.soil_details(j).type=="Clayey Sand")||(handles.soil_details(j).type=="Clean Sand") %For 0.1m thick soil layer, soil type is determined. According to this, calculation is changed. This is 'sand' case.
                                        
                                          if j==1        %At the midpoint of beginning layer (i.e 5 cm), effective stress is calculated.
                                               eff_str=handles.soil_details(j).effective_stress/2;
                                          else           %Effective stress calculation is done for other midpoint of 0.1m thick layers considering soil arching effect.      
                                               if pile_length<(20*diameter)
                                                  eff_str=(handles.soil_details(j).effective_stress+handles.soil_details(j-1).effective_stress)/2;

                                               elseif pile_length>=(20*diameter)
                                                   index_pile_length=round((20*diameter*10),0);
                                                   eff_str=handles.soil_details(index_pile_length).effective_stress;    
                                               end
                                          end

                                          %Unit skin friction is calculated for sand case.
                                          interface_friction_angle=0.75*handles.soil_details(j).friction_angle;
                                          unit_skin_friction=eff_str*tand(interface_friction_angle);
                                          skin_friction=skin_friction+0.5*pi*diameter*0.1*unit_skin_friction;

                                          %Unit end bearing is calculated for sand case.
                                          if (handles.soil_details(j).classification=="dense") || (handles.soil_details(j).classification=="very dense") %This if statement prevents end bearing calculations for weak sand layers.
                                            fi=handles.soil_details(j).friction_angle;
                                            Nq=0.0097*fi^3-0.6758*fi^2+15.995*fi-123.81;
                                            handles.soil_details(j).unit_end_bearing=handles.soil_details(j).effective_stress*Nq;
                                          else %For weak sand layers, unit end bearing is directly taken as 0.
                                            handles.soil_details(j).unit_end_bearing=0;
                                          end

                                    elseif (handles.soil_details(j).type=="Clay") ||(handles.soil_details(j).type=="Silt") %Calculations are done for silt and clay case.

                                        %Unit skin friction is calculated.
                                        cohesion=handles.soil_details(j).cohesion;
                                        alpha=0.00002*cohesion^2-0.0073*cohesion+1.1499;
                                        unit_skin_friction=alpha*cohesion;
                                        skin_friction=skin_friction+pi*diameter*0.1*(unit_skin_friction);

                                        %unit end bearing is calculated.
                                        if (handles.soil_details(j).classification=="very stiff") || (handles.soil_details(j).classification=="hard") || (handles.soil_details(j).classification=="very hard") %This if statement prevents end bearing calculations for weak clay layers.
                                            handles.soil_details(j).unit_end_bearing=9*cohesion;
                                        else %For weak clay layers, unit end bearing is directly taken as 0.
                                            handles.soil_details(j).unit_end_bearing=0;
                                        end
                                    end     
   
                           end       
                        single_pile_weight=pi*(diameter^2)*pile_length*25;
                        handles.pile_combo(a).end_bearing=(handles.soil_details(pile_length*10).unit_end_bearing)*pi*(diameter^2)/4;         %For selected combo, end bearing is calculated and saved in end_bearing field.
                        handles.pile_combo(a).skin_friction=skin_friction;                                                                   %For selected combo, end bearing is calculated and saved in skin_friction field.
                        handles.pile_combo(a).single_pile_capacity=(handles.pile_combo(a).skin_friction)-single_pile_weight+(handles.pile_combo(a).end_bearing);%For selected combo, single pile capacity is calculated and saved in single_pile_capacity field.
                        handles.pile_combo(a).row_pile_number=pile_number_row;                                                               %For selected combo, row pile number is saved in row_pile_number field.
                        handles.pile_combo(a).column_pile_number=pile_number_column;                                                         %For selected combo, column pile number is saved in column_pile_number field.
                        handles.pile_combo(a).pile_length=pile_length;                                                                       %For selected combo, pile length is saved in pile_length field.
                        handles.pile_combo(a).diameter=diameter;                                                                             %For selected combo, diameter is saved in diameter field.
                        %Group efficiency is calculated according to Converse Labarre.
                        spacing=min((handles.building.short_length-diameter)/(pile_number_row-1),(handles.building.long_length-diameter)/(pile_number_column-1)); 
                        theta=atand(diameter/spacing);
                        handles.pile_combo(a).group_efficiency=1-(theta*((pile_number_row-1)*pile_number_column+(pile_number_column-1)*pile_number_row))/(90*pile_number_row*pile_number_column);%For selected combo, group efficiency is saved in group_efficiency field.
                        
                        handles.pile_combo(a).group_pile_capacity=(handles.pile_combo(a).group_efficiency)*(pile_number_row)*(pile_number_column)*(handles.pile_combo(a).single_pile_capacity); %For selected combo, group capacity is calculated, and saved in group_pile_capacity field.
                        handles.pile_combo(a).factor_of_safety=(handles.pile_combo(a).group_pile_capacity)/(handles.building.force); %For selected combo, factor of safety is calculated and saved in factor_of_safety field.
                        
                        if (handles.pile_combo(a).factor_of_safety>=handles.factor_of_safety) && (handles.pile_combo(a).factor_of_safety<1.05*handles.factor_of_safety)%If factor of safety of pile combination is between factor of safety and 1.05 times factor of safety given by user,
                            handles.pile_combo(a).soil_check=1;                                                                                                        %this combination will be kept.   
                        else
                            handles.pile_combo(a).soil_check=0;
                        end
                        
                        a=a+1; %For the next combination, a number is increased by one.
                        
                        end
                       
                   end
                     
               end
               
               
            end
            
        elseif handles.pile.shape=="Square"                                           %Cross section is decided as 'Square'
            a=1;
            for edge=0.5:0.05:1                                                      %Edge of the square is taken between 0.3m and 1.5m                                                        
                row_min=ceil((handles.building.short_length+3.5*edge)/(4.5*edge));    %By considering spacing interval between 2.5*edge and 4.5*edge, maximum and minimum number of
                row_max=fix((handles.building.short_length+1.5*edge)/(2.5*edge));     %pile in row and column are determined. With the help of this, running time is reduced.
                column_min=ceil((handles.building.long_length+3.5*edge)/(4.5*edge));
                column_max=fix((handles.building.long_length+1.5*edge)/(2.5*edge));
               for pile_number_row=row_min:row_max                                    %This 'for loop' is written for number of piles in row.
                   for pile_number_column=column_min:column_max                       %This 'for loop' is written for number of piles in column.
                       for pile_length=1:(total_depth)                             %This 'for loop' is written for pile length. By using these three parameters, one combination is formed.
                           skin_friction=0;                                           %Skin friction value is set to zero for each combination.
                           for j=1:pile_length*10                                     %Pile capacity increment is calculated at each 0.1m, so this loop is started from 1 to pile length*10 index of soil_details struct.
                                    if (handles.soil_details(j).type=="Silty Sand") ||(handles.soil_details(j).type=="Clayey Sand")||(handles.soil_details(j).type=="Clean Sand") %For 0.1m thick soil layer, soil type is determined. According to this, calculation is changed. This is 'sand' case.
                                        
                                        if j==1        %At the midpoint of beginning layer (i.e 5 cm), effective stress is calculated.
                                               eff_str=handles.soil_details(j).effective_stress/2;
                                        else           %Effective stress calculation is done for other midpoint of 0.1m thick layers considering soil arching effect.      
                                              if pile_length<(20*edge)
                                                  eff_str=(handles.soil_details(j).effective_stress+handles.soil_details(j-1).effective_stress)/2;

                                              elseif pile_length>=(20*edge)
                                                   index_pile_length=round((20*edge*10),0);
                                                   eff_str=handles.soil_details(index_pile_length).effective_stress; 
                                              end
                                        end

                                        %unit skin friction
                                        interface_friction_angle=0.75*handles.soil_details(j).friction_angle;
                                        unit_skin_friction=eff_str*tand(interface_friction_angle);
                                        skin_friction=skin_friction+0.5*4*edge*0.1*unit_skin_friction;

                                        %Unit end bearing is calculated for sand case.
                                        if (handles.soil_details(j).classification=="dense") || (handles.soil_details(j).classification=="very dense") %This if statement prevents end bearing calculations for weak sand layers.
                                            fi=handles.soil_details(j).friction_angle;
                                            Nq=0.0097*fi^3-0.6758*fi^2+15.995*fi-123.81;
                                            handles.soil_details(j).unit_end_bearing=handles.soil_details(j).effective_stress*Nq;
                                        else %For weak sand layers, unit end bearing is directly taken as 0.
                                            handles.soil_details(j).unit_end_bearing=0;
                                        end

                                    elseif (handles.soil_details(j).type=="Clay") ||(handles.soil_details(j).type=="Silt") %Calculations are done for silt and clay case.

                                        %Unit skin friction is calculated.
                                        cohesion=handles.soil_details(j).cohesion;
                                        alpha=0.00002*cohesion^2-0.0073*cohesion+1.1499;
                                        unit_skin_friction=alpha*cohesion;
                                        skin_friction=skin_friction+4*edge*0.1*(unit_skin_friction);
                                        %unit end bearing is calculated.
                                        if (handles.soil_details(j).classification=="very stiff") || (handles.soil_details(j).classification=="hard") || (handles.soil_details(j).classification=="very hard") %This if statement prevents end bearing calculations for weak clay layers.
                                            handles.soil_details(j).unit_end_bearing=9*cohesion;
                                        else %For weak clay layers, unit end bearing is directly taken as 0.
                                            handles.soil_details(j).unit_end_bearing=0;
                                        end
                                    end     

                           end
                            single_pile_weight=(edge^2)*25*pile_length;
                            handles.pile_combo(a).end_bearing=(handles.soil_details(pile_length*10).unit_end_bearing)*edge*edge;                 %For selected combo, end bearing is calculated and saved in end_bearing field.
                            handles.pile_combo(a).skin_friction=skin_friction;                                                                   %For selected combo, end bearing is calculated and saved in skin_friction field.
                            handles.pile_combo(a).single_pile_capacity=(handles.pile_combo(a).skin_friction)-single_pile_weight+(handles.pile_combo(a).end_bearing);%For selected combo, single pile capacity is calculated and saved in single_pile_capacity field.
                            handles.pile_combo(a).row_pile_number=pile_number_row;                                                               %For selected combo, row pile number is saved in row_pile_number field.
                            handles.pile_combo(a).column_pile_number=pile_number_column;                                                         %For selected combo, column pile number is saved in column_pile_number field.
                            handles.pile_combo(a).pile_length=pile_length;                                                                       %For selected combo, pile length is saved in pile_length field.
                            handles.pile_combo(a).edge=edge;                                                                                     %For selected combo, edge is saved in edge field.
                            %Group efficiency is calculated according to Converse Labarre.
                            spacing=min((handles.building.short_length-edge)/(pile_number_row-1),(handles.building.long_length-edge)/(pile_number_column-1)); 
                            theta=atand(edge/spacing);
                            handles.pile_combo(a).group_efficiency=1-(theta*((pile_number_row-1)*pile_number_column+(pile_number_column-1)*pile_number_row))/(90*pile_number_row*pile_number_column);%For selected combo, group efficiency is saved in group_efficiency field.
                            
                            handles.pile_combo(a).group_pile_capacity=(handles.pile_combo(a).group_efficiency)*(pile_number_row)*(pile_number_column)*(handles.pile_combo(a).single_pile_capacity); %For selected combo, group capacity is calculated, and saved in group_pile_capacity field.
                            handles.pile_combo(a).factor_of_safety=(handles.pile_combo(a).group_pile_capacity)/(handles.building.force); %For selected combo, factor of safety is calculated and saved in factor_of_safety field.
                        
                            if (handles.pile_combo(a).factor_of_safety>=handles.factor_of_safety) && (handles.pile_combo(a).factor_of_safety<1.05*handles.factor_of_safety)%If factor of safety of pile combination is between factor of safety and 1.05 times factor of safety given by user,
                                handles.pile_combo(a).soil_check=1;                                                                                                        %this combination will be kept.   
                            else
                                handles.pile_combo(a).soil_check=0;
                            end
                        
                            a=a+1; %For the next combination, a number is increased by one.
                        
                        end
                       
                   end
                   
               end

            end
        else
          
        err = errordlg('Pile cross section is not selected! ','Input Error Code:3');
        close(wait_bar)
        return
        end
    else
        err = errordlg('Pile material is not selected! ','Input Error Code:2');
        close(wait_bar)
        return
    end               
else
err = errordlg('Pile construction method is not selected! ','Input Error Code:1');
close(wait_bar)
return
end

waitbar(0.5,wait_bar,'Processing the settlement calculations...');
pause(1)     
handles.ST_number_of_trials.String=num2str(a);
for k = (a-1):-1:1
    if handles.pile_combo(k).soil_check==0
        handles.pile_combo(k)=[];
    end
end

if size(handles.pile_combo,2)==1
    wrng = warndlg('There is only one case satisfying soil check! This configuration is studied but settlement requirement may not be satisfied! ','Warning');
end


%creating 1h2v stress struct
stress_index=0.1;
i=2;
handles.delta_stress=[];
handles.delta_stress(1)=handles.building.force/((handles.building.short_length)*(handles.building.long_length));
handles.delta_stress(2)=handles.building.force/((handles.building.short_length+stress_index)*(handles.building.long_length+stress_index));

while (handles.delta_stress(end)) > (0.2*handles.delta_stress(1))
    stress_index=stress_index+0.1;
    i=i+1;
    handles.delta_stress(i)=handles.building.force/((handles.building.short_length+stress_index)*(handles.building.long_length+stress_index));
end
consolidation_boundry=stress_index;
%Influence factors to be used immediate settlement calculations
if (handles.building.long_length/handles.building.short_length)<=1.30
    handles.influence_factor=0.95+0.35*((handles.building.long_length/handles.building.short_length)-1);
else
    handles.influence_factor=1.30+0.53*((handles.building.long_length-2)/(3*handles.building.short_length));
end

%consolidation tb_settlement
[row_pile_combo column_pile_combo]=size(handles.pile_combo);

for index_combo = 1:1:column_pile_combo                                                 %Consolidation is checked for all remaining pile combinations.
    pile_end_index=round(handles.pile_combo(index_combo).pile_length*10,0);             %The index corresponding to the pile end depth value is found in soil_details struct.
    end_soil_type=handles.soil_details(pile_end_index).type;                            %The soil type at the end of the pile is decided.
    pile_two_third_index=round(2/3*pile_end_index,0);
    two_third_soil_type=handles.soil_details(pile_two_third_index).type;
    consolidation_settlement=0;                                                         %Initial consolidation settlement is set to zero, which will be increased.
    
    if ((end_soil_type=="Clay")||(end_soil_type=="Silt"))&&((two_third_soil_type=="Clay")||(two_third_soil_type=="Silt")) %This "if" decides where to start 1H:2V stress distribution depending on the pile end soil type.
        delta_stress_start=pile_two_third_index;                                                                          %delta_stress_start keeps the index corresponding to the row number in soil_details struct.
    elseif ((end_soil_type=="Clean Sand")||(end_soil_type=="Clayey Sand")||(end_soil_type=="Silty Sand"))
        delta_stress_start=pile_end_index;
    else
        for i=pile_two_third_index:pile_end_index
            if (handles.soil_details(i).type=="Clay") || (handles.soil_details(i).type=="Silt")
                delta_stress_start=i;
                break;
            end
        end
    end
    consolidation_matrix=zeros(size(handles.delta_stress,2),5);                                                                 %Consolidation matrix with 10 cm intervals is created to keep consolidation settlement data.
    [row_cons col_cons]=size(consolidation_matrix);                                                                             %Consolidation will be calculated for each 10 cm intervals.
    for k = 1:1:(row_cons-1)
            index_term=round(delta_stress_start+k);                                                                                %round function is used to convert double values into int. This is needed while indexing in structs.
            consolidation_matrix(k,4)=handles.soil_details(index_term).poisson;
        if (handles.soil_details(delta_stress_start+k).type=="Clay") ||( handles.soil_details(delta_stress_start+k).type=="Silt")
            consolidation_matrix(k,5)=handles.soil_details(index_term).E_undrained; 
        else
            consolidation_matrix(k,5)=handles.soil_details(index_term).Es; 
        end
        
        if (handles.soil_details(delta_stress_start+k).type=="Clay" )||( handles.soil_details(delta_stress_start+k).type=="Silt")   %It is decideed that if the consolidation will occur at the current depth interval.
            if (delta_stress_start+k)>=(handles.gwt*10)                                                                             %It is decided that if the interval is saturated or not for cohesive intervals.
            consolidation_matrix(k,1)=(handles.delta_stress(k)+handles.delta_stress(k+1))/2;                                        %First column of the consolidation matrix is the stress increase at the midpoint. Note that stress increase is already calculated for each 10 cm.
            consolidation_matrix(k,2)=handles.soil_details(index_term).mv;                                                          %Volume of compressibility is assigned to the second column of the consolidation matrix.
            consolidation_matrix(k,3)=0.1*consolidation_matrix(k,1)*consolidation_matrix(k,2);                                      %The third column of consolidation matrix is settlement for the current depth interval.
            consolidation_settlement=consolidation_matrix(k,3)+consolidation_settlement;                                            %Total consolidation settlement value is updated.
            end
        else
            consolidation_settlement=consolidation_settlement;                                                                  %If the soil is not cohesive, no consolidation occurs for the current interval.
        end
    end
    handles.pile_combo(index_combo).consolidation_settlement=consolidation_settlement;                                                        %Total consoldiaiton settlement is kept pile_combo struct for each combination.
    
    %IMMEDIATE TB_SETTLEMENT
    weighted_poisson=sum(consolidation_matrix(:,4))/row_cons;
    weighted_E=sum(consolidation_matrix(:,5))/row_cons;
    handles.pile_combo(index_combo).immediate_settlement=(handles.delta_stress(1))*(handles.building.short_length)*(1-weighted_poisson^2)*(handles.influence_factor)/weighted_E;
    handles.pile_combo(index_combo).total_settlement=handles.pile_combo(index_combo).immediate_settlement+handles.pile_combo(index_combo).consolidation_settlement;
    %Combinations are classified according to comparison of their settlements and maximum allowable tb_settlement.
    if (handles.pile_combo(index_combo).total_settlement) <= (handles.building.max_settlement)*0.01              
        handles.pile_combo(index_combo).settlement_check=1;                     
    else
        handles.pile_combo(index_combo).settlement_check=0;
    end
    
end

for j = (index_combo-1):-1:1
    if handles.pile_combo(j).settlement_check==0
        handles.pile_combo(j)=[];
    end
end

if handles.pile.material=="Concrete"
    waitbar(0.65,wait_bar,'Placing reinforcement bars to piles...');
else
    waitbar(0.65,wait_bar,'Checking buckling for the steel pile...');
end
pause(1)

%Reinforcement calculations

for  i=1:size(handles.pile_combo,2)
    pile_number=handles.pile_combo(i).row_pile_number*handles.pile_combo(i).column_pile_number;
    single_pile_loading=handles.building.force/pile_number;
    if handles.pile.material=="Concrete"
        if handles.pile.shape=="Circle"
            area_pile=pi*(handles.pile_combo(i).diameter^2)/4*10^6; %area pile in mm2
        elseif handles.pile.shape=="Square"
            area_pile=(handles.pile_combo(i).edge^2)*10^6;
        else
        end
        long_steel_area=(single_pile_loading*10^3-0.51*handles.concrete_cd*area_pile)/handles.steel_cd;
        handles.pile_combo(i).pile_area=area_pile;
        
        %Eurocod-2 minumum requirements
        if area_pile<(0.5*10^6)
            min_steel_area=area_pile*0.005;
        elseif area_pile<(1*10^6)
            min_steel_area=2500;
        else
            min_steel_area=area_pile*0.0025;
        end
        
        long_steel_area=max(long_steel_area,min_steel_area);
        
        difference=500000;
        for rebar_diameter =16:2:32
            area_rebar=pi/4*(rebar_diameter^2);
            rebar_count=ceil(max(6,long_steel_area/area_rebar));
            
            if handles.pile.shape=="Square"
                if mod(rebar_count,4)==0
                    rebar_count=rebar_count;
                else   
                    rebar_count=rebar_count+4-mod(rebar_count,4);
                end            
            end
            if rebar_count>36                                              %this limitations stands for minumum spacing of rebars in TS500
                continue
            end
                         
            reinforcement_area=rebar_count*area_rebar;
            if (reinforcement_area/area_pile)>=0.01
                cap_rebar_count=rebar_count;
            else 
                cap_rebar_count=max(6,ceil(0.01*area_pile/area_rebar));
            end
            if handles.pile.shape=="Square"
                if mod(cap_rebar_count,4)==0
                    cap_rebar_count=cap_rebar_count;
                else
                    cap_rebar_count=cap_rebar_count+4-mod(cap_rebar_count,4);
                   
                end  
            end
            if cap_rebar_count>36                                              %this limitations stands for minumum spacing of rebars in TS500
                continue
            end
            if difference > (reinforcement_area-long_steel_area)
                optimum_rebar_diameter=rebar_diameter;
                optimum_rebar_count=rebar_count;
                optimum_reinforcement_area=reinforcement_area;
                difference=reinforcement_area-long_steel_area;
                optimum_cap_rebar_count=cap_rebar_count;
                optimum_cap_rebar_area=cap_rebar_count*area_rebar;
                
            end
            
        end
       handles.pile_combo(i).rebar_diameter=optimum_rebar_diameter;
       handles.pile_combo(i).rebar_count=optimum_rebar_count;
       handles.pile_combo(i).reinforcement_area=optimum_reinforcement_area;
       handles.pile_combo(i).cap_rebar_count=optimum_cap_rebar_count;
       handles.pile_combo(i).cap_reinforcement_area=optimum_cap_rebar_area;
       
       %spiral reinforcement
       if handles.pile.shape=="Circle" %Spiral reinforcement calculations
          
          if handles.pile_combo(i).diameter>0.6  %Eurocode
              clear_cover=60;
          else 
              clear_cover=50;
          end
          ack=(handles.pile_combo(i).diameter*1000-2*clear_cover)^2*pi/4;
          ps1=0.45*(handles.concrete_ck/handles.spiral_steel_ck)*((area_pile/ack)-1);
          ps2=0.12*(handles.concrete_ck/handles.spiral_steel_ck);
          ps=max(ps1,ps2);
          index_spiral=1;
          for spiral_diameter=10:2:12
              spiral_area=pi*spiral_diameter^2/4;
              spiral_spacing=(4*spiral_area)/ps/(handles.pile_combo(i).diameter*1000-2*clear_cover);
              spiral_spacing=(fix(spiral_spacing/10))*10;
              if spiral_spacing > 200
                  spiral_spacing=200;
              end
              spiral_matrix(index_spiral,1)=spiral_spacing;
              spiral_matrix(index_spiral,2)=spiral_area;
              if spiral_spacing>100
                  cap_spiral_spacing=100;
              else
                  cap_spiral_spacing=spiral_spacing;
              end
              spiral_matrix(index_spiral,3)=cap_spiral_spacing;
              core_perimeter=pi*(handles.pile_combo(i).diameter*1000-2*clear_cover);
              spiral_matrix(index_spiral,4)=core_perimeter*spiral_area;
              index_spiral=index_spiral+1;
              
          end
          confinement_depth=2*handles.pile_combo(i).diameter;
          handles.pile_combo(i).spiral_conf_depth=confinement_depth;
          
       elseif handles.pile.shape=="Square"
           if handles.pile_combo(i).edge>0.6  %Eurocode
              clear_cover=60; % unit: mm
          else 
              clear_cover=50;
           end
           
           bk=handles.pile_combo(i).edge*1000-2*clear_cover;
           ack=(bk)^2;
           index_spiral=1;
           for spiral_diameter=10:2:12
               spiral_area=pi*(spiral_diameter^2)/4;
               ash=4*spiral_area*sind(45);
               spiral_spacing=ash/(0.3*(handles.concrete_ck/handles.spiral_steel_ck)*bk*((area_pile/ack)-1));
               spiral_spacing=(fix(spiral_spacing/10))*10;
               spiral_matrix(index_spiral,1)=spiral_spacing;
               spiral_matrix(index_spiral,2)=spiral_area;
               if spiral_spacing>100
                  cap_spiral_spacing=100;
               else
                  cap_spiral_spacing=spiral_spacing;
               end
               spiral_matrix(index_spiral,3)=cap_spiral_spacing;
               core_perimeter=4*bk;
               spiral_matrix(index_spiral,4)=1.7*core_perimeter*spiral_area; %1.7 stands for different geometries for ties, which is considered as a representative value
               index_spiral=index_spiral+1;
           end
        confinement_depth=2*handles.pile_combo(i).edge;
        handles.pile_combo(i).spiral_conf_depth=confinement_depth;
        
       end
       handles.pile_combo(i).clear_cover=clear_cover;
       for index_volume_spiral = 1:2                                       %spiral reinforcement volume
           spiral_matrix(index_volume_spiral,5)= spiral_matrix(index_volume_spiral,4)*(ceil(confinement_depth/spiral_matrix(index_volume_spiral,3))+...
               ceil((handles.pile_combo(i).pile_length-confinement_depth)/spiral_matrix(index_volume_spiral,3)));         
       end
       if spiral_matrix(1,5)<spiral_matrix(2,5)
           optimum_spiral_diameter=10;
           optimum_spiral_volume=spiral_matrix(1,5);
           optimum_spiral_matrix=spiral_matrix(1,1);
           optimum_spiral_cap_spacing=spiral_matrix(1,3);
       else
           optimum_spiral_diameter=12;
           optimum_spiral_volume=spiral_matrix(2,5);
           optimum_spiral_matrix=spiral_matrix(2,1);
           optimum_spiral_cap_spacing=spiral_matrix(2,3);
       end
       handles.pile_combo(i).spiral_steel_diameter=optimum_spiral_diameter;
       handles.pile_combo(i).spiral_steel_spacing=optimum_spiral_matrix;
       handles.pile_combo(i).spiral_steel_volume=optimum_spiral_volume;
       handles.pile_combo(i).spiral_steel_cap_spacing=optimum_spiral_cap_spacing;
       
        
    elseif handles.pile.material == "Steel"
        
        if handles.pile.shape == "Circular_hollow"
            outer_diameter=handles.pile_combo(i).diameter;
            inner_diameter=handles.pile_combo(i).diameter-2*handles.pile_combo(i).wall_thickness/1000;
            area=pi/4*((handles.pile_combo(i).diameter)^2-(handles.pile_combo(i).wall_thickness/1000)^2);
            radius_of_gyration=0.5*sqrt(outer_diameter^2+inner_diameter^2);
            limit_ratio=2*handles.pile_combo(i).pile_length/radius_of_gyration;
            fe=pi^2*200000/limit_ratio;
            
            if limit_ratio < 4.71*(200000/handles.steel_ck)
                fcr=handles.steel_ck*(0.658^(handles.steel_ck/fe));
                pn=fcr*area/10^-3;
            else
                fcr=0.877*fe;
                pn=fcr*area/10^-3;
            end
                
            if single_pile_loading<=(0.9*pn)
               handles.pile_combo(i).load_check=1;
               
            elseif single_pile_loading>(0.9*pn)
               handles.pile_combo(i).load_check=0;
            end
                 
        end
        
    end

end

%Cost calculations
waitbar(0.80,wait_bar,'Calculating the cost...');
pause(1)

%for cost
for  i=1:size(handles.pile_combo,2)
    if handles.pile.material == "Concrete"
        pile_count=handles.pile_combo(i).row_pile_number*handles.pile_combo(i).column_pile_number;
        handles.pile_combo(i).concrete_volume=handles.pile_combo(i).pile_length*(handles.pile_combo(i).pile_area*10^-6)*pile_count;
        handles.pile_combo(i).concrete_cost=handles.pile_combo(i).concrete_volume*handles.cc_concrete_unit_cost;
        if handles.pile.shape=="Square"
            long_confinement_depth=handles.pile_combo(i).pile_length/3;
        elseif handles.pile.shape=="Circle"
            
             long_confinement_depth=handles.pile_combo(i).pile_length/3;
        else
        end
        
        handles.pile_combo(i).long_confinement_depth=long_confinement_depth;
        
        handles.pile_combo(i).longitudinal_steel_volume=((handles.pile_combo(i).reinforcement_area*10^-6)*(handles.pile_combo(i).pile_length-long_confinement_depth)...
            +handles.pile_combo(i).cap_reinforcement_area*(10^-6)*long_confinement_depth)*pile_count;
        handles.pile_combo(i).longitudinal_steel_cost=handles.pile_combo(i).longitudinal_steel_volume*handles.cc_long_steel_unit_cost*7.85;
        handles.pile_combo(i).spiral_steel_cost=handles.pile_combo(i).spiral_steel_volume*7.85*(10^-6)*handles.cc_spiral_unit_cost*pile_count;
        handles.pile_combo(i).total_cost=handles.pile_combo(i).spiral_steel_cost+handles.pile_combo(i).longitudinal_steel_cost+handles.pile_combo(i).concrete_cost;
   
    elseif handles.pile.material == "Steel"
        pile_count=handles.pile_combo(i).row_pile_number*handles.pile_combo(i).column_pile_number;
        
        inner_diameter=handles.pile_combo(i).diameter - (2*handles.pile_combo(i).wall_thickness/1000);
        pile_cross_section=pi*((handles.pile_combo(i).diameter^2)-(inner_diameter^2))/4;
        handles.pile_combo(i).steel_pile_volume=handles.pile_combo(i).pile_length*pile_cross_section;
        handles.pile_combo(i).total_cost=pile_count*(handles.pile_combo(i).steel_pile_volume*7.85*handles.sc_steel_unit_cost);
        
    end
end

%Choosing the cost optimal solution
waitbar(0.85,wait_bar,'Finding the best pile configuration...');
pause(1)
lowest_cost=99999999999999;
best_pile_index=[];
for  i=1:size(handles.pile_combo,2)
    if lowest_cost>handles.pile_combo(i).total_cost
        lowest_cost=handles.pile_combo(i).total_cost;
        best_pile_index=i;
    end
end

%checking if an optimum case is found
if isempty(best_pile_index)
        wrr = warndlg('There is no optimum combo for this case! ','Warning');
        close(wait_bar)
        return
end


handles.TB_pile_designer.Value=1;
handles.PNL_pile_input.Visible='off';
handles.PNL_pile_designer.Visible='on';


%Visualizing the data
waitbar(0.90,wait_bar,'Visualizing pile configuration...');
pause(1)
cla(handles.axes_3D_viewer);
cla(handles.axes_best_pile_top_view);
cla(handles.axes_best_pile_long_view);
handles.axes_best_pile_top_view.Visible='on';
handles.axes_best_pile_long_view.Visible='on';
%drawing top view of pile configuration
set(handles.axes_best_pile_top_view,'XLim',[-0.1*handles.building.long_length 1.3*handles.building.long_length],'YLim',[-0.1*handles.building.short_length 1.1*handles.building.short_length]);

best_pile_count=handles.pile_combo(best_pile_index).row_pile_number*handles.pile_combo(best_pile_index).column_pile_number;

rectangle('Position',[0 0 handles.building.long_length handles.building.short_length],'Parent',handles.axes_best_pile_top_view,'EdgeColor','k','LineWidth',2);
if handles.pile.shape=="Circle" || handles.pile.material == "Steel"
    for k = 1:handles.pile_combo(best_pile_index).column_pile_number %k is column index
        for j = 1:handles.pile_combo(best_pile_index).row_pile_number %j is row index
            center_x=(0.5*handles.pile_combo(best_pile_index).diameter)+(k-1)*(handles.building.long_length-handles.pile_combo(best_pile_index).diameter)/(handles.pile_combo(best_pile_index).column_pile_number-1);
            center_y=(0.5*handles.pile_combo(best_pile_index).diameter)+(j-1)*(handles.building.short_length-handles.pile_combo(best_pile_index).diameter)/(handles.pile_combo(best_pile_index).row_pile_number-1);
            viscircles(handles.axes_best_pile_top_view,[center_x center_y],handles.pile_combo(best_pile_index).diameter/2,'Color','r');
        end
    end
elseif handles.pile.shape=="Square"   
    for k = 1:handles.pile_combo(best_pile_index).column_pile_number %k is column index
        for j = 1:handles.pile_combo(best_pile_index).row_pile_number %j is row index
            start_x=(k-1)*(handles.building.long_length-handles.pile_combo(best_pile_index).edge)/(handles.pile_combo(best_pile_index).column_pile_number-1);
            start_y=(j-1)*(handles.building.short_length-handles.pile_combo(best_pile_index).edge)/(handles.pile_combo(best_pile_index).row_pile_number-1);
            rectangle('Position',[start_x start_y handles.pile_combo(best_pile_index).edge handles.pile_combo(best_pile_index).edge],'FaceColor','r','Parent',handles.axes_best_pile_top_view);
            
        end
    end   
end
soil_input_cell=handles.TBL_data.Data;
layer_number=handles.layer_number;
total_depth=sum(cell2mat(soil_input_cell(:,1)));
depth_rectangle=total_depth*-1;
set(handles.axes_best_pile_long_view,'XLim',[-0.1*handles.building.long_length 1.3*handles.building.long_length]);
set(handles.axes_best_pile_long_view,'YLim',[-1*total_depth 0]);

for i=layer_number:-1:1
    matrix_color=handles.matrix_color(i).color;
    layer_thickness=cell2mat(soil_input_cell(i,1));
    handles.soil_parameters(i).layer_thickness=layer_thickness;
    rectangle('Position', [-0.1*handles.building.long_length depth_rectangle 1.4*handles.building.long_length layer_thickness],...
        'FaceColor',matrix_color,...
        'Parent', handles.axes_best_pile_long_view);
    text(1.16*handles.building.long_length, (depth_rectangle+layer_thickness/2) ,handles.soil_parameters(i).type, 'horizontalAlignment', 'center',...
        'verticalAlignment', 'middle','Parent',handles.axes_best_pile_long_view);
    depth_rectangle=depth_rectangle+layer_thickness;    
end
if handles.pile.shape=="Circle" || handles.pile.material == "Steel"
    for k = 1:handles.pile_combo(best_pile_index).column_pile_number %k is column index
            start_x=(k-1)*(handles.building.long_length-handles.pile_combo(best_pile_index).diameter)/(handles.pile_combo(best_pile_index).column_pile_number-1);
            start_y=-1*handles.pile_combo(best_pile_index).pile_length;
            rectangle('Position',[start_x start_y handles.pile_combo(best_pile_index).diameter handles.pile_combo(best_pile_index).pile_length],'FaceColor','k','Parent',handles.axes_best_pile_long_view);
        
    end
elseif handles.pile.shape=="Square"   
    for k = 1:handles.pile_combo(best_pile_index).column_pile_number %k is column index
        for j = 1:handles.pile_combo(best_pile_index).row_pile_number %j is row index
            start_x=(k-1)*(handles.building.long_length-handles.pile_combo(best_pile_index).edge)/(handles.pile_combo(best_pile_index).column_pile_number-1);
            start_y=-1*handles.pile_combo(best_pile_index).pile_length;
            rectangle('Position',[start_x start_y handles.pile_combo(best_pile_index).edge handles.pile_combo(best_pile_index).pile_length],'FaceColor','k','Parent',handles.axes_best_pile_long_view);
        end
    end   
end

%best_pile_index
%printing optimum pile output to Pile Designer
handles.ST_row_pile_number_result.String=[num2str(handles.pile_combo(best_pile_index).row_pile_number)];
handles.ST_column_pile_number_result.String=[num2str(handles.pile_combo(best_pile_index).column_pile_number)];
handles.ST_pile_length_result.String=[num2str(handles.pile_combo(best_pile_index).pile_length)];
handles.ST_max_sett_results.String=[num2str(round(100*handles.pile_combo(best_pile_index).total_settlement,2))];
if handles.pile.shape=="Square"
    handles.ST_pile_diameter_result.String=[num2str(handles.pile_combo(best_pile_index).edge)];
    handles.ST_pile_diameter.String=['Pile Edge (m)'];
else
    handles.ST_pile_diameter.String=['Pile Diameter (m)'];
    handles.ST_pile_diameter_result.String=[num2str(handles.pile_combo(best_pile_index).diameter)];
end
if handles.pile.material=="Steel"
    handles.ST_wall_thickness_result.String=handles.pile_combo(i).wall_thickness;
    handles.ST_wall_thickness_result.Visible='on';
    handles.ST_wall_thickness_text.Visible='on';
else
    handles.ST_wall_thickness_result.Visible='off';
    handles.ST_wall_thickness_text.Visible='off';
end
single_cap_rounded=round(handles.pile_combo(best_pile_index).single_pile_capacity,0);
group_cap_rounded=round(handles.pile_combo(best_pile_index).group_pile_capacity,0);
format long

handles.ST_single_pile_capacity_result.String=[num2str(single_cap_rounded)];
handles.ST_group_pile_capacity_result.String=[num2str(group_cap_rounded)];
handles.ST_fs_result.String=[num2str(round(handles.pile_combo(best_pile_index).factor_of_safety,2))];
handles.ST_steel_maliyet.String=num2str(round(handles.pile_combo(best_pile_index).total_cost,0));

if handles.pile.material == "Steel"
    handles.ST_steel_maliyet_text.Visible='on';  %Cost will display only if piles are steel 
    handles.ST_steel_maliyet.Visible='on';       %For concrete, it will be shown in Cost Analysis tab
else
    handles.TB_reinforcement_drawing.Visible='on';
    handles.TB_cost_analysis.Visible='on';
end

%3D viewer
axes(handles.axes_3D_viewer);

set(handles.axes_3D_viewer,'XLim',[-0.1*handles.building.long_length 1.3*handles.building.long_length],'YLim',[-0.1*handles.building.short_length 1.1*handles.building.short_length],'ZLim',[-1.1*handles.pile_combo(best_pile_index).pile_length 0.2*handles.pile_combo(best_pile_index).pile_length]);
pile_number=(handles.pile_combo(best_pile_index).row_pile_number)*(handles.pile_combo(best_pile_index).column_pile_number);
pile_length=handles.pile_combo(best_pile_index).pile_length;

 %Drawing piles in 3d 
if (handles.pile.shape=="Circle") || (handles.pile.material == "Steel")
    pile_diameter=handles.pile_combo(best_pile_index).diameter;
    for k = 1:handles.pile_combo(best_pile_index).column_pile_number %k is column index
        for j = 1:handles.pile_combo(best_pile_index).row_pile_number %j is row index
            hold on;
            center_x=(0.5*handles.pile_combo(best_pile_index).diameter)+(k-1)*(handles.building.long_length-handles.pile_combo(best_pile_index).diameter)/(handles.pile_combo(best_pile_index).column_pile_number-1);
            center_y=(0.5*handles.pile_combo(best_pile_index).diameter)+(j-1)*(handles.building.short_length-handles.pile_combo(best_pile_index).diameter)/(handles.pile_combo(best_pile_index).row_pile_number-1);
            [x y z]=cylinder(pile_diameter/2,30);
            z=-1*z*pile_length;
            x=x+center_x;
            y=y+center_y;
            surf(handles.axes_3D_viewer,x,y,z,'FaceColor',[0.9 0.9 0.22]);
            hold on;
        end
    end   
else
    edge=handles.pile_combo(best_pile_index).edge;
    for k = 1:handles.pile_combo(best_pile_index).column_pile_number %k is column index
       for j = 1:handles.pile_combo(best_pile_index).row_pile_number %j is row index
            hold on;
            start_x=(k-1)*(handles.building.long_length-handles.pile_combo(best_pile_index).edge)/(handles.pile_combo(best_pile_index).column_pile_number-1);
            start_y=(j-1)*(handles.building.short_length-handles.pile_combo(best_pile_index).edge)/(handles.pile_combo(best_pile_index).row_pile_number-1);
            x=[start_x (start_x+edge) (start_x+edge) start_x start_x;start_x (start_x+edge) (start_x+edge) start_x start_x];
            y=[start_y start_y (start_y+edge) (start_y+edge) start_y;start_y start_y (start_y+edge) (start_y+edge) start_y];
            z=[-1*pile_length -1*pile_length -1*pile_length -1*pile_length -1*pile_length;0 0 0 0 0];
            surf(handles.axes_3D_viewer,x,y,z,'FaceColor',[0.9 0.9 0.22]);
            
       end
    end   
end

%Drawing 3d top rectangle prism
hold on;
x=[0 handles.building.long_length handles.building.long_length 0 0;0 handles.building.long_length handles.building.long_length 0 0];
y=[0 0 handles.building.short_length handles.building.short_length 0;0 0 handles.building.short_length handles.building.short_length 0];
z=[0 0 0 0 0;1 1 1 1 1];
surf(handles.axes_3D_viewer,x,y,z,'FaceColor',[0.8500 0.3250 0.0980]);
z=[1 1 1 1 1;0 0 0 0 0];
patch(handles.axes_3D_viewer,x',y',z',[0.8500 0.3250 0.0980]);
view(handles.axes_3D_viewer, 3);
%hold(handles.axes_3D_viewer, 'on');
%rotate3d(handles.axes_3D_viewer,'on');
%Printing results in cost analysis tab
format long
if handles.pile.material=="Concrete"
    set(handles.ST_total_cost_result,'String',sprintf('%.0f',handles.pile_combo(best_pile_index).total_cost));
    set(handles.ST_spiral_steel_cost_result,'String',sprintf('%.0f',handles.pile_combo(best_pile_index).spiral_steel_cost));
    set(handles.ST_concrete_cost_result,'String',sprintf('%.0f',handles.pile_combo(best_pile_index).concrete_cost));
    set(handles.ST_long_steel_cost_result,'String',sprintf('%.0f',handles.pile_combo(best_pile_index).longitudinal_steel_cost));
end
%Drawing pie chart for cost
if handles.pile.material=="Concrete"
    cost_data=[handles.pile_combo(best_pile_index).longitudinal_steel_cost handles.pile_combo(best_pile_index).concrete_cost handles.pile_combo(best_pile_index).spiral_steel_cost];
    labels_pie={'Longitudinal Steel','Concrete','Spiral Steel'};
    t=pie(handles.axes_cost_pie_chart,cost_data);
    
    tText = findobj(t,'Type','text');
    percentValues = get(tText,'String'); 
    txt = {'Longitudinal Steel(';'Concrete(';'Spiral Steel('}; 
    combinedtxt = strcat(txt,percentValues,')');
    
    tText(1).String = combinedtxt(1);
    tText(2).String = combinedtxt(2);
    tText(3).String = combinedtxt(3);
end

%Printing reinforcement information

if handles.pile.material=="Concrete"
    handles.ST_cap_long_reinforcement.String=[num2str(handles.pile_combo(best_pile_index).cap_rebar_count),'Ø',num2str(handles.pile_combo(best_pile_index).rebar_diameter)];    
    handles.ST_cap_spiral_reinforcement.String=['Ø',num2str(handles.pile_combo(best_pile_index).spiral_steel_diameter),'/',num2str(handles.pile_combo(best_pile_index).spiral_steel_cap_spacing)];
    handles.ST_cap_long_conf_depth.String=[num2str(round(handles.pile_combo(best_pile_index).long_confinement_depth,1)), ' m'];   
    handles.ST_cap_conf_spiral_depth.String=[num2str(round(handles.pile_combo(best_pile_index).spiral_conf_depth,1)), ' m'];
    handles.ST_body_long_reinforcement.String=[num2str(handles.pile_combo(best_pile_index).rebar_count),'Ø',num2str(handles.pile_combo(best_pile_index).rebar_diameter)];
    handles.ST_body_spiral_reinforcement.String=['Ø',num2str(handles.pile_combo(best_pile_index).spiral_steel_diameter),'/',num2str(handles.pile_combo(best_pile_index).spiral_steel_spacing)];
end

%Drawing reinforcement
cla(handles.axes_cap_long_reinforcement);
cla(handles.axes_body_long_reinforcement);
if handles.pile.material=="Concrete"
    if handles.pile.shape=="Circle"
        
       
        %Cap long reinforcement drawing
        set(handles.axes_cap_long_reinforcement,'XLim',[-1.1*handles.pile_combo(best_pile_index).diameter*500 1.1*handles.pile_combo(best_pile_index).diameter*500],'YLim',[-1.1*handles.pile_combo(best_pile_index).diameter*500 1.1*handles.pile_combo(best_pile_index).diameter*500]);
        viscircles(handles.axes_cap_long_reinforcement,[0 0],500*handles.pile_combo(best_pile_index).diameter,'Color','k');
        hold on
        viscircles(handles.axes_cap_long_reinforcement,[0 0],500*handles.pile_combo(best_pile_index).diameter-handles.pile_combo(best_pile_index).clear_cover,'Color','k');
        hold on 
        viscircles(handles.axes_cap_long_reinforcement,[0 0],500*handles.pile_combo(best_pile_index).diameter-handles.pile_combo(best_pile_index).clear_cover+handles.pile_combo(best_pile_index).spiral_steel_diameter,'Color','k');
        hold on
        degree=0;
        radius=(1000*handles.pile_combo(best_pile_index).diameter-2*handles.pile_combo(best_pile_index).clear_cover-2*handles.pile_combo(best_pile_index).spiral_steel_diameter)/2;
        degree_increase=360/handles.pile_combo(best_pile_index).cap_rebar_count;
        for index_reinf=1:handles.pile_combo(best_pile_index).cap_rebar_count
            center_x=radius*cosd(degree);
            center_y=radius*sind(degree);
            viscircles(handles.axes_cap_long_reinforcement,[center_x center_y],handles.pile_combo(best_pile_index).rebar_diameter/2,'Color','r');
            degree=degree+degree_increase;
        end
        handles.axes_cap_long_reinforcement.XAxis.Visible='off';
        handles.axes_cap_long_reinforcement.YAxis.Visible='off';
       %Body long reinforcement drawing
       set(handles.axes_body_long_reinforcement,'XLim',[-1.1*handles.pile_combo(best_pile_index).diameter*500 1.1*handles.pile_combo(best_pile_index).diameter*500],'YLim',[-1.1*handles.pile_combo(best_pile_index).diameter*500 1.1*handles.pile_combo(best_pile_index).diameter*500]);
       viscircles(handles.axes_body_long_reinforcement,[0 0],500*handles.pile_combo(best_pile_index).diameter,'Color','k');
        hold on
        viscircles(handles.axes_body_long_reinforcement,[0 0],500*handles.pile_combo(best_pile_index).diameter-handles.pile_combo(best_pile_index).clear_cover,'Color','k');
        hold on 
        viscircles(handles.axes_body_long_reinforcement,[0 0],500*handles.pile_combo(best_pile_index).diameter-handles.pile_combo(best_pile_index).clear_cover+handles.pile_combo(best_pile_index).spiral_steel_diameter,'Color','k');
        hold on
        degree=0;
        radius=(1000*handles.pile_combo(best_pile_index).diameter-2*handles.pile_combo(best_pile_index).clear_cover-2*handles.pile_combo(best_pile_index).spiral_steel_diameter)/2;
        degree_increase=360/handles.pile_combo(best_pile_index).rebar_count;
        for index_reinf=1:handles.pile_combo(best_pile_index).rebar_count
            center_x=radius*cosd(degree);
            center_y=radius*sind(degree);
            viscircles(handles.axes_body_long_reinforcement,[center_x center_y],handles.pile_combo(best_pile_index).rebar_diameter/2,'Color','r');
            degree=degree+degree_increase;
        end
        handles.axes_body_long_reinforcement.XAxis.Visible='off';
        handles.axes_body_long_reinforcement.YAxis.Visible='off';
    elseif handles.pile.shape=="Square"
        %Cap long reinforcement drawing
        set(handles.axes_cap_long_reinforcement,'XLim',[0 handles.pile_combo(best_pile_index).edge*1000],'YLim',[0 handles.pile_combo(best_pile_index).edge*1000]);
        rectangle(handles.axes_cap_long_reinforcement,'Position',[0 0 handles.pile_combo(best_pile_index).edge*1000 handles.pile_combo(best_pile_index).edge*1000]);
        hold on
        %core dimensions of the pile
        core_edge=(handles.pile_combo(best_pile_index).edge*1000)-(2*clear_cover)-(handles.pile_combo(best_pile_index).rebar_diameter);
        
        %edge reinforcement count for cap
        cap_edge_bar_count=((handles.pile_combo(best_pile_index).cap_rebar_count-4)/4)+2;       
        
        %bar spacing 
        cap_spacing_drawing=core_edge/(cap_edge_bar_count-1);
        
        %drawing bottom longitudinal cap reinforcement
        for index_reinf=1:cap_edge_bar_count
            center_x=clear_cover+handles.pile_combo(best_pile_index).rebar_diameter/2+(index_reinf-1)*cap_spacing_drawing;
            center_y=clear_cover+handles.pile_combo(best_pile_index).rebar_diameter/2;
            viscircles(handles.axes_cap_long_reinforcement,[center_x center_y],handles.pile_combo(best_pile_index).rebar_diameter/2,'Color','r');
        end
        %drawing top longitudinal cap reinforcement
        for index_reinf=1:cap_edge_bar_count
            center_x=clear_cover+handles.pile_combo(best_pile_index).rebar_diameter/2+(index_reinf-1)*cap_spacing_drawing;
            center_y=handles.pile_combo(best_pile_index).edge*1000-(clear_cover+handles.pile_combo(best_pile_index).rebar_diameter/2);
            viscircles(handles.axes_cap_long_reinforcement,[center_x center_y],handles.pile_combo(best_pile_index).rebar_diameter/2,'Color','r');
        end
        %drawing left side cap reinforcement
        for index_reinf=1:cap_edge_bar_count-2
            center_x=clear_cover+handles.pile_combo(best_pile_index).rebar_diameter/2;
            center_y=clear_cover+handles.pile_combo(best_pile_index).rebar_diameter/2+index_reinf*cap_spacing_drawing;
            viscircles(handles.axes_cap_long_reinforcement,[center_x center_y],handles.pile_combo(best_pile_index).rebar_diameter/2,'Color','r');
        end
        %drawing right side cap reinforcement
         for index_reinf=1:cap_edge_bar_count-2
            center_x=handles.pile_combo(best_pile_index).edge*1000-clear_cover-handles.pile_combo(best_pile_index).rebar_diameter/2;
            center_y=clear_cover+handles.pile_combo(best_pile_index).rebar_diameter/2+index_reinf*cap_spacing_drawing;
            viscircles(handles.axes_cap_long_reinforcement,[center_x center_y],handles.pile_combo(best_pile_index).rebar_diameter/2,'Color','r');
        end
   
        handles.axes_cap_long_reinforcement.XAxis.Visible='off';
        handles.axes_cap_long_reinforcement.YAxis.Visible='off';
       
        %Body long reinforcement drawing
        set(handles.axes_body_long_reinforcement,'XLim',[0 handles.pile_combo(best_pile_index).edge*1000],'YLim',[0 handles.pile_combo(best_pile_index).edge*1000]);
        rectangle(handles.axes_body_long_reinforcement,'Position',[0 0 handles.pile_combo(best_pile_index).edge*1000 handles.pile_combo(best_pile_index).edge*1000]);
        hold on
        
        %edge reinforcement count for cap
        body_edge_bar_count=((handles.pile_combo(best_pile_index).rebar_count-4)/4)+2;       
        
        %bar spacing 
        body_spacing_drawing=core_edge/(body_edge_bar_count-1);
        
       %drawing bottom longitudinal body reinforcement
        for index_reinf=1:body_edge_bar_count
            center_x=clear_cover+handles.pile_combo(best_pile_index).rebar_diameter/2+(index_reinf-1)*body_spacing_drawing;
            center_y=clear_cover+handles.pile_combo(best_pile_index).rebar_diameter/2;
            viscircles(handles.axes_body_long_reinforcement,[center_x center_y],handles.pile_combo(best_pile_index).rebar_diameter/2,'Color','r');
        end
        %drawing top longitudinal cap reinforcement
        for index_reinf=1:body_edge_bar_count
            center_x=clear_cover+handles.pile_combo(best_pile_index).rebar_diameter/2+(index_reinf-1)*body_spacing_drawing;
            center_y=handles.pile_combo(best_pile_index).edge*1000-(clear_cover+handles.pile_combo(best_pile_index).rebar_diameter/2);
            viscircles(handles.axes_body_long_reinforcement,[center_x center_y],handles.pile_combo(best_pile_index).rebar_diameter/2,'Color','r');
        end
        
        %drawing left side cap reinforcement
        for index_reinf=1:body_edge_bar_count-2
            center_x=clear_cover+handles.pile_combo(best_pile_index).rebar_diameter/2;
            center_y=clear_cover+handles.pile_combo(best_pile_index).rebar_diameter/2+index_reinf*body_spacing_drawing;
            viscircles(handles.axes_body_long_reinforcement,[center_x center_y],handles.pile_combo(best_pile_index).rebar_diameter/2,'Color','r');
        end
        
        %drawing right side cap reinforcement
        for index_reinf=1:body_edge_bar_count-2
            center_x=handles.pile_combo(best_pile_index).edge*1000-clear_cover-handles.pile_combo(best_pile_index).rebar_diameter/2;
            center_y=clear_cover+handles.pile_combo(best_pile_index).rebar_diameter/2+index_reinf*body_spacing_drawing;
            viscircles(handles.axes_body_long_reinforcement,[center_x center_y],handles.pile_combo(best_pile_index).rebar_diameter/2,'Color','r');
        end
        
        %Drawing edge ties
        inner_edge_tie_length=handles.pile_combo(best_pile_index).edge*1000-2*clear_cover;
        outer_edge_tie_length=2*handles.pile_combo(best_pile_index).spiral_steel_diameter+inner_edge_tie_length;
        rectangle(handles.axes_cap_long_reinforcement,'Position',[clear_cover clear_cover inner_edge_tie_length inner_edge_tie_length],'Curvature',0.06);
        rectangle(handles.axes_cap_long_reinforcement,'Position',[clear_cover-handles.pile_combo(best_pile_index).spiral_steel_diameter clear_cover-handles.pile_combo(best_pile_index).spiral_steel_diameter outer_edge_tie_length outer_edge_tie_length],'Curvature',0.063);
        
        rectangle(handles.axes_body_long_reinforcement,'Position',[clear_cover clear_cover inner_edge_tie_length inner_edge_tie_length],'Curvature',0.06);
        rectangle(handles.axes_body_long_reinforcement,'Position',[clear_cover-handles.pile_combo(best_pile_index).spiral_steel_diameter clear_cover-handles.pile_combo(best_pile_index).spiral_steel_diameter outer_edge_tie_length outer_edge_tie_length],'Curvature',0.063);
        handles.axes_body_long_reinforcement.XAxis.Visible='off';
        handles.axes_body_long_reinforcement.YAxis.Visible='off';
        
        %Drawing middle ties for cap
        if mod(cap_edge_bar_count,2)==1
            
        end
  
              
    end 
end

%Colorful Settlement

%consolidation settlement of best pile combination
[row_pile_combo column_pile_combo]=size(handles.pile_combo(best_pile_index));
                                                                           %Consolidation is checked for all remaining pile combinations.
pile_end_index=round(handles.pile_combo(best_pile_index).pile_length*10,0);    %The index corresponding to the pile end depth value is found in soil_details struct.
end_soil_type=handles.soil_details(pile_end_index).type;                   %The soil type at the end of the pile is decided.
pile_two_third_index=round(2/3*pile_end_index,0);
two_third_soil_type=handles.soil_details(pile_two_third_index).type;
consolidation_settlement=0;                                                         %Initial consolidation settlement is set to zero, which will be increased.

if ((end_soil_type=="Clay")||(end_soil_type=="Silt"))&&((two_third_soil_type=="Clay")||(two_third_soil_type=="Silt")) %This "if" decides where to start 1H:2V stress distribution depending on the pile end soil type.
    delta_stress_start=pile_two_third_index;                                                                          %delta_stress_start keeps the index corresponding to the row number in soil_details struct.
elseif ((end_soil_type=="Clean Sand")||(end_soil_type=="Clayey Sand")||(end_soil_type=="Silty Sand"))
    delta_stress_start=pile_end_index;
else
    for i=pile_two_third_index:pile_end_index
        if (handles.soil_details(i).type=="Clay") || (handles.soil_details(i).type=="Silt")
            delta_stress_start=i;
            break;
        end
    end
end
consolidation_matrix=zeros(size(handles.delta_stress,2),5);                                                                 %Consolidation matrix with 10 cm intervals is created to keep consolidation settlement data.
[row_cons col_cons]=size(consolidation_matrix);                                                                             %Consolidation will be calculated for each 10 cm intervals.
for k = 1:1:(row_cons-1)
        index_term=round(delta_stress_start+k);                                                                                %round function is used to convert double values into int. This is needed while indexing in structs.
        consolidation_matrix(k,4)=handles.soil_details(index_term).poisson;
    if (handles.soil_details(delta_stress_start+k).type=="Clay") ||( handles.soil_details(delta_stress_start+k).type=="Silt")
        consolidation_matrix(k,5)=handles.soil_details(index_term).E_undrained; 
    else
        consolidation_matrix(k,5)=handles.soil_details(index_term).Es; 
    end

    if (handles.soil_details(delta_stress_start+k).type=="Clay" )||( handles.soil_details(delta_stress_start+k).type=="Silt")   %It is decideed that if the consolidation will occur at the current depth interval.
        if (delta_stress_start+k)>=(handles.gwt*10)                                                                             %It is decided that if the interval is saturated or not for cohesive intervals.
        consolidation_matrix(k,1)=(handles.delta_stress(k)+handles.delta_stress(k+1))/2;                                        %First column of the consolidation matrix is the stress increase at the midpoint. Note that stress increase is already calculated for each 10 cm.
        consolidation_matrix(k,2)=handles.soil_details(index_term).mv;                                                          %Volume of compressibility is assigned to the second column of the consolidation matrix.
        consolidation_matrix(k,3)=0.1*consolidation_matrix(k,1)*consolidation_matrix(k,2);                                      %The third column of consolidation matrix is settlement for the current depth interval.
        consolidation_settlement=consolidation_matrix(k,3)+consolidation_settlement;                                            %Total consolidation settlement value is updated.
        end
    else
        consolidation_settlement=consolidation_settlement;                                                                  %If the soil is not cohesive, no consolidation occurs for the current interval.
    end
end
if consolidation_settlement==0
  handles.TB_settlement.Visible='off';
  handles.PNL_settlement.Visible='off';
else
  handles.TB_settlement.Visible='on';
  handles.PNL_settlement.Visible='off';
%forming settlement map boundry values
a=1;
for i=10:10:(consolidation_boundry*100+10)               
    c=0;
    for j=1:(i/10)
        c=c+consolidation_matrix(j,3);
    end
    settlement_around(a)=-1*consolidation_settlement+c;
    a=a+1;
end
x=(-5*100-(handles.building.short_length/2)*100-consolidation_boundry*100):50:(5*100+(handles.building.short_length/2)*100+consolidation_boundry*100);
y=(-5*100-(handles.building.long_length/2)*100-consolidation_boundry*100):50:(5*100+(handles.building.long_length/2)*100+consolidation_boundry*100);
[X,Y]=meshgrid(x,y);
[row_x col_x]=size(X);
Z=zeros(row_x,col_x);
for index_x=1:1:row_x
    for index_y=1:1:col_x
        
        if abs(X(index_x,index_y))<=(handles.building.short_length/2)*100 &&  abs(Y(index_x,index_y))<=(handles.building.long_length/2)*100
            Z(index_x,index_y)=-1*consolidation_settlement;
        elseif abs(X(index_x,index_y))<((handles.building.short_length/2)*100+consolidation_boundry*100) &&  abs(Y(index_x,index_y))<((handles.building.long_length/2)*100+consolidation_boundry*100);       
            delta_x=abs(X(index_x,index_y))-(handles.building.short_length/2)*100;
            delta_y=abs(Y(index_x,index_y))-(handles.building.long_length/2)*100;
            if delta_x > delta_y
                Z(index_x,index_y)=settlement_around(max(1,round(delta_x/10,0)));
            else
                Z(index_x,index_y)=settlement_around(max(1,round(delta_y/10,0)));
            end
        else 
            Z(index_x,index_y)=0;
        end
        
    end
end
axes(handles.axes_settle3d);

surf(handles.axes_settle3d,X,Y,Z);
set(handles.axes_settle3d,'XLim',[-5*100-(handles.building.short_length/2)*100-consolidation_boundry*100 5*100+(handles.building.short_length/2)*100+consolidation_boundry*100],...
    'YLim',[-5*100-(handles.building.long_length/2)*100-consolidation_boundry*100 5*100+(handles.building.long_length/2)*100+consolidation_boundry*100],...
    'ZLim',[-1.5*consolidation_settlement 0]);
%rotate3d(handles.axes_settle3d,'on');
colormap(handles.axes_settle3d,flipud(jet))
legend_for_settlement=colorbar('Direction','reverse');
legend_for_settlement.Label.String = 'Consolidation Settlement(m)';

end
%Design completed
waitbar(1,wait_bar,'Completed!');
pause(1)
close(wait_bar)
guidata(hObject, handles);
b=5;
% --- Executes when selected object is changed in BG_bored_pile_material.
function BG_bored_pile_material_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in BG_bored_pile_material 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.RB_bored_concrete.Value==1
    handles.pile.material='Concrete';
    handles.BG_bored_pile_shape.Visible='on';
    handles.BG_steel_case_pile_properties.Visible='off';
    handles.BG_concrete_case_pile_properties.Visible='on';
    handles.ST_steel_maliyet_text.Visible='off';
    handles.ST_steel_maliyet.Visible='off';
else
    handles.BG_bored_pile_shape.Visible='off';
end
guidata(hObject, handles);

% --- Executes when selected object is changed in BG_driven_concrete_pile_shape.
function BG_driven_concrete_pile_shape_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in BG_driven_concrete_pile_shape 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.RB_rectangle.Value==1
    handles.pile.shape='Square';
elseif handles.RB_circular.Value==1
    handles.pile.shape='Circle';
else
end
guidata(hObject, handles);

% --- Executes when selected object is changed in BG_driven_pile_material.
function BG_driven_pile_material_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in BG_driven_pile_material 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.RB_steel.Value==1
    handles.pile.material='Steel';
    handles.BG_driven_steel_pile_shape.Visible='on';
    handles.BG_driven_concrete_pile_shape.Visible='off';
    handles.RB_circular.Value=0;
    handles.RB_rectangle.Value=0;
    handles.RB_driven_steel_circular_hollow.Value=0;
    handles.RB_driven_steel_circular_filled.Value=0;
    handles.BG_steel_case_pile_properties.Visible='on';
    handles.BG_concrete_case_pile_properties.Visible='off';
    handles.TB_cost_analysis.Visible='off';
    handles.TB_reinforcement_drawing.Visible='off';
    
elseif handles.RB_driven_concrete.Value==1
    handles.pile.material='Concrete';
    handles.BG_driven_concrete_pile_shape.Visible='on';
    handles.BG_driven_steel_pile_shape.Visible='off';
    handles.RB_circular.Value=0;
    handles.RB_rectangle.Value=0;
    handles.RB_driven_steel_circular_hollow.Value=0;
    handles.RB_driven_steel_circular_filled.Value=0;
    handles.BG_concrete_case_pile_properties.Visible='on';
    handles.BG_steel_case_pile_properties.Visible='off';
    handles.ST_steel_maliyet_text.Visible='off';
    handles.ST_steel_maliyet.Visible='off';
else
end
guidata(hObject, handles);

% --- Executes on button press in RB_bored_concrete_circular.
function RB_bored_concrete_circular_Callback(hObject, eventdata, handles)
% hObject    handle to RB_bored_concrete_circular (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of RB_bored_concrete_circular


% --- Executes on button press in RB_bored_concrete_rectangle.
function RB_bored_concrete_rectangle_Callback(hObject, eventdata, handles)
% hObject    handle to RB_bored_concrete_rectangle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of RB_bored_concrete_rectangle


% --- Executes when selected object is changed in BG_bored_pile_shape.
function BG_bored_pile_shape_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in BG_bored_pile_shape 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.RB_bored_concrete_circular.Value==1
    handles.pile.shape='Circle';
elseif handles.RB_bored_concrete_rectangle.Value==1
    handles.pile.shape='Square';
else
end
guidata(hObject, handles);    
    
% --- Executes when selected object is changed in BG_driven_steel_pile_shape.
function BG_driven_steel_pile_shape_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in BG_driven_steel_pile_shape 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.RB_driven_steel_circular_hollow.Value==1
    handles.pile.shape='Circular_hollow';
elseif handles.RB_driven_steel_circular_filled.Value==1
    handles.pile.shape='Circular_filled';
else
end
guidata(hObject, handles);

% --- Executes on button press in RB_driven_pile.
function RB_driven_pile_Callback(hObject, eventdata, handles)
% hObject    handle to RB_driven_pile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of RB_driven_pile


% --- Executes on selection change in POP_sc_steel_type.
function POP_sc_steel_type_Callback(hObject, eventdata, handles)
% hObject    handle to POP_sc_steel_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value')==1
    handles.steel_ck=235;
elseif get(hObject,'Value')==2
    handles.steel_ck=275;
elseif get(hObject,'Value')==3
    handles.steel_ck=355;

else 
end
guidata(hObject, handles);
% Hints: contents = cellstr(get(hObject,'String')) returns POP_sc_steel_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from POP_sc_steel_type


% --- Executes during object creation, after setting all properties.
function POP_sc_steel_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to POP_sc_steel_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in POP_cc_concrete_type.
function POP_cc_concrete_type_Callback(hObject, eventdata, handles)
% hObject    handle to POP_cc_concrete_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value')==1
    handles.concrete_ck=25;
    handles.concrete_cd=25/1.5;
    
    
elseif get(hObject,'Value')==2
    handles.concrete_ck=30;
    handles.concrete_cd=30/1.5;
   
elseif get(hObject,'Value')==3
    handles.concrete_ck=35;
    handles.concrete_cd=35/1.5;
    
elseif get(hObject,'Value')==4
    handles.concrete_ck=40;
    handles.concrete_cd=40/1.5;
    
else 
end
handles.EDT_cc_concrete_unit_cost.Visible='on';
handles.ST_cc_concerete_unit_cost.Visible='on';

guidata(hObject, handles);

% Hints: contents = cellstr(get(hObject,'String')) returns POP_cc_concrete_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from POP_cc_concrete_type


% --- Executes during object creation, after setting all properties.
function POP_cc_concrete_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to POP_cc_concrete_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in POP_cc_steel_type.
function POP_cc_steel_type_Callback(hObject, eventdata, handles)
% hObject    handle to POP_cc_steel_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value')==1
    handles.steel_ck=220;
    handles.steel_cd=220/1.15;
    handles.ST_long_steel_cost.Visible='on';
    handles.EDT_cc_steel_unit_cost.Visible='on';
    handles.ST_long_steel_cost.String=['S220 Unit Cost(TL/tons)'];
    handles.PB_cc_steel_help.Visible='on';
    
elseif get(hObject,'Value')==2
    handles.steel_ck=420;
    handles.steel_cd=420/1.15;
    handles.ST_long_steel_cost.Visible='on';
    handles.EDT_cc_steel_unit_cost.Visible='on';
    handles.ST_long_steel_cost.String=['S420 Unit Cost(TL/tons)'];
    handles.PB_cc_steel_help.Visible='on';
    
elseif get(hObject,'Value')==3
    handles.steel_ck=500;
    handles.steel_cd=500/1.15;
    handles.ST_long_steel_cost.Visible='on';
    handles.EDT_cc_steel_unit_cost.Visible='on';
    handles.ST_long_steel_cost.String=['S500 Unit Cost(TL/tons)'];
    handles.PB_cc_steel_help.Visible='on';

else 
end
guidata(hObject, handles);
% Hints: contents = cellstr(get(hObject,'String')) returns POP_cc_steel_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from POP_cc_steel_type


% --- Executes during object creation, after setting all properties.
function POP_cc_steel_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to POP_cc_steel_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function EDT_cc_concrete_unit_cost_Callback(hObject, eventdata, handles)
% hObject    handle to EDT_cc_concrete_unit_cost (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.cc_concrete_unit_cost=str2double(get(hObject,'String'));
guidata(hObject, handles);

% Hints: get(hObject,'String') returns contents of EDT_cc_concrete_unit_cost as text
%        str2double(get(hObject,'String')) returns contents of EDT_cc_concrete_unit_cost as a double


% --- Executes during object creation, after setting all properties.
function EDT_cc_concrete_unit_cost_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EDT_cc_concrete_unit_cost (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EDT_cc_steel_unit_cost_Callback(hObject, eventdata, handles)
% hObject    handle to EDT_cc_steel_unit_cost (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.cc_long_steel_unit_cost=str2double(get(hObject,'String'));
if handles.steel_ck==handles.spiral_steel_ck
    handles.cc_spiral_unit_cost=handles.cc_long_steel_unit_cost;
end

guidata(hObject, handles);

% Hints: get(hObject,'String') returns contents of EDT_cc_steel_unit_cost as text
%        str2double(get(hObject,'String')) returns contents of EDT_cc_steel_unit_cost as a double


% --- Executes during object creation, after setting all properties.
function EDT_cc_steel_unit_cost_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EDT_cc_steel_unit_cost (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in PB_cc_help.
function PB_cc_help_Callback(hObject, eventdata, handles)
% hObject    handle to PB_cc_help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function EDT_sc_steel_unit_cost_Callback(hObject, eventdata, handles)
% hObject    handle to EDT_sc_steel_unit_cost (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.sc_steel_unit_cost=str2double(get(hObject,'String'));
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of EDT_sc_steel_unit_cost as text
%        str2double(get(hObject,'String')) returns contents of EDT_sc_steel_unit_cost as a double


% --- Executes during object creation, after setting all properties.
function EDT_sc_steel_unit_cost_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EDT_sc_steel_unit_cost (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in PB_sc_help.
function PB_sc_help_Callback(hObject, eventdata, handles)
% hObject    handle to PB_sc_help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function BG_concrete_case_pile_properties_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BG_concrete_case_pile_properties (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on selection change in POP_cc_spiral_steel_type.
function POP_cc_spiral_steel_type_Callback(hObject, eventdata, handles)
% hObject    handle to POP_cc_spiral_steel_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value')==1
    handles.spiral_steel_ck=220;
    handles.spiral_steel_cd=220/1.15;
    if handles.steel_ck==220
        
        handles.ST_spiral_unit_cost.Visible='off';
        handles.EDT_cc_spiral_unit_cost.Visible='off';
        handles.PB_cc_spiral_help.Visible='off';
        
    else 
        handles.ST_spiral_unit_cost.Visible='on';
        handles.EDT_cc_spiral_unit_cost.Visible='on';
        handles.ST_spiral_unit_cost.String=['S220 Unit Cost(TL/tons)'];
        handles.PB_cc_spiral_help.Visible='on';
    end
elseif get(hObject,'Value')==2
    handles.spiral_steel_ck=420;
    handles.spiral_steel_cd=420/1.15;
    if handles.steel_ck==420
        handles.ST_spiral_unit_cost.Visible='off';
        handles.EDT_cc_spiral_unit_cost.Visible='off';
        handles.PB_cc_spiral_help.Visible='off';
        
    else 
        handles.ST_spiral_unit_cost.Visible='on';
        handles.EDT_cc_spiral_unit_cost.Visible='on';
        handles.ST_spiral_unit_cost.String=['S420 Unit Cost(TL/tons)'];
        handles.PB_cc_spiral_help.Visible='on';
    end
elseif get(hObject,'Value')==3
    handles.spiral_steel_ck=500;
    handles.spiral_steel_cd=500/1.15;
    if handles.steel_ck==500
        handles.ST_spiral_unit_cost.Visible='off';
        handles.EDT_cc_spiral_unit_cost.Visible='off';
        handles.PB_cc_spiral_help.Visible='off';
        
    else 
        handles.ST_spiral_unit_cost.Visible='on';
        handles.EDT_cc_spiral_unit_cost.Visible='on';
        handles.ST_spiral_unit_cost.String=['S500 Unit Cost(TL/tons)'];
        handles.PB_cc_spiral_help.Visible='on';
    end

else 
end
guidata(hObject, handles);
% Hints: contents = cellstr(get(hObject,'String')) returns POP_cc_spiral_steel_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from POP_cc_spiral_steel_type


% --- Executes during object creation, after setting all properties.
function POP_cc_spiral_steel_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to POP_cc_spiral_steel_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EDT_cc_spiral_unit_cost_Callback(hObject, eventdata, handles)
% hObject    handle to EDT_cc_spiral_unit_cost (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.cc_spiral_unit_cost=str2double(get(hObject,'String'));
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of EDT_cc_spiral_unit_cost as text
%        str2double(get(hObject,'String')) returns contents of EDT_cc_spiral_unit_cost as a double


% --- Executes during object creation, after setting all properties.
function EDT_cc_spiral_unit_cost_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EDT_cc_spiral_unit_cost (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in RB_bored_concrete.
function RB_bored_concrete_Callback(hObject, eventdata, handles)
% hObject    handle to RB_bored_concrete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of RB_bored_concrete


% --- Executes during object creation, after setting all properties.
function uipanel9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes when uipanel9 is resized.
function uipanel9_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to uipanel9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function axes_best_pile_top_view_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_best_pile_top_view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes_best_pile_top_view


% --------------------------------------------------------------------
function PNL_invisible_soil_profile_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to PNL_invisible_soil_profile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes during object creation, after setting all properties.
function axes_best_pile_long_view_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_best_pile_long_view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes_best_pile_long_view


% --- Executes during object creation, after setting all properties.
function TBL_data_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TBL_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on key press with focus on TBL_data and none of its controls.
function TBL_data_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to TBL_data (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in PB_cc_concrete_help.
function PB_cc_concrete_help_Callback(hObject, eventdata, handles)
% hObject    handle to PB_cc_concrete_help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.POP_cc_concrete_type.Value == 1
    web('https://www.birimfiyat.net/15.150.1004-beton-santralinde-uretilen-veya-satin-alinan-ve-beton-pompasiyla-basilan-c-20-25-basinc-dayanim-sinifinda-gri-renkte-normal-hazir-beton-dokulmesi-beton-nakli-dahil');
elseif handles.POP_cc_concrete_type.Value == 2
    web('https://www.birimfiyat.net/15.150.1005-beton-santralinde-uretilen-veya-satin-alinan-ve-beton-pompasiyla-basilan-c-25-30-basinc-dayanim-sinifinda-gri-renkte-normal-hazir-beton-dokulmesi-beton-nakli-dahil');
elseif handles.POP_cc_concrete_type.Value == 3 
    web('https://www.birimfiyat.net/15.150.1006-beton-santralinde-uretilen-veya-satin-alinan-ve-beton-pompasiyla-basilan-c-30-37-basinc-dayanim-sinifinda-gri-renkte-normal-hazir-beton-dokulmesi-beton-nakli-dahil');
else
    web('https://www.birimfiyat.net/15.150.1007-beton-santralinde-uretilen-veya-satin-alinan-ve-beton-pompasiyla-basilan-c-35-45-basinc-dayanim-sinifinda-gri-renkte-normal-hazir-beton-dokulmesi-beton-nakli-dahil');
end
guidata(hObject, handles);

% --- Executes on button press in PB_cc_steel_help.
function PB_cc_steel_help_Callback(hObject, eventdata, handles)
% hObject    handle to PB_cc_steel_help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.POP_cc_steel_type.Value == 1
    web('https://www.birimfiyat.net/10.130.1703-beton-celik-cubugu-duz-14-50-mm.-s220');
elseif handles.POP_cc_steel_type.Value == 2
    web('https://www.birimfiyat.net/10.130.1705-beton-celik-cubugu-nervurlu-14-32-mm.-s420-b420b-c-b500b-c');
else
    web('https://en.alibaba.com/trade/search?fsb=y&IndexArea=product_en&CatId=&SearchText=s500+reinforcement+bar&viewtype=G&tab=');
end
guidata(hObject, handles);

%handles.POP_cc_steel_type.Value
% --- Executes on button press in PB_cc_spiral_help.
function PB_cc_spiral_help_Callback(hObject, eventdata, handles)
% hObject    handle to PB_cc_spiral_help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.POP_cc_spiral_steel_type.Value == 1
    web('https://www.birimfiyat.net/10.130.1702-beton-celik-cubugu-duz-8-12-mm.-s220');
elseif handles.POP_cc_spiral_steel_type.Value == 2
    web('https://www.birimfiyat.net/10.130.1704-beton-celik-cubugu-nervurlu-8-12-mm-s420-b420b-c-b500b-c');
else
    web('https://en.alibaba.com/trade/search?fsb=y&IndexArea=product_en&CatId=&SearchText=s500+reinforcement+bar&viewtype=G&tab=');
end
guidata(hObject, handles);

% --- Executes on button press in PB_sc_steel_help.
function PB_sc_steel_help_Callback(hObject, eventdata, handles)
% hObject    handle to PB_sc_steel_help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.POP_sc_steel_type.Value == 1
    web('https://en.alibaba.com/trade/search?fsb=y&IndexArea=products&CatId=&SearchText=S235JR+pipe&selectedTab=products&viewType=GALLERY');
elseif handles.POP_sc_steel_type.Value == 2
    web('https://en.alibaba.com/trade/search?fsb=y&IndexArea=product_en&CatId=&SearchText=S275JR+pipe&viewtype=&tab=');
else
    web('https://en.alibaba.com/trade/search?fsb=y&IndexArea=product_en&CatId=&SearchText=S355JR+pipe&viewtype=&tab=');
end
guidata(hObject, handles);


% --- Executes on button press in PB_excel_export.
function PB_excel_export_Callback(hObject, eventdata, handles)
% hObject    handle to PB_excel_export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
writetable(struct2table(handles.pile_combo),'Pile_trials.xlsx');
output_message=msgbox('Trials are exported MS Excel as Pile_trials.xlsx!','Completed'); 
