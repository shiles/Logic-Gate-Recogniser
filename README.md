# Logic-Gate-Recogniser

A test app, being developed to test the feasibility of detecting logic gates draw with either a apple pencil or finger. 

The first attempt was implemented using CoreML, and can be found on the *machine-learning-test* branch. This used a model trained on using createML on drawings of the gates, which were input using the PencilKit framework. Accuracy with this quanity of drawings wasn't sufficient for the application. 

Currently implementing recognition through the point data using a custom drawing implementation.
