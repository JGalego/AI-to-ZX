5 REM DESCRIPTION: Train perceptrons on basic 2-input logic gates
6 REM CATEGORY: AI & Machine Learning
7 REM SOURCE: https://blog.lessaworld.com/2025/03/09/running-a-perceptron-on-an-8-bit-computer/

10 REM
20 REM Initialize variables
30 DIM weights(2) AS FLOAT: REM w0=bias, w1=weight1, w2=weight2
40 DIM inputs(4,2) AS FLOAT: REM Training data inputs
50 DIM targets(4) AS FLOAT: REM Expected outputs
60 DIM outputs(4) AS FLOAT: REM Actual outputs
70 REM
80 REM Learning parameters
90 DIM learningRate AS FLOAT: LET learningRate = 0.1
100 DIM maxEpochs AS UINTEGER: LET maxEpochs = 50
110 DIM epoch AS UINTEGER: LET epoch = 0
120 DIM totalError AS FLOAT: LET totalError = 1
130 REM
140 REM Declare working variables
150 DIM i AS UBYTE
155 DIM g AS UBYTE: REM Gate counter
160 DIM numGates AS UBYTE
165 DIM gateName AS STRING
170 DIM sum AS FLOAT
180 DIM err AS FLOAT
190 DIM finalOutput AS UBYTE
200 REM Setup training data
280 REM Read number of gates to process
285 READ numGates
290 REM PRINT "Training Perceptron on Multiple Logic Gates"
300 REM PRINT "==========================================="
310 PRINT "Processing "; numGates; " gates"
320 REM
325 REM Process each gate
330 FOR g = 1 TO numGates
335   REM Read gate name and training data
340   READ gateName
345   FOR i = 1 TO 4
350     READ inputs(i,1), inputs(i,2), targets(i)
360   NEXT i
370   PRINT: PRINT "##### "; gateName; " #####"
380   REM Reset variables for new gate
385   LET epoch = 0
390   LET totalError = 1
395   RANDOMIZE
400   LET weights(0) = (RND - 0.5) * 0.5
405   LET weights(1) = (RND - 0.5) * 0.5
410   LET weights(2) = (RND - 0.5) * 0.5
415   REM
420 REM Training loop
430 DO
440   LET epoch = epoch + 1
450   LET totalError = 0
480   REM
490   REM Process each training pattern
500   FOR i = 1 TO 4
510     REM Forward pass - calculate output
520     LET sum = weights(0) + weights(1) * inputs(i,1) + weights(2) * inputs(i,2)
530     REM
540     REM Activation function (step function)
550     IF sum >= 0 THEN
560       LET outputs(i) = 1
570     ELSE
580       LET outputs(i) = 0
590     END IF
600     REM
610     REM Calculate error
620     LET err = targets(i) - outputs(i)
630     LET totalError = totalError + ABS(err)
640     REM
650     REM Update weights if there's an error
660     IF err <> 0 THEN
670       LET weights(0) = weights(0) + learningRate * err
680       LET weights(1) = weights(1) + learningRate * err * inputs(i,1)
690       LET weights(2) = weights(2) + learningRate * err * inputs(i,2)
700     END IF
710   NEXT i
720   REM
730 LOOP WHILE totalError > 0 AND epoch < maxEpochs
740 REM
750 REM Final results for this gate
760 REM PRINT: PRINT "Training completed for "; gateName; "!"
770 REM PRINT "Final epoch: "; epoch
780 REM PRINT "Final error: "; totalError
790 REM
800 IF totalError = 0 THEN
810   PRINT: PRINT INK 4; "Perceptron learned "; gateName; "!"
820 ELSE
830   PRINT: PRINT INK 2; "Training stopped at max epochs"
840 END IF
850 REM
860 PRINT: PRINT "Linear Equation:"
870 PRINT INK 1; weights(0); " + "; weights(1); "*A"; " + "; weights(2); "*B"
880 REM
890 PRINT: PRINT "Truth table"
900 FOR i = 1 TO 4
910   REM Recalculate final outputs
920   LET sum = weights(0) + weights(1) * inputs(i,1) + weights(2) * inputs(i,2)
930   IF sum >= 0 THEN
940     LET finalOutput = 1
950   ELSE
960     LET finalOutput = 0
970   END IF
980   PRINT INK 1; inputs(i,1); " "; gateName; " "; inputs(i,2); " = "; finalOutput
990 NEXT i
1000 PAUSE 3*50
1010 NEXT g
1020 REM
1030 PRINT: PRINT "All gates training completed!"

9000 REM
9010 REM DATA format: numGates, then for each gate:
9020 REM gateName, followed by 4 lines of input1, input2, target
9030 DATA 5
9040 DATA "AND"
9050 DATA 0, 0, 0
9060 DATA 0, 1, 0
9100 DATA 1, 0, 0
9110 DATA 1, 1, 1
9120 DATA "OR"
9130 DATA 0, 0, 0
9140 DATA 0, 1, 1
9150 DATA 1, 0, 1
9160 DATA 1, 1, 1
9170 DATA "NOR"
9180 DATA 0, 0, 1
9190 DATA 0, 1, 0
9200 DATA 1, 0, 0
9210 DATA 1, 1, 0
9220 DATA "NAND"
9230 DATA 0, 0, 1
9240 DATA 0, 1, 1
9250 DATA 1, 0, 1
9260 DATA 1, 1, 0
9270 DATA "XOR"
9280 DATA 0, 0, 0
9290 DATA 0, 1, 1
9300 DATA 1, 0, 1
9310 DATA 1, 1, 0