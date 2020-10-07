function [Population,Infected_Pop,FEL] = Recovery(Population,Current_Simulation_Time,n,Infected_Pop,FEL)
s = size(n,1);
for ii = 1:s
FEL(n(ii,1),2) = Current_Simulation_Time+1;  
Infected_Pop = Infected_Pop - 1;
Population = Population - 1;
end
end