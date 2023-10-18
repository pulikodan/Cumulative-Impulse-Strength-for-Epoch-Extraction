function evaluation_clean_Feb18_type_1(db,ALGO)

global ms ff_op fs pre ms2 ms20 ms15 ms1  

fil=[-.5 1 -.5]; pre= [ 1 -1]; oth= 0; nas= 0; fri= 0;  ons=0; onsd=0; plc=0; plcu=0; aff=0; R1= []; det=0; miss=0; insert=0; dev=[]; cand=0; lap=[] ; lac=[];
det1=0; miss1=0; insert1=0; dev1=[]; cand1=0;
det2=0; miss2=0; insert2=0; dev2=[]; cand2=0;
fileDIR = 'C:\Users\sujith\Desktop\pen_24_6\cmu_experiment\cmu_us_jmk_arctic\orig\';
disp('jmk');
%fileDIR = 'C:\Users\sujith\Desktop\pen_24_6\cmu_experiment\cmu_us_bdl_2_20\';
allfiles=dir([fileDIR '*.wav']);
gci=[];
if 0
if (db<6)
    avg=156
else
    avg=125
end
end
for i=1:length(allfiles)
    try
        filename=allfiles(i).name;
       [a1 fs]=wavread(filename);
       y=a1(:,1);
       sig_egg=a1(:,2);
        y=resample(y,16000,fs);  
        y=y./max(y);
        sig_egg=resample(sig_egg,16000,fs); 
        f_sig_egg=sig_egg;
        f_sig_egg=f_sig_egg./max(f_sig_egg);
        [y_diff]= get_y_childer(12,f_sig_egg);
        [ gcip ~]=nonzero(y_diff(1:length(y)-50*ms));          
        if db<35
            y=add_noise(y,16000,db,1);
        end
if 0
        size(y)
        size(y_diff)

        wavwrite([y; y_diff']',16000,32,filename)
        continue
        

     y=a1(:,1)';
     y_diff=a1(:,2);
end
     len_ms=numel(y)/16000;
        switch ALGO
            case 'DPI'
                 %%%%% DPI %%%%%
                %disp(['Running DPI (' num2str(file_index) ') ' wavfile]);
                %tic;
                [gci]=dpi_gci_full(y,16000);
                %  a7(gci)=.76;
                % stem(a7,'k');
                %hold on
                %a7=[];
                %toc;
                %t_DPI=t_DPI+toc/len_ms;
                 %%%%%%%%%%%%%%%
            case 'DYP'
                %%%%% DYP %%%%%
                %disp(['Running DYP (' num2str(file_index) ') ' wavfile]);
                
                [gci]=dypsa(y,16000);
              

            case 'SED'
                %%%%% SED %%%%%
                %disp(['Running SED (' num2str(file_index) ') ' wavfile]);
               % avg2=find_avg_pitch_period(y_diff);
                %apd=avg_pitch_cepstral(y,y_diff,16000);
                [f0_time,f0_value,SHR,f0_candidates]=shrp(y,16000,[50 500]);
                
                avg=(1000/ mode(f0_value))*16;
                 %avg=find_avg_pitch_period(y_diff)
                %avg=156;
                apd=16000/avg;
               % tic;
                [gci]=SEDREAMS_GCIDetection(y,16000,apd);
                %toc;
                %t_SED=t_SED+toc/len_ms;
                %%%%%%%%%%%%%%%
            case 'ZFR'
                %%%%% ZFR %%%%%
                %disp(['Running ZFR (' num2str(file_index) ') ' wavfile]);
                [f0_time,f0_value,SHR,f0_candidates]=shrp(y,16000,[50 500]);
                
                pp=(1000/ mode(f0_value))*16;
                 %avg=find_avg_pitch_period(y_diff)
                % pp=avg;
                % pp=156;
                wl=floor(pp/(16));
                %tic;
                [zf, gci]=zfsig(y,16000,wl);gci=gci';
                %t_ZFR=t_ZFR+toc/len_ms;
                %%%%%%%%%%%%%%%
            case 'DYN'
%                disp(['Running DYN (' num2str(i) ') ' wavfile]);
                %[avg]=avg_pitch_cepstral(y,y_diff,16000);
                 %tic;
                % avg_pitch_cepstral_11_1(y,y_diff,16000)
                 if 0
                     gci1=[];
                     % [gci1]=dpi_gci_full(y,16000);
                     [gci1]=avg_pitch_cepstral_11_1(y,y_diff,16000);
                      gci=[gci gci1];
                %a1=diff(gci);
               %avg=mode(a1)
              % gci=[];
                 end
                 if 1
               [f0_time,f0_value,SHR,f0_candidates]=shrp(y,16000,[50 500]);
           % [f0,VUVDecisions,SRHVal]=SRH_PitchTracking(y,16000,50,500);
               avg=(1000/ mode(f0_value))*16;
               % avg=100;
                %avg1=(1000/ mode(f0))*16
                 end
                %gci=[gci f0_value'];
              %  avg=find_avg_pitch_period(y_diff);
               %  avg=156;
                [gci ab]=new_dp_gci(y,16000,y_diff,.3,avg);
                %[gci ab]=new_dp_gci_sharp(y,16000,y_diff,.2,avg);
                %toc;
                %t_DYN=t_DYN+toc/len_ms;
%                 a(gci)=1;
%                  hold on;
%                 stem(a);
%                 b(gcip)=.5;
%                 stem(b,'r');
%                 b=[];
%                 b1=[];
%                 b1=lpr_smooth_fast(y',16000);
%                 b=imag(hilbert(b1));
%                 plot(-b);
%                 hold off
                %a=[];b=[];
            otherwise
                error('wrong ALGO type');
        end
        if 1
        gg= zeros(1,length(y));
        gg(gci)= 0.5;
        [cand,miss,insert,dev,det]= performance(gcip,gci,gg,cand,miss,insert,dev,det);
        end
        clear y y_diff   
    end   
end
if 1             
dev=dev-mean(dev);
det=det(1);
mr= miss/cand;
idr=det/cand;
far= insert/cand;
dev=dev-mode(dev);
ida= std(dev);
tt=abs(dev)<= 4;
accu25=sum(tt)/det;
res=[ idr mr far ida accu25]
cand
end
%save(['result1_slt_we/' ALGO '_' num2str(db) '.mat'],'res');

