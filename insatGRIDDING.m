folder = dir("*.h5");
lat_grid = 0:0.5:20;
lon_grid = 65:0.5:85;

% Preallocate grid_mat
grid_mat = zeros(length(lon_grid)-1, length(lat_grid)-1, length(folder));

for n = 1:length(folder)
    FILENAME = folder(n).name;
    Longitude = double(h5read(FILENAME,'/Longitude')).*0.01;
    Latitude = double(h5read(FILENAME,'/Latitude')).*0.01;
    CTP = h5read(FILENAME,'/CTP');
    
    for k = 1:length(lon_grid)-1
        for j = 1:length(lat_grid)-1
            if ~isempty(find(Longitude>lon_grid(k) & Longitude<=lon_grid(k+1) & Latitude>lat_grid(j) & Latitude<=lat_grid(j+1), 1))
                grid_mat(k,j,n) = mean(CTP(Longitude>lon_grid(k) & Longitude<=lon_grid(k+1) & Latitude>lat_grid(j) & Latitude<=lat_grid(j+1)),'omitnan');
            end
        end
    end
end

% Transpose grid_mat before plotting
grid_mat_transposed = permute(grid_mat, [2, 1, 3]);

% Plot the transposed grid_mat
figure;
pcolor(lon_grid(2:end), lat_grid(2:end), grid_mat_transposed(:,:,1)); % Assuming you want to plot the first dataset
shading interp;
xlabel('Longitude');
ylabel('Latitude');
title('CTP Data');