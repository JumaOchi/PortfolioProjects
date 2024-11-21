# File Sort
import os, shutil

path = r"C:/Users/360/Desktop/DataAnalysis/"
file_names = os.listdir(path)

folder_names =['csv files', 'excel files', 'sql files']
#Creating the folders if not present
for loop in range(0, 3) :
    if not os.path.exists(path + folder_names[loop]) :
        os.makedirs(path + folder_names[loop])

for file in file_names: 
    if ".csv" in file and not os.path.exists(path + "/csv files" + file):
        shutil.move(path + file, path + "csv files/" +file)
    elif ".xlsx" in file and not os.path.exists(path + "/csv files" + file):
        shutil.move(path + file, path + "excel files/" +file)
    elif ".sql" in file and not os.path.exists(path + "/csv files" + file):
        shutil.move(path + file, path + "sql files/" +file)
    else: 
        print("There were files in this path that were not moved")