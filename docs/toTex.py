import os
import docutils.core
import requests
import re

if not os.path.isdir("tex"):
    os.makedirs("tex/")

if not os.path.isdir("tex/tmp"):
    os.makedirs("tex/tmp")

for file in os.listdir():
    if file[-4:] == ".rst":
        print(file)

        newFile = []

        with open(file,"r") as file1:

            f = [line for line in file1]

            removeParagraph = False
            fileCount = 0
            
            for i in range(len(f)):
                line = f[i]

                keepLine = True

                if "label" in line:
                    newFile[-1] = newFile[-1][:-1] + " \label{" + line[12:-1] + "}"
                    print(newFile[-1])
                    keepLine = False

                line = line.replace("&=","=")
                line = line.replace("& =","=")
                line = line.replace("& \equiv","\equiv")
                line = line.replace("& *","*")
                line = line.replace("&+","+")

                if "toctree" in line:
                    removeParagraph = True
                    keepLine = False
                
                if removeParagraph:
                    if line.startswith(" "):
                        keepLine = False
                    else:
                        removeParagraph = False

                if "figure" in line:
                    url = line[12:-1]
                    r = requests.get(url, allow_redirects=True)
                    newFileName = 'file_' + str(fileCount) + ".png"
                    fileCount += 1
                    with open("tex/" + newFileName, 'wb') as newImage:
                        newImage.write(r.content)
                    line = ".. figure:: " + newFileName

                if keepLine:
                    newFile.append(line)

        # Writing adapted rst file
        with open("tex/tmp/" + file,"w+") as file2:
            for i in newFile:
                file2.write(i)

        docutils.core.publish_file(source_path="tex/tmp/" + file,destination_path= "tex/tmp/" + file[:-4] + ".tex", writer_name="latex")
        #os.remove("tex/tmp_" + file)




for fileName in os.listdir("tex/tmp/"):
    if fileName.endswith(".tex"):


        #import codecs
        #BLOCKSIZE = 1048576 # or some other, desired size in bytes
        #with codecs.open("tex/" + fileName, "r", "iso-8859-1") as sourceFile:
        #    with codecs.open("tex/" + fileName, "w", "utf-8") as targetFile:
        #        while True:
        #            contents = sourceFile.read(BLOCKSIZE)
        #            if not contents:
        #                break
        #            targetFile.write(contents)


        file = open("tex/tmp/" + fileName, "r")

        newFileContent = []
        
        cpt = 0
        for line in file:

            keepLine = True

            print(fileName + " - " + str(cpt))
            cpt += 1
            if "\begin{equation}" in line:
                keepLine = False
            if "\end{equation}" in line:
                keepLine = FalseExo

            if keepLine:
                newFileContent.append(line)

        #os.remove("tex/" + fileName)
        newFile = open("tex/" + fileName, "w+")
        for line in newFileContent:
            newFile.write(line)
