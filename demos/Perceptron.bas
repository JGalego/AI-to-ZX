5 REM DESCRIPTION: Perceptron learning a 2-input logic gate
6 REM CATEGORY: AI & Machine Learning
10 REM
20 REM Initialize variables
30 DIM weights(2) AS FLOAT: REM w0=bias, w1=weight1, w2=weight2
40 DIM inputs(4,2) AS FLOAT: REM Training data inputs
50 DIM targets(4) AS FLOAT: REM Expected outputs
60 DIM outputs(4) AS FLOAT: REM Actual outputs
70 REM
80 REM Learning parameters
90 DIM learningRate AS FLOAT: LET learningRate = 0.3
100 DIM maxEpochs AS UINTEGER: LET maxEpochs = 50
110 DIM epoch AS UINTEGER: LET epoch = 0
120 DIM totalError AS FLOAT: LET totalError = 1
130 REM
140 REM Declare working variables
150 DIM i AS UBYTE
160 DIM j AS UBYTE
170 DIM sum AS FLOAT
180 DIM err AS FLOAT
190 DIM finalOutput AS UBYTE
200 REM
210 REM Initialize weights with small random values
220 RANDOMIZE
230 LET weights(0) = (RND - 0.5) * 0.5: REM Bias weight
240 LET weights(1) = (RND - 0.5) * 0.5: REM Input 1 weight
250 LET weights(2) = (RND - 0.5) * 0.5: REM Input 2 weight
260 REM
270 REM Setup training data
280 REM Change these values to test different logic gates
290 PRINT "Training Perceptron..."
300 PRINT "====================="
310 REM
320 REM Training patterns: [input1, input2] -> output
330 LET inputs(1,1) = 0: LET inputs(1,2) = 0: LET targets(1) = 1
340 LET inputs(2,1) = 0: LET inputs(2,2) = 1: LET targets(2) = 1
350 LET inputs(3,1) = 1: LET inputs(3,2) = 0: LET targets(3) = 1
360 LET inputs(4,1) = 1: LET inputs(4,2) = 1: LET targets(4) = 0
370 REM
380 PRINT "Initial weights:"
390 PRINT "Bias: "; weights(0)
400 PRINT "W1: "; weights(1)
410 PRINT "W2: "; weights(2)
420 PRINT
430 REM
440 REM Training loop
450 DO
460   LET epoch = epoch + 1
470   LET totalError = 0
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
670       REM Debug: Show weight updates for first few epochs
680       IF epoch <= 3 THEN
690         PRINT "Pattern "; i; ": inputs("; inputs(i,1); ","; inputs(i,2); ") target="; targets(i); " output="; outputs(i); " err="; err
700       END IF
710       REM
720       LET weights(0) = weights(0) + learningRate * err
730       LET weights(1) = weights(1) + learningRate * err * inputs(i,1)
740       LET weights(2) = weights(2) + learningRate * err * inputs(i,2)
750     END IF
760   NEXT i
770   REM
780   REM Display progress every 5 epochs or when converged
790   IF epoch MOD 5 = 0 OR totalError = 0 OR epoch <= 3 THEN
800     PRINT "Epoch "; epoch; ": Error = "; totalError
810     PRINT "Weights - Bias: "; weights(0); " W1: "; weights(1); " W2: "; weights(2)
820     REM
830     REM Show current predictions
840     PRINT "Current outputs:"
850     FOR j = 1 TO 4
860       PRINT inputs(j,1); " "; inputs(j,2); " -> "; outputs(j); " (target: "; targets(j); ")"
870     NEXT j
880     PRINT
890   END IF
900   REM
910 LOOP WHILE totalError > 0 AND epoch < maxEpochs
920 REM
930 REM Final results
940 PRINT "Training completed!"
950 PRINT "Final epoch: "; epoch
960 PRINT "Final error: "; totalError
970 REM
980 IF totalError = 0 THEN
990   PRINT "SUCCESS: Perceptron learned the logic gate!"
1000 ELSE
1010  PRINT "Training stopped at max epochs"
1020 END IF
1030 REM
1040 PRINT
1050 PRINT "Final weights:"
1060 PRINT "Bias: "; weights(0)
1070 PRINT "W1: "; weights(1)
1080 PRINT "W2: "; weights(2)
1090 REM
1100 PRINT
1110 PRINT "Final truth table:"
1120 FOR i = 1 TO 4
1130   REM Recalculate final outputs
1140   LET sum = weights(0) + weights(1) * inputs(i,1) + weights(2) * inputs(i,2)
1150   IF sum >= 0 THEN
1160     LET finalOutput = 1
1170   ELSE
1180     LET finalOutput = 0
1190   END IF
1200   REM
1210   PRINT inputs(i,1); " OP "; inputs(i,2); " = "; finalOutput
1220 NEXT i
1230 REM
1240 PRINT
1250 PRINT "Perceptron demo completed!"
1260 PRINT "Note: XOR cannot be learned by a single perceptron"
1270 PRINT "as it is not linearly separable."