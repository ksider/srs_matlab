% Find a GPIB object.
obj1 = instrfind('Type', 'gpib', 'BoardIndex', 0, 'PrimaryAddress', 0, 'Tag', '');

% Create the GPIB object if it does not exist
% otherwise use the object that was found.
if isempty(obj1)
    obj1 = gpib('NI', 0, 1);
else
    fclose(obj1);
    obj1 = obj1(1);
end

% Connect to instrument object, obj1.
fopen(obj1);


% Communicating with instrument object, obj1.

b=0;                    %начальное значение напряжения
max=101;                %максимальное значение
t=5;                    %шаг напряжения 
k=0.5;                  % пауза в секундах

while b<max

x=num2str(b);
a='VSET';
c='.0';
e=strcat(a,x,c);
fprintf(obj1,e);
b=b+t;
pause(k);

end;