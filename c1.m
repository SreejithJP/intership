folder = dir("*.h5");

lat_grid = linspace(0, 40, 81);  % Generates 81 elements from 0 to 40
lon_grid = linspace(50, 100, 101);  % Generates 101 elements from 50 to 100


grid_ctp1(1:length(lon_grid),1:length(lat_grid))=NaN; 

for n = 1:length(folder)
    file_name1 = folder(n).name;
    latitude = h5read(file_name1, '/Latitude');
    longitude = h5read(file_name1, '/Longitude');
    CTP = h5read(file_name1, '/CTP');
    
    for j = 1:length(lon_grid)-1
        for k = 1:length(lat_grid)-1
            kerala_lon_indices = find(longitude >= lon_grid(j) & longitude <= lon_grid(j+1));
            kerala_lat_indices = find(latitude >= lat_grid(k) & latitude <= lat_grid(k+1));
            res = [kerala_lon_indices; kerala_lat_indices];
            
            % Compute the mean excluding NaN values
            non_nan_values = CTP(res);
            non_nan_values(isnan(non_nan_values)) = [];
            grid_ctp1(j, k) = mean(non_nan_values);
        end
    end
end


% Plotting using pcolor
figure;
pcolor(lon_grid, lat_grid, grid_ctp1); % No need to transpose grid_imc1
shading interp;
xlabel('Longitude');
ylabel('Latitude');
title('CTP Data');