5 REM DESCRIPTION: Mandelbrot Explorer by Rob and Kenny > https://bunsen.itch.io/mandelbrot-explorer-by-rob-and-kenny
10 DIM p,q,t,x,y,x2,y2,r,c,d,e,g,h as FIXED:DIM z,f,w,k as Integer:DIM v,m as Byte: DIM a$(81):FOR i=1 TO 81:LET a$(i)=CHR$(32+i):NEXT i:CLS:LET l$=";"
20 LET d=-1: LET e=1: LET g=-2: LET h=1: LET z=22528:LET f=0:LET m=1
30 POKE 23659,0:PRINT AT 22,0;"Keys 5678  Space = Zoom ";m;"x";AT 0,0;:POKE 23659,2:LET p=(h-g)/31:LET q=(e-d)/21:IF m>2 THEN GOTO 20
40 FOR r=d TO e STEP q: FOR c=g TO h STEP p: LET x=0: LET y=0: LET i=1
50 LET x2=x*x: LET y2=y*y: IF x2+y2>4 OR i>70 THEN GOTO 80
60 LET o$=l$: LET l$=INKEY$:IF l$<>"" AND o$<>l$ THEN GOTO 90
70 LET t=x2-y2+c:LET y=2*x*y+r:LET x=t:LET i=i+1:GOTO 50
80 PRINT PAPER 7-i/10;a$(i);:NEXT c:NEXT r: GOTO 30
90 LET k=CODE l$:LET w=PEEK (z+f): LET w=((w>127)*(w-128))+(w<128)*w: POKE z+f,w: LET v=(k=56)-(k=53)+32*((k=54)-(k=55)):LET f=f+v: LET f=(f>=0 AND f<768)*f: LET w=PEEK(z+f):POKE z+f,w+128: IF l$<>" " THEN GOTO 70
100 LET m=m*2: LET p=(h-g)/4:LET q=(e-d)/4:LET y=INT(f/32):LET x=(f-(y*32)):LET x=g+x*(h-g)/32:LET x=g+(f-(y*32))*(h-g)/32:LET y=d+y*(e-d)/22:LET d=y-q:LET e=y+q:LET g=x-p:LET h=x+p: GOTO 30