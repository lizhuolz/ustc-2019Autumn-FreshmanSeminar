function re = draw(x0, y0, vx0, vy0, vz0, ox0, oy0, oz0 )
%参数中加入了初位置和初角速度
%球的初始高度调整为0.105m
%加入了升力
%撞地反弹的情况调整了一下
%人墙做出了较大的改动
%空气阻力的计算有一点问题，我改了一下
%增加了返回值后面可能要用到
%人墙判定

dt = 0.005;%时间间隔
m = 0.4;%质量
g = [0, 0, -9.8 ];
v = [vx0, - vy0, vz0];%初速度
r0 = [x0, y0, 0.105];%初位置
r = [x0, y0, 0.105];
omega = [ox0, oy0, oz0];%初角速度

%人墙人数
a = sqrt((x0+3.66)^2+y0^2);
b = sqrt((x0-3.66)^2+y0^2);
theta = acos((a*a+b*b-7.32*7.32)/(2*a*b))/2;
wallLen = ceil (9.15*tan(theta)*2);

%墙中点与人连线夹角
x1 = 3.66-b/(a+b)*7.32;
theta2 = atan((x0-x1)/y0);

%画墙
wallx = x0 - 9.15*sin(theta2);
wally = y0 - 9.15*cos(theta2);
wallHeight = 2.0;
wall (wallx, wally, wallLen, theta2);

%用于取出x，y，z 分量
fuckx =[1;0;0];
fucky =[0;1;0];
fuckz =[0;0;1];

for i=1:1:1000
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
    %没什么用， 只用于画图
    TTx= r*fuckx;
    TTy= r*fucky;
    TTz= r*fuckz;
    %画出一系列折线图
    rx=[Tx,TTx ];
    ry=[Ty,TTy ];
    rz=[Tz,TTz ];
    plot3(rx, ry, rz, 'Color', [1,0,0]);
    
end
re(1)=Tx;
re(2)=Ty;
re(3)=Tz;
re(4)=i*dt;
end


