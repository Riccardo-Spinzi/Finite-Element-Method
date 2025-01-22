function save_results( MODEL, python_dir, matlab_dir ) 

       % % --------------- FUNCTION INFO ---------------- % %

% save_results stocks the MODEL results into files that can be read by
% Python to do post-processing.
%
%             save_results( MODEL, python_dir, matlab_dir )
%
% -------------------------------------------------------------------------
% Input arguments:
% MODEL            [struct]         MODEL structure                 [multi] 
% python_dir       [char]           python results file directory   
% -------------------------------------------------------------------------
% Output arguments:
%
% -------------------------------------------------------------------------

% -- Init
i=0;

file_name = strcat('data',num2str(i),'.mat');

% -- Get Matlab path
fullFilePath_matlab = fullfile(matlab_dir, file_name);

% -- Get latest data file
while(exist(fullFilePath_matlab, "file")) 
    i = i + 1;   
    file_name = strcat('data',num2str(i),'.mat');
    fullFilePath_matlab = fullfile(matlab_dir, file_name);
end

% -- Get Python path
fullFilePath_python = fullfile(python_dir, file_name);

% -- Save MODEL struct in Results
save(fullFilePath_matlab, 'MODEL');

% -- Save MODEL struct in Python directory
save(fullFilePath_python, 'MODEL');

fprintf("Save of %s completed\n", file_name)