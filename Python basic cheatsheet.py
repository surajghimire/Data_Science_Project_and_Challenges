# to read content of unknown functions

import inspect
lines = inspect.getsource(funct)
print(lines)

## or simply 

import inspect
print(inspect.getsource(funct))
