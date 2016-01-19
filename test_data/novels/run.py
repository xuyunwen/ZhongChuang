import sys,os,re

fh=open('zuo.txt')
ofh=None
skip=0
for line in fh:
    if skip:
        skip-=1
        continue
    m=re.match(r'^ *第(\w+)节：(.*)$', line)
    if m:
        print(m)
        if ofh:
            ofh.close()
        ofh=open(str.format('zuo/{0}_{1}.txt', m.group(1), m.group(2)),'w')
        skip=3 
    elif ofh:
        ofh.write(line)

if ofh:
    ofh.close()
        
