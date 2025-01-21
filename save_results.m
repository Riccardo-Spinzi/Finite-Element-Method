function save_results( MODEL ) 

       % % --------------- FUNCTION INFO ---------------- % %

% save_results stocks the MODEL results into files that can be read by
% Python to do post-processing.
%
%                       save_results( MODEL )
%
% -------------------------------------------------------------------------
% Input arguments:
% MODEL            [struct]         MODEL structure                 [multi] 
%
% -------------------------------------------------------------------------
% Output arguments:
%
% -------------------------------------------------------------------------

% -- Get directory of Results
cd("Results/")

% -- Init
i=0;

% -- Get latest data file
while(exist(strcat('data',num2str(i),'.mat'), "file")) 
    i = i + 1;   
end

% -- Save MODEL struct
save(strcat('data',num2str(i),'.mat'), 'MODEL');