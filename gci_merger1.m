function[ ff_sec,le,re]= gci_merger1(ff,fs,l1,th)
ms= 0.001*fs;
loca=1:l1;
ff_loc1= loca'.* (ff>th);
pp=sort(ff_loc1);
ff_loc= pp(length(pp)-(sum(pp>0))+1:length(pp));
le(1)=ff_loc(1); ind=1;
for i=2:length(ff_loc)-1
    if  ff_loc(i)-ff_loc(i-1) <=2*ms && ff_loc(i+1)-ff_loc(i) > 2*ms
        re(ind)= ff_loc(i);    
    elseif ff_loc(i) - ff_loc(i-1) >= 2*ms && ff_loc(i+1) - ff_loc(i) < 2*ms       
        ind=ind+1;
        le(ind)= ff_loc(i);        
    elseif ff_loc(i) - ff_loc(i-1) >= 2*ms && ff_loc(i+1) - ff_loc(i) > 2*ms
        ind=ind+1;
        le(ind) = ff_loc(i);        
        re(ind)= ff_loc(i);        
    end;    
end;
if length(le) == 1   
    re=le;    
end;
if (length(re) == length(le)-1)    
    re(ind) = ff_loc(length(ff_loc));    
end;
ff_sec= zeros(1, length(ff));
for i= 1: length( re )   
    if re(i) ==0
        [t k]= max(ff(le(i)));       
    else
        [t k]= max(ff(le(i):re(i)));       
    end;
    ff_sec(le(i)+k) = t;   
end;

