function [k,Healthy_Pop,Infected_Pop,FEL,New_Infections] = Infection(Population,Max_Spread,Infected,k,Infected_Pop,Healthy_Pop,FEL,Current_Simulation_Time,n)
New_Infections = 0;
for i=1:Infected_Pop 
    if FEL(Infected(i,1),3) == 0   
        continue;
    end
    if Healthy_Pop <= 0          
        break;              
    end
    Spread = randi(3);
    if  Spread > FEL(Infected(i,1),3) || Spread > Healthy_Pop
        Spread = min(FEL(Infected(i,1),3),Healthy_Pop);
    end
    New_Infections = New_Infections + Spread;
    FEL(Infected(i,1),3) = FEL(Infected(i,1),3) - Spread;
    Healthy_Pop = Healthy_Pop - Spread;
end
j = New_Infections;
Probability = Infected_Pop/Population; 
for i=1:j
    if rand() < Probability
        New_Infections = New_Infections - 1;
        Healthy_Pop = Healthy_Pop + 1;
    end
end
Infected_Pop = Infected_Pop + New_Infections;
FEL = [FEL;zeros(New_Infections,3)];            
for i = 1:New_Infections
    r = rand();
if r < 0.8
    FEL(k,:) = [2,Current_Simulation_Time+round(7*rand+7),Max_Spread];    
elseif r < 0.85
    FEL(k,:) = [3,Current_Simulation_Time+round(3*rand+7),Max_Spread];
else
    FEL(k,:) = [4,Current_Simulation_Time+round(3*rand+7),Max_Spread];
end
k = k + 1;
end
FEL(n,:) = [1,Current_Simulation_Time + 1,0]; 
if Healthy_Pop == 0
FEL(n,:) = [];
k = k - 1;
end
end