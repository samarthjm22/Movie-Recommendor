function varargout = maingui(varargin)
% MAINGUI MATLAB code for maingui.fig
%      MAINGUI, by itself, creates a new MAINGUI or raises the existing
%      singleton*.
%
%      H = MAINGUI returns the handle to a new MAINGUI or the handle to
%      the existing singleton*.
%
%      MAINGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINGUI.M with the given input arguments.
%
%      MAINGUI('Property','Value',...) creates a new MAINGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before maingui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to maingui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help maingui

% Last Modified by GUIDE v2.5 16-Apr-2017 23:50:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @maingui_OpeningFcn, ...
                   'gui_OutputFcn',  @maingui_OutputFcn, ...
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

% --- Executes just before maingui is made visible.
function maingui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to maingui (see VARARGIN)

% Choose default command line output for maingui
load('ex8_movies.mat');
handles.my_ratings = zeros(size(Y,1), 1);

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes maingui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = maingui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in recommend.
function recommend_Callback(hObject, eventdata, handles)
% hObject    handle to recommend (see GCBO)   
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if (size(find(handles.my_ratings ~= 0)) ~= 0)
    %  Y is a 1682x943 matrix, containing ratings (1-5) of 1682 movies by 
%  943 users
%
%  R is a 1682x943 matrix, where R(i,j) = 1 if and only if user j gave a
%  rating to movie i
    load('ex8_movies.mat');
%  Add our own ratings to the data matrix
    Y = [handles.my_ratings Y];
    R = [(handles.my_ratings ~= 0) R];

    %  Normalize Ratings
    [Ynorm, Ymean] = normalizeRatings(Y, R);
    
    %  Useful Values
    num_users = size(Y, 2);
    num_movies = size(Y, 1);
    num_features = 10;
    
    % Set Initial Parameters (Theta, X)
    X = randn(num_movies, num_features);
    Theta = randn(num_users, num_features);
    
    initial_parameters = [X(:); Theta(:)];
    
    % Set options for fmincg
    %options = optimset('GradObj', 'on', 'MaxIter', 100);
    
    % Set Regularization
    lambda = 10;
    %theta = fmincg (@(t)(cofiCostFunc(t, Ynorm, R, num_users, num_movies, ...
    %    num_features, lambda)), ...
    %    initial_parameters, options);
    
    % Unfold the returned theta back into U and W
   % X = reshape(theta(1:num_movies*num_features), num_movies, num_features);
   % Theta = reshape(theta(num_movies*num_features+1:end), ...
    %    num_users, num_features);
    
   
    
    %% ================== Part 8: Recommendation for you ====================
    %  After training the model, you can now make recommendations by computing
    %  the predictions matrix.
    %
    
    p = X * Theta';
    my_predictions = p(:,1) + Ymean;
    
    movieList = loadMovieList();
    
    [r, ix] = sort(my_predictions, 'descend');
    text = 'dsdfdfd'
   % for i=1:10
   %     j = ix(i);
   %      text = strcat(text,strcat(strcat('\n Movie :',movieList(j)),strcat(' Rating :',my_predictions(j))));
   % end
   % set(handles.outputbox,'String') = text;    
    end 
   
   


% --- Executes on selection change in movielist.
function movielist_Callback(hObject, eventdata, handles)
% hObject    handle to movielist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns movielist contents as cell array
%        contents{get(hObject,'Value')} returns selected item from movielist




% --- Executes during object creation, after setting all properties.
function movielist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to movielist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function outputbox_Callback(hObject, eventdata, handles)
% hObject    handle to outputbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of outputbox as text
%        str2double(get(hObject,'String')) returns contents of outputbox as a double


% --- Executes during object creation, after setting all properties.
function outputbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to outputbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in rating.
function rating_Callback(hObject, eventdata, handles)
% hObject    handle to rating (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns rating contents as cell array
%        contents{get(hObject,'Value')} returns selected item from rating


% --- Executes during object creation, after setting all properties.
function rating_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rating (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in rate.
function rate_Callback(hObject, eventdata, handles)
% hObject    handle to rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

movie = get(handles.movielist,'Value')
rated_val = get(handles.rating,'Value')
handles.my_ratings(movie) = rated_val;
guidata(hObject, handles);

