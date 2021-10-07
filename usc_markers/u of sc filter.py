import json
import types

# params
in_filename = "json_markers.json"
out_filename = "usc_markers.json"

file = open(in_filename)
data = json.load(file)
print(len(data))

# establish u sc campus
lat_range = [33.98767179499557, 34.001933667207275]
long_range = [81.02158830447807, 81.03502280074675]

# clean json
new_data = []
for marker in data:
    if isinstance(marker['gps'], list):
        new_data.append(marker)
data = new_data
print(len(data))

# filter
usc_markers = []
for marker in data:
    print(marker['gps'])
    if lat_range[0] < float(marker['gps'][0]) < lat_range[1] and \
            long_range[0] < float(marker['gps'][1]) < long_range[1]:
        usc_markers.append(marker)

with open(out_filename, 'w') as outfile:
    json.dump(usc_markers, outfile, indent=4)
