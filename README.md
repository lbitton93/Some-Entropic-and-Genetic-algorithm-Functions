# Some Entropic and Genetic Algorithm Functions

Here are some functions that I developed a year ago whilst I was at university. I'm currently in the process of cleaning up functions and assigning them to appropriate folders. I will then try and access Matlab to test, as there are some duplicates and superflous files.

## Getting Started

I can't quite recall the specifics as I haven't used Matlab in a year, but there is an option to browse and add a new Path to your
environment, it's fairly intuitive.

## Prerequisites

MATLAB

## Mathsy details

Here I will explain some of the commonplace function arguments/matrices names and their representation:

'datavectors' : A 3D tensor
- This is a one hot encoded structure, where the i dimension represents the particular instance in the dataset
  the j dimension represents the particular variable / node  in the graph and consequently its position in the adjacency 
  matrix. The k dimension is a one-hot encoding of the node's state that occupies at it's given M(i,j).
  
'datanumstates' : A 1D tensor
- This is an array that contains the number of states / categories for each node in the graph. It is arranged 
  such that the ith element corresponds with the ith element in the adjacency matrix, that is to preserve the corresponding 
  node order.

### Dictionary structure and functions

Since there is a lot of computation required to score each graph, I stored the results for different scoring regimes applied locally to all 2,3,4 vertex configurations, such that they can be called from memory. Obviously this makes the search way faster, at the expense of a days compiling in advance. Consequently, functions that call such sub functions can either use the dictionary version or the actual computation. Rather grotesquely I have just been swapping between each sub- function within the super function depending on my requirements. Hopefully if I get access to MATLAB again I can add an extra few args to the super functions such that this function call management is dealt with internally.

#### Function list with their type 

## Contributing

If you guys want to test and branch that would be great as it's fairly useless to me without access to MATLAB.

## Authors

* **Luke Bitton** - *Initial work* - (https://github.com/lbitton93)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

Do what thou wilt, but credit me ...

## Acknowledgments

Luis M. de Campos - A lot of these functions are based upon his work
