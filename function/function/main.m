function main
x0=input('请输入x0');
y0=input('请输入y0');
vx0=input('请输入vx0');
vy0=input('请输入vy0');
vz0=input('请输入vz0');
ox0=input('请输入ox0');
oy0=input('请输入oy0');
oz0=input('请输入oz0');
%在禁区内默认在点球点上
if x0<20.16
    if y0<16.5
        x0=0;y0=10.9728;
    end
end
drawback;
result=draw(x0,y0,vx0,vy0,vz0,ox0,oy0,oz0);
end