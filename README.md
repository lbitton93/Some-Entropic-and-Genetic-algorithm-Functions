# Some Entropic and Genetic Algorithm Functions

Here are some functions that I developed whilst I was at university. I'm working on de-cluttering as there are several functions that ended up being a dead end.

## Getting Started

I can't quite recall the specifics as I haven't used Matlab in a year, but there is an option to browse and add a new Path to your
environment, it's fairly intuitive.

## Prerequisites

MATLAB

## Mathsy details

Here I will explain some of the commonplace function arguments/matrices names and their representation:

'datavectors' : A 3D tensor
- This is a one hot encoded structure, where the i dimension represents the particular instance in the dataset
  the j dimension represents the particular variable / node $v$ in the graph and consequently its position in the adjacency 
  matrix. The k dimension is a one-hot encoding of the node's state that $v$ occupies at it's given M(i,j).
  
'datanumstates' : A 1D tensor
- This is an array that contains the number of possible states / categories for each node $v$ in the graph. It is arranged 
  such that the ith element corresponds with the ith element in the adjacency matrix, that is to preserve the corresponding 
  node order.
  
## Contributing

If you guys want to test and branch that would be great as it's fairly useless to me without access to MATLAB.

## Authors

* **Luke Bitton** - *Initial work* - (https://github.com/lbitton93)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

Do what thou wilt, but credit me ...

## Acknowledgments

Luis M. de Campos - A lot of these functions are based upon his work
