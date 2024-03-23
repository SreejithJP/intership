file_name = "D:\project\insat 3dr\New folder\3RIMG_06MAR2024_0015_L2B_CTP_V01R00.h5";
lat_grid = 0:0.5:40;
lon_grid = 50:0.5:100;

grid_ctp = NaN(length(lat_grid), length(lon_grid));

latitude = h5read(file_name, '/Latitude');
longitude = h5read(file_name, '/Longitude');
CTP = h5read(file_name, '/CTP');

kerala_lat_indices = find(latitude >= lat_grid(1) & latitude <= lat_grid(end));
kerala_lon_indices = find(longitude >= lon_grid(1) & longitude <= lon_grid(end));

for j = 1:length(lat_grid)-1 % Adjust loop to stop before the last grid cell
    for k = 1:length(lon_grid)-1 % Adjust loop to stop before the last grid cell
        % Find the indices within the grid cell
        lat_indices = find(latitude(kerala_lat_indices) >= lat_grid(j) & latitude(kerala_lat_indices) < lat_grid(j+1));
        lon_indices = find(longitude(kerala_lon_indices) >= lon_grid(k) & longitude(kerala_lon_indices) < lon_grid(k+1));
        
        % Intersect the indices to get the relevant indices for both latitude and longitude
        relevant_indices = intersect(lat_indices, lon_indices);
        
        % Calculate the mean of CTP for the relevant indices
        if ~isempty(relevant_indices)
            grid_ctp(j, k) = mean(CTP(relevant_indices), 'omitnan');
        end
    end
end

figure;
pcolor(lon_grid, lat_grid, grid_ctp);
shading interp;
xlabel('Longitude');
ylabel('Latitude');
title('ctp Data');
