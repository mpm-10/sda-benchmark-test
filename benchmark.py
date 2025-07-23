import os
import sys
import json
from datetime import datetime





def benchmarkOutput():
    outputsFolder : str = 'benchmarks'
    outputIndicator : str = 'benchmark'
    benchmarkData : dict = {}
    replaceTokens : list = ['"', '{', '}', ',']



    if not os.path.exists(outputsFolder):
        os.mkdir(outputsFolder)

    for line in sys.stdin:
        for token in replaceTokens:
            line = line.replace(token, '')

        line = line.strip()
        line = "".join(line.split())
        line = line.split(':')
        
        if line == [] or line == ['']:
            continue



        benchmarkKey : str = str(line.pop(0))
        benchmarkValue : str = str(line.pop(0))

        symbolIndex : int = benchmarkKey.find('_')
        if symbolIndex != -1:
            nextLetterIndex : int = symbolIndex + 1

            benchmarkKey = list(benchmarkKey)
            benchmarkKey[nextLetterIndex] = benchmarkKey[nextLetterIndex].upper()
            benchmarkKey.pop(symbolIndex)

            benchmarkKey = "".join(benchmarkKey)
        benchmarkData[benchmarkKey] = benchmarkValue

    

    actualMoment : datetime = datetime.now()
    actualMoment : str = actualMoment.strftime('%j%d%m%Y%H%M%S%f')

    outputFile : str = f'{outputsFolder}/{outputIndicator}_{actualMoment}.json'
    with open(outputFile, 'w') as benchmarkFile:
        json.dump(benchmarkData, benchmarkFile, ensure_ascii=False, indent=4)





if __name__ == '__main__':
    benchmarkOutput()