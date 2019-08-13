function SSO
 
M=30 ;%Dimension
q=20;%population sizze
MAX_FES=M*1e4;      
onebest=zeros(1,1);%每个函数25个最优解
allbest=zeros(1,MAX_FES);%每个函授25次运行的所有优解
 FES=0;%适应度值数目初始化
 Dmin= -600;
 Dmax =600;                              
individual=struct('fitness',{},'position',{});
rand('seed', sum(100*clock)); 

for i=1:q 
        data=Dmin+(Dmax-Dmin).*rand(1,M);     
        fitness= f4(data);
        individual(i).position=data;
        individual(i).fitness=fitness;
        FES=FES+1;
           
           if i==1
               tempindividual=individual(1);
               
           end
           
           if individual(i).fitness< tempindividual.fitness
               tempindividual=individual(i);
             
           end
              allbest(1,FES)= tempindividual.fitness;
               
              fprintf('SS3D(%d) =%g\n',FES,allbest(1,FES));
end
  
 
while FES<=MAX_FES%混合排序
          if  FES>MAX_FES
                break;
          end
        
        
            fit_total=[];
           for i=1:q
              fit_total=[fit_total
                           individual(i).fitness];         
           end            
           for j=1:q                
                   choice = tournement_selection(fit_total);
                    b=individual(choice).position;        
                    a=individual(j).position;   
                    pp=randperm(M);
                    if M==2
                         pp2=pp;
                         s1=circle2D(a,b,pp2);
                         x = 0.5+0.03 * randn ;
                        a(pp2)=a(pp2) + (x).* (s1) ;    
                    elseif M>=3     
                        pp2=pp(1:3);
                        s1=sphere3D(a,b,pp2);
                        x = 0.5+0.03 * randn ;
                       a(pp2)=a(pp2) + (x).* (s1) ;
                   end
                  temp=a;                  
                  temp(temp>Dmax)=Dmax;
                  temp(temp<Dmin)=Dmin;          
                  fitness= f4(temp);
                  if  fitness <individual(j).fitness
                    individual(j).position  =temp ;
                    individual(j).fitness=fitness;   
                  end
                  FES= FES+1;
          %记录每个FES最佳适应度值
                           
                if  fitness< tempindividual.fitness    
                  tempindividual.position=temp;
                  tempindividual.fitness=fitness;
                end
                           
                if  FES>MAX_FES
                            break;
                end
                
               allbest(1,FES)= tempindividual.fitness;
                              
                if mod(FES,1113)==0
                      fprintf('SS3D(%d) =%g\n',FES,allbest(1,FES));
                end
                 
             end%j 
 
   end%while
   onebest(1)=allbest (1,MAX_FES);
  
 
  

function s=sphere3D(a,b,p)
         R1=sqrt(sum((a(p)-b(p)).^2));
         O=[pi*rand; 2*pi*rand ];
         P1(1)=cos(O(1));
         P1(2)=sin(O(1))*cos(O(2));
         P1(3)=sin(O(1))*sin(O(2));
         s=R1*P1;
   function ccl=circle2D(a,b,p)
         R1=sqrt(sum((a(p)-b(p)).^2));
         O=2*pi*rand ;
         
         P1(1)= cos(O);
         P1(2)= sin(O);
         ccl=R1*P1;        
       

function choice = tournement_selection(source)
 % Turnuva Se鏸mi ile 齥 kayna瘕n齨 se鏸mi
          a_num  = size(source,1);
       
        komsu1=fix(rand*a_num)+1;
        komsu2=fix(rand*a_num)+1;
        
        while(komsu1==komsu2)
                komsu2=fix(rand*a_num)+1;
        end;
        
        if source(komsu1)<source(komsu2) choice=komsu1; else
        choice=komsu2; end;  
    
    
  
function y=f4(x)
% This is Griewank Function
% x is a vector[-600,600],opt=0
d=length(x);
y1=0;
y2=1.0;
for k=1:d
    %y1=y1+(x(k)-100)^2;
      y1=y1+(x(k))^2;
    % y2=y2*cos((x(k)-100)/sqrt(k));
    y2=y2*cos((x(k))/sqrt(k));
end
y=y1/4000-y2+1;
 
    
     
 
            
            
     
            
 
 