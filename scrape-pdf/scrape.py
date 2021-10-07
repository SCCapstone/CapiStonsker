import json
import re


# reg: (\\n( )*){2,}) matches 3 consecutive
# reg: (\\n(?!(( )*\\n)+)) should match all single instances leaving one for 2 and 2 for 3
# reg: (\d){1,2}-(\d){1,2}  matches ##-## format without matching years

def editLine(line):
    # Removes newline characters at end
    line = line.strip()
    # Removes footnote references
    line = line.replace('*', '')
    line = line.replace('†', '')
    line = line.replace('‡', '')
    line = line.replace('§', '')
    # Replaces ? in GPS coordinates
    line = line.replace('?', '\'')
    # Fixes unicode
    line = line.replace('\u2019', '\'')
    return line


def coordinates(line):
    # GPS Coordinates: 34° 8.102' N, 82° 24.856' W
    line = line[17:]
    line = line.replace('°', ' ')
    line = line.replace('\'', ' ')
    line = line.replace(',', '')
    line = line.replace('’', '')
    line = line.replace('N', '')
    line = line.replace('W', '')
    line = line.split()
    # 34 8.102 N 82 24.856 W
    # Formulas: D.d = Degrees + (Minutes.m / 60)
    # Always N and W
    lat = int(line[0]) + (float(line[1]) / 60)
    lon = int(line[2]) + (float(line[3]) / 60)
    return (lat, lon)


# file = "South Carolina Historical Markers (8-19-21).pdf"
file = 'markers_information.txt'
f = open(file, "r")
lines = []
lines = f.readlines()
# output = []
json_out = []

county = ""
i = -1
skip = 0
length = len(lines)
startPattern = re.compile('^[0-9]')
digitsPattern = re.compile('^((\d){1,2}-(\d){1,3} )')

while (i < length - 1):
    i += 1
    line = lines[i]
    # Ignores footnotes (for now)
    if (line[0] == '*' or line[0] == '†' or line[0] == '‡' or line[0] == '§'):
        continue
    line = editLine(line)

    # Sets current county when found
    startsWDigit = startPattern.match(line)
    if (line[-6:] == "COUNTY" and startsWDigit == None):
        county = line

    # Matches start of entry digit-digit
    if (digitsPattern.match(line)):
        # Removes digits from name
        name = ' '.join((line.split())[1:])
        rel_loc = editLine(lines[i + 1])
        desc = editLine(lines[i + 2])
        skip = 2

        coord = editLine(lines[i + 3])
        if "GPS Coordinates:" in coord:
            gps = coordinates(coord)
            skip = 3
        else:
            gps = "No Coordinates"

        d = {
            "name": name,
            "rel_loc": rel_loc,
            "desc": desc,
            "gps": gps,
            "county": county
        }
        json_out.append(d)
        # output.append(d) #Test list of dictionaries (mid-step to json output)
        i += skip

# Print dictionary list
# for entry in output:
#    print(entry)

# JSON output code
with open('json_markers.json', 'w') as outfile:
    json.dump(json_out, outfile, indent=4)
