function [cand,miss,insert,dev,det]= performance(gcip,gci,gg,cand,miss,insert,dev,det)

for i=2:length(gcip)-1
        
    
   
        ld= gcip(i)-gcip(i-1);
        rd= gcip(i+1)-gcip(i);
        
        if ld/rd > 1.9 || rd/ld > 1.9
            
        else
            
            cand=cand+1;
            lpos= gcip(i)-floor(ld/2)-1;
            rpos= gcip(i)+floor(rd/2)+1;
            
            inter= (lpos:rpos);
            
            if sum(gg(inter))== 0.5
                
                det =det+1;
                
                [~, ind]= min(abs(gcip(i)-gci));
                
                devi= gcip(i)-gci(ind);
                dev=[dev devi];
                
                
                
                
            elseif sum(gg(inter))> 0.5
                % det=det+1;
                %              devi= min(abs(gcip(i)-gci));
                %             dev=[dev devi];
                %
                %num_ins= (sum(gg(inter))/0.5)-1;
                
                %insert= insert+num_ins;
                insert=insert+1;
                
                %ins=gcip(i)
            else
                
                miss=miss+1;
                
                %mis=gcip(i)
                
            end
            
        end
        
    end;
    
    %dev=dev-mean(dev);
    %dev=dev-mode(dev);
    
