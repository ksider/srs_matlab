function varargout = okno(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @okno_OpeningFcn, ...
                   'gui_OutputFcn',  @okno_OutputFcn, ...
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

function okno_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);


function varargout = okno_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function start_Callback(hObject, eventdata, handles)
% Find a GPIB object.
obj1 = instrfind('Type', 'gpib', 'BoardIndex', 0, 'PrimaryAddress', 1, 'Tag', '');

% Create the GPIB object if it does not exist
% otherwise use the object that was found.
if isempty(obj1)
    obj1 = gpib('NI', 0, 1);
else
    fclose(obj1);
    obj1 = obj1(1)
end

% Connect to instrument object, obj1.
fopen(obj1);


c=0; 
b=str2num(get(handles.edit6, 'String'));                  %начальное значение напряжения
b1=b;
max=str2num(get(handles.edit3, 'String'));                %максимальное значение
t=str2num(get(handles.edit1, 'String'));                   %шаг напряжения 
k=str2num(get(handles.edit4, 'String'));                  % пауза в секундах
p=str2num(get(handles.edit5, 'String'));                   %количество пиков

% xmax=p*((max-b)/t);


% hA1 = axes;
% set(hA1, 'Position', [0.05 0.05 0.5 0.7]);
% set(hA1, 'XLim', [0 xmax]);
% set(hA1, 'YLim', [0 max]);
% xtek=0;
% plot(hA1,x,max);






 for c = 1:p                                          % количество пиков
 c=c+1;
while b<max                                           % подьем напряжения до максимального

x=num2str(b);
a='VSET';
c='.0';
e=strcat(a,x,c);
fprintf(obj1,e);
b=b+t;
pause(k);

end;
while b>0                                            % падение напряжения
  
  x=num2str(b);
    a='VSET';
  c='.0';
  e=strcat(a,x,c);
  fprintf(obj1,e);
  b=b-t;
  pause(k);
      
  end;
  b=0;
  x=num2str(b);
  a='VSET';
  c='.0';
  e=strcat(a,x,c);
  fprintf(obj1,e);
 end;




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
