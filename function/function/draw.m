function re = draw(x0, y0, vx0, vy0, vz0, ox0, oy0, oz0 )
%�����м����˳�λ�úͳ����ٶ�
%��ĳ�ʼ�߶ȵ���Ϊ0.105m
%����������
%ײ�ط��������������һ��
%��ǽ�����˽ϴ�ĸĶ�
%���������ļ�����һ�����⣬�Ҹ���һ��
%�����˷���ֵ�������Ҫ�õ�
%��ǽ�ж�

dt = 0.005;%ʱ����
m = 0.4;%����
g = [0, 0, -9.8 ];
v = [vx0, - vy0, vz0];%���ٶ�
r0 = [x0, y0, 0.105];%��λ��
r = [x0, y0, 0.105];
omega = [ox0, oy0, oz0];%�����ٶ�

%��ǽ����
a = sqrt((x0+3.66)^2+y0^2);
b = sqrt((x0-3.66)^2+y0^2);
theta = acos((a*a+b*b-7.32*7.32)/(2*a*b))/2;
wallLen = ceil (9.15*tan(theta)*2);

%ǽ�е��������߼н�
x1 = 3.66-b/(a+b)*7.32;
theta2 = atan((x0-x1)/y0);

%��ǽ
wallx = x0 - 9.15*sin(theta2);
wally = y0 - 9.15*cos(theta2);
wallHeight = 2.0;
wall (wallx, wally, wallLen, theta2);

%����ȡ��x��y��z ����
fuckx =[1;0;0];
fucky =[0;1;0];
fuckz =[0;0;1];

for i=1:1:1000
    %���������Ĺ�ʽ
    a=-resist(norm(v))/m*v/norm(v)+g;
    a2 = 0.00586032*cross(omega,v);%������������
    
    %ûʲô�ã� ֻ���ڻ�ͼ
	Tx= r*fuckx;
	Ty= r*fucky;
	Tz= r*fuckz;
    %ײǽ
    if (abs(-tan(theta2)*Tx-Ty+wally+tan(theta2)*wallx)/(tan(theta2)^2+1)<0.1&&Tx>wallx-wallLen/2*cos(theta2)&&Tx<wallx+wallLen/2*cos(theta2))
        if ( Tz < wallHeight)
            break;
        end
    end
    %ײ����
    if ( Ty < 0)
        break;
    end
    %ײ��
    if ( Tz < 0.105)
        v(3) = -v(3);
        v(1) = 0.97*v(1);
        v(2) = 0.97*v(2);
    end
    %����
	v = v+ a*dt +a2*dt;
	r = r+ v*dt;
    %ûʲô�ã� ֻ���ڻ�ͼ
    TTx= r*fuckx;
    TTy= r*fucky;
    TTz= r*fuckz;
    %����һϵ������ͼ
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


