function main
x0=input('������x0');
y0=input('������y0');
vx0=input('������vx0');
vy0=input('������vy0');
vz0=input('������vz0');
ox0=input('������ox0');
oy0=input('������oy0');
oz0=input('������oz0');
%�ڽ�����Ĭ���ڵ������
if x0<20.16
    if y0<16.5
        x0=0;y0=10.9728;
    end
end
drawback;
result=draw(x0,y0,vx0,vy0,vz0,ox0,oy0,oz0);
end