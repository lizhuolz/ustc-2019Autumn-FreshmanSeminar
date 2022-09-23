function the=angle(x0,y0,ox,oy,oz)
s=0;
v=26.3889;
a = sqrt((x0+3.66)^2+y0^2);
b = sqrt((x0-3.66)^2+y0^2);
position = 7.32/(a+b)*a-3.66;
for i = pi/20:pi/1200:pi/4
    vz=v*sin(i);
    for j = pi/4:pi/600:pi-pi/4
        vx=v*cos(i)*cos(j);
        vy=v*cos(i)*sin(j);
        re=draw2(x0,y0,vx,vy,vz,ox,oy,oz);
        ds=pi/1200*pi/600*cos(i)*pmap(abs(re(1)-position),re(2),re(3),re(4));
        s=s+ds;
    end
end
the = s;