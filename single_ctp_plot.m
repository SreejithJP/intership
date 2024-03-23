% Directory containing the HDF5 files
directory = 'D:\project\insat 3dr\New folder\';

% Get all .h5 files in the directory
files = dir(fullfile(directory, '*.h5'));

% Initialize variables to store aggregated data
all_latitude = [];
all_longitude = [];
all_mean_CTP = [];

% Loop through each file
for i = 1:numel(files)
    % Get the file path
    file_path = fullfile(directory, files(i).name);
    
    % Read latitude, longitude, and CTP data from the HDF5 file
    latitude = h5read(file_path, '/Latitude');
    longitude = h5read(file_path, '/Longitude');
    CTP = h5read(file_path, '/CTP');
    
    % Replace fill values with NaN
    CTP(CTP == -999.000000) = NaN;
    
    % Calculate the mean CTP for this dataset
    mean_CTP = mean(CTP, 'omitnan');
    
    % Store the mean CTP and corresponding latitude and longitude
    all_mean_CTP = [all_mean_CTP; mean_CTP];
    all_latitude = [all_latitude; mean(latitude(:))];
    all_longitude = [all_longitude; mean(longitude(:))];
end

% Plot the mean CTP data
figure;
scatter3(all_longitude, all_latitude, all_mean_CTP);
xlabel('Longitude');
ylabel('Latitude');
zlabel('Mean CTP');
title('Mean CTP Data from All Files');
