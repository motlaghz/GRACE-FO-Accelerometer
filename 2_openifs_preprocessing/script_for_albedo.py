# Python code for creating albedo variable out of tsr and tisr variables
import netCDF4 as nc
import numpy as np
import sys

indir = sys.argv[1] 
date = sys.argv[2]
hour = sys.argv[3]

# Open files
fn1 = '{0}/tisr_{1}_{2}hr_gnss.nc'.format(indir,date,hour)
ncin = nc.Dataset(fn1, 'r')
fn2 = '{0}/tsr_{1}_{2}hr_gnss.nc'.format(indir,date,hour)
ds2 = nc.Dataset(fn2, 'r')
 
# Nd arrays of variables
tisr = ncin['var212'][:]
tsr = ds2['var178'][:]

# We need these to make new file
tin = ncin.variables['time']
latitude = ncin.variables['lat']
longitude = ncin.variables['lon']

nlat = len(latitude)
nlon = len(longitude)

# New variable to store albedo with the same shape as tisr
albedo=np.zeros(((1,nlat,nlon)))

# Calculate albedo
for i in range(1):
    for j in range(nlat):
        for k in range(nlon):
            if tisr[i,j,k]==0:
                albedo[i,j,k]==0
            else:
                albedo[i,j,k] = (tisr[i,j,k]-tsr[i,j,k])/tisr[i,j,k]

# Open new dataset
ncfile = nc.Dataset('{0}/albedo_{1}_{2}hr_gnss.nc'.format(indir,date,hour),mode='w',format='NETCDF4_CLASSIC') 
lat_dim = ncfile.createDimension('lat', nlat)     # latitude axis
lon_dim = ncfile.createDimension('lon', nlon)    # longitude axis
time_dim = ncfile.createDimension('time', None)  # time infinite

lat = ncfile.createVariable('lat', np.float32, ('lat',))
lat.units = 'degrees_north'
lat.long_name = 'latitude'

lon = ncfile.createVariable('lon', np.float32, ('lon',))
lon.units = 'degrees_east'
lon.long_name = 'longitude'

time = ncfile.createVariable('time', np.float64, ('time',))
time.units = 'hours since 1800-01-01'
time.long_name = 'time'

# Define a 3D variable to hold the data
temp = ncfile.createVariable('temp',np.float64,('time','lat','lon')) # note: unlimited dimension is leftmost
temp.units = 'unitless'
temp.standard_name = 'albedo'

time[:] = tin[:]
lon[:] = longitude[:]
lat[:] = latitude[:]
temp[:,:,:] = albedo

# Close the nc files
ncin.close()
ncfile.close()
