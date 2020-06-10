function varargout = Color_Detection(varargin)
% COLOR_DETECTION MATLAB code for Color_Detection.fig
%      COLOR_DETECTION, by itself, creates a new COLOR_DETECTION or raises the existing
%      singleton*.
%
%      H = COLOR_DETECTION returns the handle to a new COLOR_DETECTION or the handle to
%      the existing singleton*.
%
%      COLOR_DETECTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COLOR_DETECTION.M with the given input arguments.
%
%      COLOR_DETECTION('Property','Value',...) creates a new COLOR_DETECTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Color_Detection_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Color_Detection_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Color_Detection

% Last Modified by GUIDE v2.5 09-Jun-2020 22:10:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Color_Detection_OpeningFcn, ...
                   'gui_OutputFcn',  @Color_Detection_OutputFcn, ...
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


% --- Executes just before Color_Detection is made visible.
function Color_Detection_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Color_Detection (see VARARGIN)

% Choose default command line output for Color_Detection
handles.output = hObject;
ss = ones(300,400);
axes(handles.axes1);
imshow(ss);
axes(handles.axes5);
imshow(ss);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Color_Detection wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Color_Detection_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
%varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im;
global fname;
%% Test Cloth Image
[fname, path]=uigetfile('.jpg','provide a Cloth Image for testing');
fname=strcat(path, fname);
im1=imread(fname);
axes(handles.axes1);
im=im2bw(im1);
imshow(im1);
title('Input Cloth Image');

function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global im;
%% Find the class the test cloth image belongs
Ftest=feature_statistical(im);
%% Compare with the feature of training image in the database
load db.mat
Ftrain=db(:,1:2);
Ctrain=db(:,3);
for (i=1:size(Ftrain,1));
    dist(i,:)=sum(abs(Ftrain(i,:)-Ftest));
end
Min=min(dist);
if(Min<2)
m=find(dist==Min,1);
det_class=Ctrain(m);
switch(det_class)
    case 1
        set(handles.edit6, 'string', 'THIS IS BLUE COLOR MATERIAL');
    case 2
        set(handles.edit6, 'string', 'THIS IS PURPLE COLOR MATERIAL');
    case 3
        set(handles.edit6, 'string', 'THIS IS BLACK COLOR MATERIAL');
    case 4
        set(handles.edit6, 'string', 'THIS IS BROWN COLOR MATERIAL');
    case 5
        set(handles.edit6, 'string', 'THIS IS GREEN COLOR MATERIAL');
    case 6
        set(handles.edit6, 'string', 'THIS IS ORANGE COLOR MATERIAL');
    case 7
        set(handles.edit6, 'string', 'THIS IS PINK COLOR MATERIAL');
    case 8
        set(handles.edit6, 'string', 'THIS IS RED COLOR MATERIAL');
    case 9
        set(handles.edit6, 'string', 'THIS IS YELLOW COLOR MATERIAL');
    case 12
        set(handles.edit6, 'string', 'THIS IS BARLEYCORN DESIGN MATERIAL');
    case 13
        set(handles.edit6, 'string', 'THIS IS DOT DESIGN MATERIAL');
    case 14
        set(handles.edit6, 'string', 'THIS IS FLORAL DESIGN MATERIAL');
    case 15
        set(handles.edit6, 'string', 'THIS IS HERRINGBONE DESIGN MATERIAL');
    case 16
        set(handles.edit6, 'string', 'THIS IS PAISLEY DESIGN MATERIAL');
    case 17
        set(handles.edit6, 'string', 'THIS IS PLAID DESIGN MATERIAL');
    case 18
        set(handles.edit6, 'string', 'THIS IS STRIPE DESIGN MATERIAL');
end        
else
    set(handles.edit6, 'string', 'THIS IS NOT IN THE DATA SET');
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fname;
im2=imread(fname);
axes(handles.axes5);
red_plane=im2(:,:,1);
green_plane=im2(:,:,2);
blue_plane=im2(:,:,3);
[red_data pixel_level]=imhist(red_plane);
[green_data pixel_level]=imhist(green_plane);
[blue_data pixel_level]=imhist(blue_plane);
bar(pixel_level, red_data,'r');
hold on;
bar(pixel_level, green_data,'g');
bar(pixel_level, blue_data,'b');



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
