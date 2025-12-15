function a = fullname( x )
if x<10
    a=strcat('0','0','0','0',int2str(x));
elseif x<100 && x>=10
    a=strcat('0','0','0',int2str(x));
elseif x<1000 && x>=100
    a=strcat('0','0',int2str(x));
elseif x<10000 && x>=1000
    a=strcat('0',int2str(x));
else
    a=int2str(x);
end

end

