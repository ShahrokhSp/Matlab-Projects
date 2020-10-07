clc
clear
rng(99) %For having a certain pseudo Randomness


% Initializating The Values
Current_Simulation_Time = 1;                
Healthy_Pop = 400000; 
Population = 400004;  
Max_Spread = 8;  
Infected_Pop = 4;  
N_Recovery = 0; 
N_Death = 0;           
N_Public_Beds = 0;             
N_ICU_Beds = 0;             
N_Stadium = 0;            
N_Mosalla = 0;            
Public_Beds_Status = zeros(1,350); 
ICU_Beds_Status = zeros(1,50);  
FEL = zeros(5,3);       
FEL(1,2) = 1;FEL(1,1) = 1;
for k = 2:5
    r = rand();
    if r < 0.8
        FEL(k,:) = [2,round(7*rand+7),Max_Spread];    
    elseif r < 0.85
        FEL(k,:) = [3,round(3*rand+7),Max_Spread];
    else
        FEL(k,:) = [4,round(3*rand+7),Max_Spread];
    end
end
Simulation_Duration_Time = 45;                 
k = k + 1;


%Someplace to Store the Datas for Graphs
Infected_Graph = zeros(Simulation_Duration_Time,1);   
Public_Beds_Graph = zeros(Simulation_Duration_Time,1);
ICU_Beds_Graph = zeros(Simulation_Duration_Time,1);
Stadium_Graph = zeros(Simulation_Duration_Time,1);
Mosalla_Graph = zeros(Simulation_Duration_Time,1);
Recovery_Graph = zeros(Simulation_Duration_Time,1);
Death_Graph = zeros(Simulation_Duration_Time,1);


% Controller 
while Current_Simulation_Time <= Simulation_Duration_Time
    T = find(FEL(:,2) >= Current_Simulation_Time);     
    minT = min(FEL(T,2));          
    n = find(FEL(:,2)==minT);
    Event = min(FEL(n,1));
    n = n(1,1);
    Current_Simulation_Time = FEL(n(1,1),2);                                          
    if Current_Simulation_Time > Simulation_Duration_Time
        break;
    end
    if Event == 1
            n = find(FEL(:,1) == Event);
            Infected = find(FEL(:,1) >= 2 & FEL(:,1) <= 4);
            [k,Healthy_Pop,Infected_Pop,FEL,New_Infections] = Infection(Population,Max_Spread,Infected,k,Infected_Pop,Healthy_Pop,FEL,Current_Simulation_Time,n);
            Infected_Graph(Current_Simulation_Time,1) = New_Infections; 
    elseif Event == 2   
            n = find(FEL(:,1)==Event & FEL(:,2)==minT);
            [Population,Infected_Pop,FEL] = Recovery(Population,Simulation_Duration_Time,n,Infected_Pop,FEL);
            Recovery_Graph(Current_Simulation_Time,1) = size(n,1);
            N_Recovery = N_Recovery + size(n,1);
    elseif Event == 3 || Event == 4
            [Population,Infected_Pop,FEL,ICU_Beds_Status,Public_Beds_Status,N_Mosalla,N_Stadium,N_ICU_Beds,N_Public_Beds] = Hospital(Population,Infected_Pop,FEL,ICU_Beds_Status,Public_Beds_Status,N_Mosalla,N_Stadium,N_ICU_Beds,N_Public_Beds,Current_Simulation_Time,Event);
    else
            [Infected_Pop,FEL,ICU_Beds_Status,Public_Beds_Status,N_Mosalla,N_Stadium,N_ICU_Beds,N_Public_Beds,N_Recovery,N_Death] = Outof_Hospital(Infected_Pop,FEL,ICU_Beds_Status,Public_Beds_Status,N_Mosalla,N_Stadium,N_ICU_Beds,N_Public_Beds,N_Recovery,N_Death,Simulation_Duration_Time,Current_Simulation_Time,Event); 
    end
    ICU_Beds_Graph(Current_Simulation_Time,1) = N_ICU_Beds;
    Public_Beds_Graph(Current_Simulation_Time,1) = N_Public_Beds;
    Stadium_Graph(Current_Simulation_Time,1) = N_Stadium;
    Mosalla_Graph(Current_Simulation_Time,1) = N_Mosalla;
    Death_UntillNow = 0;
    for i=1:Current_Simulation_Time
        Death_UntillNow = Death_UntillNow + Death_Graph(i,1); 
    end
    Death_Graph(Current_Simulation_Time,1) = N_Death - Death_UntillNow;
    t = find(FEL(:,2)== Simulation_Duration_Time+1);       
    FEL(t,:) = [];
    k = k - size(t,1);
end


% Report
Days = zeros(1,Simulation_Duration_Time);
Days(1,:) = 1:Simulation_Duration_Time;
bar(Days,Infected_Graph);
title('Daily Infected');
figure ;
bar(Days,Recovery_Graph);
title('Daily Recovered');
figure ;
bar(Days,Death_Graph);
title('Daily Death');
figure ;
bar(Days,Public_Beds_Graph);
title('Daily Patient at Public Beds');
figure ;
bar(Days,ICU_Beds_Graph);
title('Daily Paient at ICU Beds');
figure ;
bar(Days,Stadium_Graph);
title('Daily Patient at Stadium');
figure ;
bar(Days,Mosalla_Graph);
title('Daily Patient at Mosalla');