
x = linspace(1, 10, 100); 
y =sin(x)+rand(size(x), 1); 
plot(x,y, 'b*');
analyzer_angles=linspace(min(x),max(x),100);
data = [x;y]; 
%Ein=[1;0]';
IG =[1, 1, 1, 1,1, 1, 1,1]; 
index_collector =zeros(size(analyzer_angles));
for ind = 1: length(analyzer_angles)
    
    P =fittingfunction(data, IG);
    Ein = P(1); 
    wp_angle_sample1 = P(2); 
    retardance_sample1 = P(3); 
    pol_angle_sample1 = P(4);
    px_sample = P(5); 
    py_sample = P(6);  
    px_analyzer = P(7); 
    py_analyzer = P(8); 

    yfitf = Ecase1(Ein, wp_angle_sample1, retardance_sample1,...
                pol_angle_sample1,px_sample, py_sample,...
                analyzer_angles(ind), px_analyzer, py_analyzer);
            
    index_collector(ind) = sum(abs(yfitf(1)).^2);         
end
 
 plot(x,y)
 hold on 
 plot(x, index_collector)


