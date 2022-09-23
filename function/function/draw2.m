function re = draw2(x0, y0, vx0, vy0, vz0, ox0, oy0, oz0 )
dt = 0.005;
m = 0.4;
g = [0, 0, -9.8 ];
v = [vx0, - vy0, vz0];
r = [x0, y0, 0.105];
omega = [ox0, oy0, oz0];

%人墙人数
a = sqrt((x0+3.66)^2+y0^2);
b = sqrt((x0-3.66)^2+y0^2);
theta = acos((a*a+b*b-7.32*7.32)/(2*a*b))/2;
wallLen = ceil (9.15*tan(theta)*2);

x1 = 3.66-b/(a+b)*7.32;
theta2 = atan((x0-x1)/y0);

wallx = x0 - 9.15*sin(theta2);
wally = y0 - 9.15*cos(theta2);
wallHeight = 2.0;

%墙中点与人连线夹角
x1 = 3.66-b/(a+b)*7.32;
theta2 = atan((x0-x1)/y0);

%用于取出x，y，z 分量
fuckx =[1;0;0];
fucky =[0;1;0];
fuckz =[0;0;1];

i=1;
while i<600
    %空气阻力的公式
    a=-resist(norm(v))/m*v/norm(v)+g;
    a2 = 0.00586032*cross(omega,v);%升力加在这里
    
    %没什么用， 只用于画图
	Tx= r*fuckx;
	Ty= r*fucky;
	Tz= r*fuckz;
    %撞墙
    if (abs(-tan(theta2)*Tx-Ty+wally+tan(theta2)*wallx)/(tan(theta2)^2+1)<0.1&&Tx>wallx-wallLen/2*cos(theta2)&&Tx<wallx+wallLen/2*cos(theta2))
        if ( Tz < wallHeight)
            break;
        end
    end
    %撞球门
    if ( Ty < 0)
        break;
    end
    %撞地
    if ( Tz < 0.105)
        v(3) = -v(3);
        v(1) = 0.97*v(1);
        v(2) = 0.97*v(2);
    end
    %积分
	v = v+ a*dt +a2*dt;
	r = r+ v*dt;
   
    i=i+1;
end
re(1)=Tx;
re(2)=Ty;
re(3)=Tz;
re(4)=i*dt;
end