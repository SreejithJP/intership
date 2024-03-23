file_name="D:\project\insat 3dr\New folder\3RIMG_06MAR2024_0015_L2B_CTP_V01R00.h5";
lat_grid = 0:0.5:40;
lon_grid = 50:0.5:100;

grid_ctp(length(lat_grid),length(lon_grid))=NaN;


latitude = h5read(file_name, '/Latitude');
longitude = h5read(file_name, '/Longitude');
CTP = h5read(file_name, '/CTP');
kerala_lat_indices = find(latitude >= lat_grid(1) & latitude <= lat_grid(2));
kerala_lon_indices = find(longitude >= lon_grid(1) & longitude <= lon_grid(2));

res = [kerala_lat_indices; kerala_lon_indices];
for j = 1:length(lat_grid)
    for k = 1:length(lon_grid)
        grid_ctp(j, k) = nanmean(CTP(res));
    end
end
figure;
pcolor(lon_grid, lat_grid, grid_ctp); % No need to transpose grid_imc1
shading interp;
xlabel('Longitude');
ylabel('Latitude');
title('ctp Data');