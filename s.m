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
b=40;                 %��������� �������� ����������
b1=b;
max=1000;             %������������ ��������
t=10;                 %��� ���������� 
k=1;                  %����� � ��������
p=4;                  %���������� �����

% xmax=p*((max-b)/t);


% hA1 = axes;
% set(hA1, 'Position', [0.05 0.05 0.5 0.7]);
% set(hA1, 'XLim', [0 xmax]);
% set(hA1, 'YLim', [0 max]);
% xtek=0;
% plot(hA1,x,max);

for c = 1:p                                          % ���������� �����
 c=c+1;
while b<max                                           % ������ ���������� �� �������������
	x=num2str(b);
	a='VSET';
	c='.0';
	e=strcat(a,x,c);
	fprintf(obj1,e);
	b=b+t;
	pause(k);
end;
while b>0                                            % ������� ����������
  
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
