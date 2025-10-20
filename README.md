## airodump parser

This script reads airodump-ng csv files and:
- Automatically discards the entire client list and all APs without a valid ESSID.
- Prints a clean, machine-readable list in BSSID,ESSID format, ready for use in other tools.

### Usage
- Make it executable
```
chmod +x airodump-parser.sh
```

- Run it against one or more files

```
./airodump-parser.sh capture-01.csv
```

- Run against all CSVs and save to a new file

```
./airodump-parser.sh *.csv > targets.csv
```

### Example output:
```
00:AA:BB:CC:DD:EE,homeWifi
F4:5C:89:11:22:33,Guest-Network
```
