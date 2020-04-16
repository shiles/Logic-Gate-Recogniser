# Logic-Gate-Recogniser

This project, written as part of my dissertation aims to explore building an educational tool for computer hardware. The goal is to recognise logic gates sketched to the canvas, build up a circuit by connecting recognised gates and providing input and output and finally simulating them using combinatorial and sequential logic. The seven base logic gates are supported: `Not, Or, Nor, And, Nand, Xor, Xnor` with two additional gates, `Input and Output` added to build circuits.

![](https://github.com/shiles/Logic-Gate-Recogniser/blob/master/screenshot.PNG?raw=true)

## Gate Sketching

Gates are sketched without their input and output pins. The recogniser will find the shapes which are adjacent to one another, then recognise those to gates after 1s of inactivity on the canvas. Shapes can be drawn in a single, or multiple strokes using the drawing tool. The link tool is used to draw inputs (1 for true, 0 for false) and outputs (square) as well as connections between gates. Connections are dirrectional, and loops are allowed. 

## Simulation

Once a circuit has been input, the run button will start the simulation, output gates show the different values in the computation and can be used as passthrough gates. The simulation will run until either stopped or until a stable circuit is found. If the circuit isn't valid, such as a gate missing a required input, the simulation will be aborted.