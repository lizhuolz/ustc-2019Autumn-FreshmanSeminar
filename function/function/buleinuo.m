function out = buleinuo()
t=0;c=0;
for i=16.5:0.1:20
    p=angle(0,i,0,0,0);
    if t<p
        t=p;
        c=i;
    end
end
out=c;
end