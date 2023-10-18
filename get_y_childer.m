function [y_diff]= get_y_childer(sh,y2)
global ms ff_op fs pre ms2 ms20 ms15 ms1  
y_eg1=y2;
y_diff=-y_eg1(2:length(y_eg1))+ y_eg1(1:length(y_eg1)-1);
y_diff(length(y2))=0;
y_diff= (y_diff./ norm(y_diff));
y_pos= y_diff >= 1/10*max(y_diff);
y_diff= y_diff.*y_pos;
[y_diff,le,re]= gci_merger1(y_diff,fs,length(y_diff),1/10*max(y_diff));
y_diff(sh:length(y_eg1))= y_diff(1:length(y_eg1)-(sh-1));
ms= floor(0.001*fs);  ms1=ms; ms2= 2*ms; ms20= 20*ms; ms15=15*ms;

