function save_results( MODEL, python_dir ) 

       % % --------------- FUNCTION INFO ---------------- % %

% save_results stocks the MODEL results into files that can be read by
% Python to do post-processing.
%
%                  save_results( MODEL, python_dir )
%
% -------------------------------------------------------------------------
% Input arguments:
% MODEL            [struct]         MODEL structure                 [multi] 
% python_dir       [char]           python results file directory   
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

% -- Save MODEL struct in Results
save(strcat('data',num2str(i),'.mat'), 'MODEL');

% -- Get Python directory
cd(python_dir)

% -- Save MODEL struct in Python directory
save(strcat('data',num2str(i),'.mat'), 'MODEL');