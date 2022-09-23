function wall(wx,wy,width,theta)
[X, Z] = meshgrid(wx-width/2*cos(theta):cos(theta):wx+cos(theta)*width/2, 0:1:2.0);
Y = ones(size(X))*wy;
for i=1:width+1
    for j=1:3
        Y(3*i+j-3)=wy-width/2*sin(theta)*(-width/2+i-1);
    end
end
surfl(X,Y,Z);
end

